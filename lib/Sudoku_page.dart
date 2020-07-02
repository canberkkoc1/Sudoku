import 'package:flutter/material.dart';
import 'package:sudoku/dil.dart';

class SudokuPage extends StatefulWidget{
  @override
  _SudokuPageState createState() => _SudokuPageState();

}

class _SudokuPageState extends State<SudokuPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:Text(dil["sudoku_title"]),
      ),
      body: Center(),
    );
  }
}

