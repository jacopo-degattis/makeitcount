import 'package:flutter/material.dart';
import 'package:makeitcount/pages/home.dart';
import 'package:makeitcount/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: const CustomTheme(TextTheme()).light(),
      darkTheme: const CustomTheme(TextTheme()).dark(),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
