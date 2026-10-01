/// Matches 9mobile's old and current names: "9mobile", "etisalat" and "T2".
final RegExp _nineMobilePattern = RegExp(
  r'9\s*mobile|etisalat|\bt2\b',
  caseSensitive: false,
);

bool isNineMobile(String? raw) =>
    raw != null && _nineMobilePattern.hasMatch(raw);

/// Name to show in the UI. "9mobile" / "Etisalat" become "T2",
String displayBillerName(String? raw) {
  if (raw == null || raw.isEmpty) return raw ?? '';
  if (!isNineMobile(raw)) return raw;
  return raw.replaceAll(
    RegExp(r'9\s*mobile|etisalat', caseSensitive: false),
    'T2',
  );
}

/// Canonical network code for lookups (config maps, prefix detection).
String canonicalNetworkCode(String? code) {
  final c = (code ?? '').toUpperCase().trim();
  return (c == 'T2' || c == '9MOBILE' || c == 'ETISALAT') ? '9MOBILE' : c;
}
