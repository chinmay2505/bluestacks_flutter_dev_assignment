/// This file holds all the user input validation functions to be used
/// throughout the application

mixin ValidationMixin {
  bool isFieldEmpty(String fieldValue) => fieldValue.trim().isEmpty;

  bool isValidLoginInput(String input) {
    String _input = input.trim();
    return (_input.isNotEmpty) && (_input.length > 2) && (_input.length < 12);
  }
}
