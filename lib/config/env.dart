class Env {
  // TODO: move to --dart-define or .env handling in real apps
  static const supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://gynabnuzvndcxwcuttqh.supabase.co',
  );
  static const supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON',
    defaultValue:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imd5bmFibnV6dm5kY3h3Y3V0dHFoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTU5NjIyNTMsImV4cCI6MjA3MTUzODI1M30.3YKuVH6GNY1SGFJ6PIE9z6upxrEJeM-T_6Rw4fFi5qA',
  );
  static const oauthRedirectScheme = 'com.yourapp';
}
