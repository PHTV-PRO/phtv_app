import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phtv_app/screens/tabs_screen.dart';


final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.red,
  ),
  fontFamily: GoogleFonts.inter().fontFamily,
  textTheme: GoogleFonts.interTextTheme(),
);

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const TabsScreen(),
    );
  }
}