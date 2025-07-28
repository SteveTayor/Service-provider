import "dart:math" as math;

import "package:flutter/services.dart";
import "package:intl/intl.dart";

class CurrencyTextInputFormatter extends TextInputFormatter {
  CurrencyTextInputFormatter({
    this.locale = "en_US",
    this.symbol = "",
    this.decimalDigits = 2,
  }) : _numberFormat = NumberFormat.currency(
          locale: locale,
          symbol: symbol,
          decimalDigits: decimalDigits,
        );

  final String locale;
  final String symbol;
  final int decimalDigits;
  final NumberFormat _numberFormat;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // If nothing changed, just return same value
    if (oldValue.text == newValue.text) {
      return newValue;
    }

    // Remove all non-digit characters from newValue
    String newTextOnlyDigits = newValue.text.replaceAll(RegExp("[^0-9]"), "");
    if (newTextOnlyDigits.isEmpty) {
      // If user removed everything, we can just return empty
      return newValue.copyWith(
        text: "",
        selection: const TextSelection.collapsed(offset: 0),
      );
    }

    // Parse the numeric value, considering decimal digits
    double value = double.parse(newTextOnlyDigits) /
        (decimalDigits > 0 ? math.pow(10, decimalDigits) : 1);

    // Format the value using the NumberFormat
    final formattedText = _numberFormat.format(value);

    // Calculate the caret position
    // Generally, we want to move the caret to the end of the inserted/edited text.
    // But you can implement more sophisticated logic to keep caret
    //near the same relative position
    // if that is required.

    int cursorPositionFromRight = newValue.text.length - newValue.selection.end;
    int newCursorOffset = formattedText.length - cursorPositionFromRight;

    // Ensure the offset doesn't go out of bounds
    if (newCursorOffset > formattedText.length) {
      newCursorOffset = formattedText.length;
    } else if (newCursorOffset < 0) {
      newCursorOffset = 0;
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: newCursorOffset),
    );
  }
}
