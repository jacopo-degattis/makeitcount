import 'package:flutter/material.dart';
import 'package:makeitcount/pages/home/home.dart';
import 'package:makeitcount/theme.dart';
import 'package:makeitcount/util.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    TextTheme textTheme =
        createTextTheme(context, "Playfair Display", "Playfair Display");
    CustomTheme theme = CustomTheme(textTheme);

    return MaterialApp(
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
