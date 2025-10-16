#include <Arduino.h>
#include <DHT.h>
#include <LiquidCrystal_I2C.h>
#include <Wire.h>
#include <Keypad.h>
#include <ESP32Servo.h>
#include <WiFi.h>
#include <ESPSupabase.h>
#include "time.h"

// ---------------------- إعدادات Supabase ----------------------
String supabase_url = "https://gjfxieuddmmykcpbijgs.supabase.co";
String anon_key = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdqZnhpZXVkZG1teWtjcGJpamdzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTY0NzM2NzEsImV4cCI6MjA3MjA0OTY3MX0.niSY2vR_rIO9xabKukEpqv3ZbcuRmcQ6_hYtKQrUm-Q";
Supabase db;
String table = "readings";

// ---------------------- إعدادات WiFi ----------------------
const char* ssid = "realme 5 Pro";
const char* psswd = "afmm1234";

// ---------------------- NTP ----------------------
const char* ntpServer = "pool.ntp.org";
const long gmtOffset_sec = 3 * 3600;
const int daylightOffset_sec = 0;

// ---------------------- Pins ----------------------
#define DHTPIN 5
#define DHTTYPE DHT11
#define WATER_PIN 34
#define RAIN_PIN 23
#define SERVO_PIN 4

LiquidCrystal_I2C lcd(0x27, 16, 2);
DHT dht(DHTPIN, DHTTYPE);
Servo myServo;

// ---------------------- Keypad ----------------------
const byte ROWS = 4;
const byte COLS = 4;

char keys[ROWS][COLS] = {
  {'1','2','3','A'},
  {'4','5','6','B'},
  {'7','8','9','C'},
  {'*','0','#','D'}
};

byte rowPins[ROWS] = {13, 12, 14, 27};
byte colPins[COLS] = {26, 25, 33, 32};

Keypad keypad = Keypad(makeKeymap(keys), rowPins, colPins, ROWS, COLS);

// ---------------------- Menu FSM ----------------------
enum State { MENU, RAIN_STATE, DHT_STATE, CONTAINER_STATE, SERVO_STATE };
State currentState = MENU;

String menuItems[] = {
  "RainSensor State",
  "DHT11 State",
  "Container State",
  "ServoMotor State"
};
int menuIndex = 0;

// ---------------------- Threshold ----------------------
const int WATER_THRESHOLD = 1800;

// ---------------------- Helpers ----------------------
String getTimeString() {
  struct tm timeinfo;
  if (!getLocalTime(&timeinfo)) {
    return "1970-01-01T00:00:00Z";
  }
  char buf[25];
  strftime(buf, sizeof(buf), "%Y-%m-%dT%H:%M:%SZ", &timeinfo);
  return String(buf);
}

void updateServo(int rain, int water) {
  if (rain == LOW) { // rain detected
    if (water > WATER_THRESHOLD) {
      myServo.write(0);
    } else {
      myServo.write(90);
    }
  } else {
    myServo.write(0);
  }
}

void showMenu() {
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("Menu");
  lcd.setCursor(0,1);
  lcd.print(menuItems[menuIndex]);
}

void showState() {
  lcd.clear();
  switch(currentState) {
    case RAIN_STATE: {
      int rain = digitalRead(RAIN_PIN);
      lcd.print("RainSensor State");
      lcd.setCursor(0,1);
      if (rain == LOW) lcd.print("Rain detected");
      else lcd.print("No Rain");
      break;
    }
    case DHT_STATE: {
      float temp = dht.readTemperature();
      float hum = dht.readHumidity();
      lcd.print("DHT11 State");
      lcd.setCursor(0,1);
      if (!isnan(temp)) {
        lcd.print("T:"); lcd.print(temp);
        lcd.print(" H:"); lcd.print(hum);
      } else lcd.print("No reading");
      break;
    }
    case CONTAINER_STATE: {
      int water = analogRead(WATER_PIN);
      lcd.print("Container State");
      lcd.setCursor(0,1);
      if (water > WATER_THRESHOLD) lcd.print("Full");
      else lcd.print("Not Full");
      break;
    }
    case SERVO_STATE: {
      lcd.print("ServoMotor");
      lcd.setCursor(0,1);
      lcd.print(myServo.read() == 90 ? "Opened" : "Closed");
      break;
    }
    default: break;
  }
}

// ---------------------- Setup ----------------------
void setup() {
  Serial.begin(115200);
  dht.begin();
  lcd.init();
  lcd.backlight();

  pinMode(WATER_PIN, INPUT);
  pinMode(RAIN_PIN, INPUT);

  myServo.attach(SERVO_PIN);
  myServo.write(0);

  lcd.setCursor(0,0);
  lcd.print("Menu");
  lcd.setCursor(0,1);
  lcd.print(menuItems[menuIndex]);

  Serial.print("Connecting to WiFi");
  WiFi.begin(ssid, psswd);
  while (WiFi.status() != WL_CONNECTED) {
    delay(200);
    Serial.print(".");
  }
  Serial.println("\nConnected!");
  Serial.print("IP Address: ");
  Serial.println(WiFi.localIP());

  // Supabase init
  db.begin(supabase_url, anon_key);

  // NTP init
  configTime(gmtOffset_sec, daylightOffset_sec, ntpServer);
}

// ---------------------- Loop ----------------------
void loop() {
  float temp = dht.readTemperature();
  float hum = dht.readHumidity();
  int water = analogRead(WATER_PIN);
  int rain = digitalRead(RAIN_PIN);

  updateServo(rain, water);

  // JSON payload
  String JSON_payload = "{";
  JSON_payload += "\"time\":\"" + getTimeString() + "\",";
  JSON_payload += "\"temperature\":" + String(temp, 1) + ",";
  JSON_payload += "\"humidity\":" + String(hum, 1) + ",";
  JSON_payload += "\"water_level\":" + String(water) + ",";
  JSON_payload += "\"rain_detected\":"; 
  JSON_payload += (rain == LOW ? "true" : "false");
  JSON_payload += "}";

  static unsigned long lastSend = 0;
  if (millis() - lastSend > 3000 && WiFi.status() == WL_CONNECTED) { // كل 3 ثواني
    lastSend = millis();

    int httpCode = db.insert(table, JSON_payload, true);
    if (httpCode == 201) {
      Serial.println("✅ Inserted into Supabase!");
    } else {
      Serial.print("❌ Failed Supabase, HTTP Code: ");
      Serial.println(httpCode);
    }
  }

  // keypad menu logic
  char key = keypad.getKey();
  if (key) {
    if (currentState == MENU) {
      if (key == '#') {
        menuIndex = (menuIndex + 1) % 4;
        showMenu();
      } else if (key == '*') {
        menuIndex = (menuIndex - 1 + 4) % 4;
        showMenu();
      } else if (key == 'D') {
        currentState = (State)(menuIndex + 1);
      }
    } else {
      if (key == 'B') {
        currentState = MENU;
        showMenu();
      }
    }
    if (currentState != MENU) showState();
    else showMenu();
  }

  if (!key && currentState != MENU) {
    showState();
  }

  delay(100);
}
