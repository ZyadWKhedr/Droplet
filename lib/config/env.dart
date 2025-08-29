class Env {
  // TODO: move to --dart-define or .env handling in real apps
  static const supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://gjfxieuddmmykcpbijgs.supabase.co',
  );
  static const supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON',
    defaultValue:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdqZnhpZXVkZG1teWtjcGJpamdzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTY0NzM2NzEsImV4cCI6MjA3MjA0OTY3MX0.niSY2vR_rIO9xabKukEpqv3ZbcuRmcQ6_hYtKQrUm-Q',
  );
  static const oauthRedirectScheme = 'com.yourapp';
}
