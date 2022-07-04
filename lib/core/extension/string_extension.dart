extension ValidatorExtension on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool isValidName() {
    return RegExp(r"^[\p{L} ,.'-]*$",
            unicode: true, dotAll: true, caseSensitive: false)
        .hasMatch(this);
  }

  bool isValidNumber() {
    return RegExp(r'^[0-9]+$',
            dotAll: true, unicode: true, caseSensitive: false)
        .hasMatch(this);
  }
}
