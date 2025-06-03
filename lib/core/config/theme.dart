// import 'package:flutter/material.dart';

// /// App theme configuration
// class AppTheme {
//   /// Private constructor to prevent direct instantiation
//   AppTheme._();

//   /// Primary color swatch
//   static const MaterialColor primarySwatch = Colors.blue;

//   /// Primary color
//   static const Color primaryColor = Color(0xFF2196F3);

//   /// Secondary color
//   static const Color secondaryColor = Color(0xFF03DAC6);

//   /// Error color
//   static const Color errorColor = Color(0xFFB00020);

//   /// Background color
//   static const Color backgroundColor = Colors.white;

//   /// Surface color
//   static const Color surfaceColor = Colors.white;

//   /// Text color
//   static const Color textColor = Color(0xFF000000);

//   /// Light theme
//   static final ThemeData lightTheme = ThemeData(
//     useMaterial3: true,
//     primarySwatch: primarySwatch,
//     primaryColor: primaryColor,
//     colorScheme: const ColorScheme.light(
//       primary: primaryColor,
//     ),
//     scaffoldBackgroundColor: backgroundColor,
//     appBarTheme: const AppBarTheme(
//       backgroundColor: primaryColor,
//       foregroundColor: Colors.white,
//       elevation: 0,
//     ),
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: primaryColor,
//         foregroundColor: Colors.white,
//         minimumSize: const Size(88, 48),
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
//     ),
//     textButtonTheme: TextButtonThemeData(
//       style: TextButton.styleFrom(
//         foregroundColor: primaryColor,
//         minimumSize: const Size(88, 48),
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//       ),
//     ),
//     inputDecorationTheme: InputDecorationTheme(
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//       filled: true,
//       fillColor: Colors.grey[100],
//     ),
//   );

//   /// Dark theme
//   static final ThemeData darkTheme = ThemeData(
//     useMaterial3: true,
//     primarySwatch: primarySwatch,
//     primaryColor: primaryColor,
//     colorScheme: const ColorScheme.dark(
//       primary: primaryColor,
//       error: errorColor,
//       surface: Color(0xFF1E1E1E),
//       onPrimary: Colors.white,
//       onError: Colors.white,
//     ),
//     scaffoldBackgroundColor: const Color(0xFF121212),
//     appBarTheme: AppBarTheme(
//       backgroundColor: Colors.grey[900],
//       foregroundColor: Colors.white,
//       elevation: 0,
//     ),
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: primaryColor,
//         foregroundColor: Colors.white,
//         minimumSize: const Size(88, 48),
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
//     ),
//     textButtonTheme: TextButtonThemeData(
//       style: TextButton.styleFrom(
//         foregroundColor: primaryColor,
//         minimumSize: const Size(88, 48),
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//       ),
//     ),
//     inputDecorationTheme: InputDecorationTheme(
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//       filled: true,
//       fillColor: Colors.grey[800],
//     ),
//   );
// }
