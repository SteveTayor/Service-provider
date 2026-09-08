/// Masks phone number for display, e.g.
/// "08012345678" -> "080••••5678". Keeps the first 3 and last 4 digits,
/// masking whatever's in between. Falls back to the original string for
/// anything shorter than 8 characters rather than producing nonsense.
String maskPhoneNumber(String phone) {
  final digits = phone.trim();
  if (digits.length < 8) return digits;
  final start = digits.substring(0, 3);
  final end = digits.substring(digits.length - 4);
  return '$start••••$end';
}
