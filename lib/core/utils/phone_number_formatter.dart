import 'package:flutter/services.dart';

class NumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var newText = newValue.text.toLowerCase(); // Always lowercase
    // Allow only letters, numbers, underscore, and dot
    final validChars = RegExp(r"^[0-9]*$");
    // final validChars = RegExp(r"^[1-9][0-9]*$");

    if (!validChars.hasMatch(newText)) {
      return oldValue; // If the new input is invalid, return the old value
    }

    return newValue.copyWith(text: newText);
  }
}
