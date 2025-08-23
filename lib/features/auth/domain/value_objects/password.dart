class Password {
  final String value;

  Password(this.value) {
    if (value.isEmpty) {
      throw ArgumentError('Password cannot be empty');
    }
    if (value.length < 8) {
      throw ArgumentError('Password must be at least 8 characters long');
    }
    if (!_isValid(value)) {
      throw ArgumentError(
        'Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character',
      );
    }
  }

  bool _isValid(String v) {
    // Regex patterns:
    // ^(?=.*[a-z])    - at least one lowercase letter
    // (?=.*[A-Z])     - at least one uppercase letter
    // (?=.*\d)        - at least one digit
    // (?=.*[@$!%*?&]) - at least one special character
    // [A-Za-z\d@$!%*?&]{8,} - minimum 8 characters of the allowed types
    return RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    ).hasMatch(v);
  }
}
