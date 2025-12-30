// ignore_for_file: lines_longer_than_80_chars

import 'package:intl/intl.dart';

extension StringFormatting on String {
  String formatAsToken() {
    // Remove any existing spaces or non-digits
    String digitsOnly = replaceAll(RegExp(r'\D'), '');

    // Insert space every 4 digits
    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < digitsOnly.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(digitsOnly[i]);
    }
    return buffer.toString();
  }
}

extension CharacterValidation on String {
  bool containsUpper() {
    for (var i = 0; i < length; i++) {
      final code = codeUnitAt(i);
      if (code >= 65 && code <= 90) return true;
    }
    return false;
  }

  bool containsLower() {
    for (var i = 0; i < length; i++) {
      final code = codeUnitAt(i);
      if (code >= 97 && code <= 122) return true;
    }
    return false;
  }

  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  bool containsSpecialChar() {
    for (var i = 0; i < length; i++) {
      final char = this[i];
      if (r'#?!@$%^&*-_.,/[]{}|;:+='.contains(char)) return true;
    }
    return false;
  }

  bool containsUsernameSpecial() {
    for (var i = 0; i < length; i++) {
      final char = this[i];
      // ignore: prefer_single_quotes
      if (r"#?!@$%^&*,/[]{}|;:+=".contains(char)) return true;
    }
    return false;
  }

  bool containsNumber() {
    for (var i = 0; i < length; i++) {
      final code = codeUnitAt(i);
      if (code >= 48 && code <= 57) return true;
    }
    return false;
  }

  String reArrangeDOB(String pattern, [String newPattern = '-']) {
    return split(pattern).reversed.join(newPattern);
  }

  String get capitalizeFirst {
    return isNotEmpty ? this[0].toUpperCase() + substring(1) : this;
  }

  String get capiTalizeFirstLast {
    return this[0].toUpperCase() + substring(1);
  }

  String get capitalizeFullname {
    if (isEmpty) return this;

    final words = split(' ');
    for (var i = 0; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        words[i] = words[i][0].toUpperCase() + words[i].substring(1);
      }
    }

    return words.join(' ');
  }

  String get firstName {
    return split(' ').first;
  }

  String get obscuredMail {
    var newString = '';
    final emailList = split('');
    for (var i = 0; i < emailList.length; i++) {
      if (i != 0 && emailList[i] != '@' && i < indexOf('.')) {
        emailList[i] = '*';
        newString = emailList.join();
      }
    }
    return newString;
  }

  String get initials {
    final name = split(' ');

    if (name.isEmpty || name[0].isEmpty) return '';

    if (name.length > 1) {
      final firstInitial = name[0].isNotEmpty ? name[0][0] : '';
      final secondInitial = name[1].isNotEmpty ? name[1][0] : '';
      return '$firstInitial$secondInitial'.toUpperCase();
    }

    // If the name has only one word and is long enough, return the second letter
    return name[0].length > 1 ? name[0][1].toUpperCase() : '';
  }

  String removeCommas() {
    if (contains(',')) {
      return replaceAll(',', '');
    } else {
      return this;
    }
  }

  String get first10Characters {
    if (length <= 10) {
      return this;
    }
    return '${substring(0, 10)}...';
  }

  DateTime? toDateTime() {
    try {
      // Parse ISO 8601 format (e.g., 2025-07-06T21:24:38.000000Z)
      return DateTime.parse(this).toLocal();
    } catch (e) {
      try {
        // Fallback to DD-MM-YYYY format
        return DateFormat('dd-MM-yyyy').parse(this);
      } catch (e) {
        try {
          // Fallback to DD/MM/YYYY format
          return DateFormat('dd/MM/yyyy').parse(this);
        } catch (e) {
          print('Date parse error: $e for $this'); // Debug
          return null;
        }
      }
    }
  }

  String toFullDateString() {
    try {
      final dt = toDateTime() ?? DateTime.now();
      const months = [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December'
      ];
      final month = months[dt.month - 1];
      final day = dt.day;
      final year = dt.year;
      final ordinal = _getOrdinal(day);
      return '$month $day$ordinal, $year';
    } catch (e) {
      print('Error formatting date $this: $e');
      final now = DateTime.now();
      final month = _getMonthName(now.month);
      final day = now.day;
      final year = now.year;
      final ordinal = _getOrdinal(day);
      return '$month $day$ordinal, $year';
    }
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }

  String _getOrdinal(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  String removePlus() {
    return startsWith('+') ? substring(1) : this;
  }

  double toNumericValue() {
    final cleaned = replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(cleaned) ?? 0.0;
  }
}
