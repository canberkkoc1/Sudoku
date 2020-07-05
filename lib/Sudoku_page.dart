import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sudoku/dil.dart';
import 'package:sudoku/sudoks.dart';
import './Sudoku_page.dart';

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
  final List ornekSudoku =
      List.generate(9, (i) => List.generate(9, (j) => j + 1));
  final Box _sudokuBox = Hive.box('sudoku');
  List _sudoku = [];
  String _sudokuString;
  void _sudokuOlustur() {
    int viewsNumbers =
        sudokuLevel[_sudokuBox.get('seviye', defaultValue: dil['seviye2'])];

    _sudokuString = sudokular[Random().nextInt((sudokular.length))];

    _sudoku = List.generate(
        9,
        (i) => List.generate(
            9,
            (j) => int.tryParse(
                _sudokuString.substring(i * 9, (i + 1) * 9).split('')[j])));

    int i = 0;

    while (i < 81 - viewsNumbers) {
      int x = Random().nextInt(9);
      int y = Random().nextInt(9);
      if (_sudoku[x][y] != 0) {
        _sudoku[x][y] = 0;
        i++;

        print(_sudoku[x][y] = 0);
      }
    }

    print(viewsNumbers);
    print(_sudokuString);
  }

  @override
  void initState() {
    _sudokuOlustur();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent[100],
      appBar: AppBar(
        title: Text(dil["sudoku_title"]),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(_sudokuBox.get('seviye', defaultValue: dil['seviye2'])),
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: Colors.greenAccent[100],
                padding: EdgeInsets.all(4.0),
                child: Column(
                  children: <Widget>[
                    for (int x = 0; x < 9; x++)
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  for (int y = 0; y < 9; y++)
                                    Expanded(
                                      // Expanded bulduğu bütün boşluğu doldurur bu yüzden alanları belirlemek gerekir.
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.all(1.0),
                                              color: Colors.orange[200],
                                              alignment: Alignment.center,
                                              child: Text(_sudoku[x][y] > 0
                                                  ? _sudoku[x][y].toString()
                                                  : ('')),
                                            ),
                                          ),
                                          if (y == 2 || y == 5)
                                            SizedBox(
                                              width: 5,
                                            )
                                        ],
                                      ),
                                    )
                                ],
                              ),
                            ),
                            if (x == 2 || x == 5)
                              SizedBox(
                                height: 5,
                              )
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Card(
                                child: Container(
                                  margin: EdgeInsets.all(3.0),
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Card(
                                child: Container(
                                  margin: EdgeInsets.all(3.0),
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Card(
                                child: Container(
                                  margin: EdgeInsets.all(3.0),
                                  color: Colors.teal,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Card(
                                child: Container(
                                  margin: EdgeInsets.all(3.0),
                                  color: Colors.teal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        for (int i = 1; i < 10; i += 3)
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                for (int j = 0; j < 3; j++)
                                  Expanded(
                                    child: Card(
                                      color: Colors.blue[300],
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          print("${i + j}");
                                        },
                                        child: Container(
                                          margin: EdgeInsets.all(3.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "${i + j}",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
