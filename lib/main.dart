import 'package:flutter/material.dart';
import 'package:expense_app/expenses.dart';

// naming convention to use k to define global variable color name
var kColorScheme =
// variations of this color will be generated as the fore- and background
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(190, 102, 56, 195));

var kDarkColorScheme = ColorScheme.fromSeed(
    // set that the brightness of the color is to be optimized to dark mode
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(90, 186, 167, 221));

void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        // darkTheme may overwrites the Card design from the light mode
        // therefore copy the CardTheme from the light mode here
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.primaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kDarkColorScheme.secondaryContainer),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              // represents text in the appbar
              // headlineLarge: TextStyle(color: kDarkColorScheme.surface),
              headlineMedium: TextStyle(color: kDarkColorScheme.onSurface),
              // headlineSmall: TextStyle(color: kDarkColorScheme.surface),
              titleLarge: TextStyle(
                  color: kDarkColorScheme.onPrimaryContainer,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              titleMedium: TextStyle(
                  color: kDarkColorScheme.onPrimaryContainer, fontSize: 20),

              bodyLarge: TextStyle(color: kDarkColorScheme.onSurface),
              bodyMedium: TextStyle(color: kDarkColorScheme.onSurface),
              bodySmall: TextStyle(color: kDarkColorScheme.onSurface),
            ),
      ),

      // copying the existing theme from flutter
      // and then apply changes
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            // will overwrites text theme
            foregroundColor: kColorScheme.primaryContainer),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.primaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        ),
        // does not have copyWith() property, takes only style property
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              // represents text in the appbar
              titleLarge: TextStyle(
                  color: kColorScheme.onPrimaryContainer,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              titleMedium: TextStyle(
                  color: kColorScheme.onPrimaryContainer, fontSize: 20),
            ),
      ),
      themeMode: ThemeMode.dark,
      // default or force is to run on light/dark mode
      home: const Expenses(),
    ),
  );
}
