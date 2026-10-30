import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:meals_app/screens/tabs.dart';

// app wide theme, dark mode with a brown seed color and lato font
final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0), 
  ),
  textTheme: GoogleFonts.latoTextTheme(), 
);

// starting point of the app
void main() {
  // provider scope lets every screen read the riverpod providers
  runApp(const ProviderScope(child: App())); // boots up our app widget
}

// root widget that sets up the theme and first screen
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // hides the red debug banner so it doesn't cover the app bar buttons
      theme: theme,
      home: const TabsScreen(), 
    );
  }
}
