class Email {
  final String value;
  Email(this.value) {
    if (!_isValid(value)) throw ArgumentError('Invalid email');
  }
  bool _isValid(String v) => RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(v);
}
