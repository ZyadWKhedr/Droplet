# 🌦️ Smart Environmental Monitoring System (ESP32 + Supabase)

This project is an **IoT-based environmental monitoring system** built with **ESP32**, designed to measure and record **temperature**, **humidity**, **rain**, and **water level**.  
The collected data is displayed on an **LCD screen**, controlled via a **keypad**, and uploaded in real-time to a **Supabase database** over Wi-Fi.  
It also includes an **automatic servo control system** based on rain and water-level conditions.

## 🚀 Features

- 🌡️ Reads **temperature** and **humidity** using a DHT11 sensor  
- 💧 Monitors **rain detection** and **water level**  
- ⚙️ Automatically controls a **servo motor** depending on the environment  
- 📟 Interactive **menu system** via a 4x4 keypad and LCD display  
- ☁️ Sends data to a **Supabase** database every 3 seconds  
- ⏰ Synchronizes timestamps using **NTP (Network Time Protocol)**  
- 📶 Connects to Wi-Fi and uploads readings in **JSON** format  

## 🧠 Hardware Components

| Component | Description |
|------------|-------------|
| ESP32 | Main microcontroller with Wi-Fi |
| DHT11 Sensor | Measures temperature and humidity |
| Water Level Sensor | Reads analog water level values |
| Rain Sensor | Detects rainfall |
| Servo Motor | Opens/closes a mechanism automatically |
| LCD 16x2 (I2C) | Displays menu and sensor data |
| Keypad 4x4 | Used to navigate between menus |
| Jumper Wires | For connections |
| Breadboard | Optional for prototyping |

## 🔌 Pin Configuration

| Component | Pin |
|------------|-----|
| DHT11 | GPIO 5 |
| Water Level Sensor | GPIO 34 |
| Rain Sensor | GPIO 23 |
| Servo Motor | GPIO 4 |
| Keypad Rows | 13, 12, 14, 27 |
| Keypad Columns | 26, 25, 33, 32 |
| LCD (I2C) | 0x27 Address (uses SDA & SCL) |

## 🧰 Libraries Used

```cpp
#include <Arduino.h>
#include <DHT.h>
#include <LiquidCrystal_I2C.h>
#include <Wire.h>
#include <Keypad.h>
#include <ESP32Servo.h>
#include <WiFi.h>
#include <ESPSupabase.h>
#include "time.h"
```

## ⚙️ Configuration

### 🔑 Supabase Setup
```cpp
String supabase_url = "https://YOUR-PROJECT.supabase.co";
String anon_key = "YOUR-ANON-KEY";
String table = "readings";
```

### 📶 Wi-Fi Setup
```cpp
const char* ssid = "YOUR_WIFI_SSID";
const char* psswd = "YOUR_WIFI_PASSWORD";
```

## 🕹️ How It Works

### 1. Startup
- Connects to Wi-Fi and initializes all sensors and LCD.
- Synchronizes time using NTP.

### 2. Menu Navigation
Use the **4x4 keypad**:
- `#` → Next menu item  
- `*` → Previous menu item  
- `D` → Select  
- `B` → Back to menu  

### 3. Display Options
You can view:
- 🌧️ Rain sensor status  
- 🌡️ DHT11 temperature & humidity readings  
- 💧 Water container level  
- ⚙️ Servo motor state  

### 4. Data Upload
Every 3 seconds, the ESP32 sends a JSON payload to Supabase:
```json
{
  "time": "2025-10-16T21:45:00Z",
  "temperature": 28.5,
  "humidity": 61.3,
  "water_level": 1842,
  "rain_detected": true
}
```

### 5. Servo Control
- Closes when rain is detected or water tank is full  
- Opens when safe (no rain and low water level)

## 🧑‍💻 Author
**Developed by:** *Mariam Osama*  
💡 For educational and IoT experimentation purposes.
