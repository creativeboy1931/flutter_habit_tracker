class Validators {
  const Validators._();

  static validateEmptyText(String? s, String? value) {
    if (value == null || value.isEmpty) {
      return "$s is required.";
    }
    return null;
  }
}
