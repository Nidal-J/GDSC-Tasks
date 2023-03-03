import 'package:flutter/material.dart';
import 'package:gdsc_tasks/screens/animated_list_screen.dart';
import 'package:gdsc_tasks/screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
        theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(double.maxFinite, 50),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(double.maxFinite, 50),
            ),
          ),
        ),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/animated_list': (context) => const AnimatedListScreen(),
        },
      );
    });
  }
}
