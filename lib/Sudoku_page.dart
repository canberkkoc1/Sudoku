import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sudoku/dil.dart';

final Map<String, int> sudokuLevel = {
  dil['seviye1']: 62,
  dil['seviye2']: 53,
  dil['seviye3']: 44,
  dil['seviye4']: 35,
  dil['seviye5']: 26,
  dil['seviye6']: 17,
};

class SudokuPage extends StatefulWidget {
  @override
  _SudokuPageState createState() => _SudokuPageState();
}

class _SudokuPageState extends State<SudokuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dil["sudoku_title"]),
      ),
      body: Center(
        child: Text(Hive.box('sudoku').get('seviye', defaultValue: 'kolat')),
      ),
    );
  }
}
