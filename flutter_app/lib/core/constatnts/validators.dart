class Validators {
  // Regex patterns
  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  static final _usernameRegex = RegExp(r'^[a-zA-Z0-9_]{3,20}$');

  // Validation methods
  static String? validateEmail(String? value, {bool isRequired = true}) {
    if (isRequired && (value == null || value.isEmpty)) {
      return 'Please enter your email address';
    }

    if (value != null && value.isNotEmpty && !_emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address (e.g., user@example.com)';
    }

    return null;
  }

  static String? validatePassword(String? value, {bool isRequired = true}) {
    if (isRequired && (value == null || value.isEmpty)) {
      return 'Please enter your password';
    }

    if (value != null && value.isNotEmpty) {
      if (value.length < 8) {
        return 'Password must be at least 8 characters long';
      }
      if (!value.contains(RegExp(r'[A-Z]'))) {
        return 'Password must contain at least one uppercase letter';
      }
      if (!value.contains(RegExp(r'[a-z]'))) {
        return 'Password must contain at least one lowercase letter';
      }
      if (!value.contains(RegExp(r'[0-9]'))) {
        return 'Password must contain at least one number';
      }
      if (!value.contains(RegExp(r'[@$!%*?&]'))) {
        return 'Password must contain at least one special character (@\$!%*?&)';
      }
    }

    return null;
  }

  static String? validateUsername(String? value, {bool isRequired = true}) {
    if (isRequired && (value == null || value.isEmpty)) {
      return 'Please enter a username';
    }

    if (value != null && value.isNotEmpty) {
      if (value.length < 3) {
        return 'Username must be at least 3 characters long';
      }
      if (value.length > 20) {
        return 'Username cannot exceed 20 characters';
      }
      if (!_usernameRegex.hasMatch(value)) {
        return 'Username can only contain letters, numbers, and underscores';
      }
    }

    return null;
  }

  static String? validateConfirmPassword(
    String? password,
    String? confirm, {
    bool isRequired = true,
  }) {
    if (isRequired && (confirm == null || confirm.isEmpty)) {
      return 'Please confirm your password';
    }

    if (confirm != null && confirm.isNotEmpty && password != confirm) {
      return 'Passwords do not match';
    }

    return null;
  }

  // Additional validators
  static String? validateName(
    String? value, {
    bool isRequired = true,
    String fieldName = 'Name',
  }) {
    if (isRequired && (value == null || value.isEmpty)) {
      return 'Please enter your $fieldName';
    }

    if (value != null && value.isNotEmpty) {
      if (value.length < 2) {
        return '$fieldName must be at least 2 characters long';
      }
      if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
        return '$fieldName can only contain letters and spaces';
      }
    }

    return null;
  }

  static String? validatePhoneNumber(String? value, {bool isRequired = true}) {
    if (isRequired && (value == null || value.isEmpty)) {
      return 'Please enter your phone number';
    }

    if (value != null && value.isNotEmpty) {
      final cleaned = value.replaceAll(RegExp(r'[^\d+]'), '');
      if (cleaned.length < 10) {
        return 'Please enter a valid phone number';
      }
    }

    return null;
  }

  static String? validateNotEmpty(
    String? value, {
    String fieldName = 'This field',
    bool isRequired = true,
  }) {
    if (isRequired && (value == null || value.isEmpty)) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? validateLength(
    String? value, {
    int min = 0,
    int max = 255,
    String fieldName = 'Field',
    bool isRequired = true,
  }) {
    final emptyError = validateNotEmpty(
      value,
      fieldName: fieldName,
      isRequired: isRequired,
    );
    if (emptyError != null) return emptyError;

    if (value != null) {
      if (min > 0 && value.length < min) {
        return '$fieldName must be at least $min characters long';
      }
      if (max < 255 && value.length > max) {
        return '$fieldName cannot exceed $max characters';
      }
    }

    return null;
  }

  // Bulk validation method
  static Map<String, String?> validateForm(Map<String, dynamic> fields) {
    final errors = <String, String?>{};

    for (final entry in fields.entries) {
      switch (entry.key) {
        case 'email':
          errors[entry.key] = validateEmail(entry.value);
          break;
        case 'password':
          errors[entry.key] = validatePassword(entry.value);
          break;
        case 'username':
          errors[entry.key] = validateUsername(entry.value);
          break;
        case 'confirmPassword':
          final password = fields['password'];
          errors[entry.key] = validateConfirmPassword(password, entry.value);
          break;
        case 'firstName':
        case 'lastName':
          errors[entry.key] = validateName(entry.value, fieldName: entry.key);
          break;
        case 'phone':
          errors[entry.key] = validatePhoneNumber(entry.value);
          break;
        default:
          errors[entry.key] = validateNotEmpty(
            entry.value,
            fieldName: entry.key,
          );
      }
    }

    return errors;
  }

  // Helper method to check if form is valid
  static bool isFormValid(Map<String, String?> errors) {
    return errors.values.every((error) => error == null);
  }
}
