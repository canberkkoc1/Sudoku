import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:sudoku/Entry_page.dart';
import 'dil.dart';

void main() async {
  await Hive.initFlutter(
      'sudokuDoc'); //Future method use await / Hive is a database...
  // Box => sql table
  await Hive.openBox('settings');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box('settings').listenable(keys: [
        'dark_Theme',
        'dil'
      ]), // veriden neleri dinleyeceğimizi bunlar değiştiğinde uygulamanın tamımının değişeceği içn
      builder: (context, kutu, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: kutu.get('dark_Theme', defaultValue: false)
              ? ThemeData.dark()
              : ThemeData.light(),
          // theme: ThemeData(textTheme: GoogleFonts.abelTextTheme),=>> Uygulamanın her yerinde yazı teması değişir....
          home: EntryPage(),
        );
      },
    );
  }
}
