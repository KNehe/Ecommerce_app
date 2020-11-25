class Validator {
  static bool isPostalCodeValid(String postalCode) {
    return RegExp(r"^(^\d{5}$)|(^\d{5}-\d{4}$)$").hasMatch(postalCode);
  }

  static bool isPhoneNumberValid(String phoneNumber) {
    return RegExp(r"([\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6})")
        .hasMatch(phoneNumber);
  }

  static bool isEmailValid(String email) {
    return RegExp(r"\S+@\S+\.\S+").hasMatch(email);
  }
}
