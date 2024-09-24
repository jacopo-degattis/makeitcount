import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makeitcount/db.dart';
import 'package:makeitcount/screens/home/home.dart';
import 'package:makeitcount/screens/see-all/see-all.dart';
import 'package:makeitcount/state/models/movement.model.dart';
import 'package:makeitcount/state/providers/database/objectbox.provider.dart';
import 'package:makeitcount/theme.dart';
import 'package:makeitcount/util.dart';

late ObjectBoxDatabase objectBox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBoxDatabase.create();

  // objectBox.store.box<MovementModel>().removeAll();

  runApp(ProviderScope(
      overrides: [databaseProvider.overrideWithValue(objectBox)],
      child: const MyApp()));
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
      // home: const HomePage(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomePage(),
        '/see-all': (context) => const SeeAll()
      },
    );
  }
}
