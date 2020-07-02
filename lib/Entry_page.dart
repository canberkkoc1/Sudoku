import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sudoku/Sudoku_page.dart';

import 'dil.dart';

class EntryPage extends StatefulWidget {
  @override
  _EntryPageState createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  Box _sudokuBox;
  Future<Box> _openbox() async {
    _sudokuBox = await Hive.openBox('sudoku');
    return await Hive.openBox(
        'finished_sudoku'); // tamamlanan sudokuları box içinde açaçcak
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dil['giriş_title']),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.color_lens),
            onPressed: () => Hive.box('settings').put(
              'dark_Theme',
              !Hive.box('settings').get('dark_Theme', defaultValue: false),
            ),
          ),
          PopupMenuButton(
            icon: Icon(Icons.add),
            onSelected: (deger) {
              if (_sudokuBox.isOpen) {
                _sudokuBox.put('seviye', deger);
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => SudokuPage()));
              }
            },
            itemBuilder: (context) => <PopupMenuEntry>[
              PopupMenuItem(
                value: dil['seviye_secin'],
                child: Text(dil['seviye_secin'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyText1.color,
                    )),
              ),
              for (String k in sudokuLevel.keys)
                PopupMenuItem(
                  value: k,
                  child: Text(k),
                )
            ],
          ),
        ],
      ),
      body: FutureBuilder<Box>(
          future: _openbox(),
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (snapshot.data.length == 0)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Çözülmüş sudokunuz yok , sağ üst köşeden seviye seçimi yaparak çözmeye başlayın",
                          style: GoogleFonts.lobster(),
                        ),
                      ),
                    for (var e in snapshot.data.values)
                      Center(
                        child: Text("$e"),
                      )
                  ],
                ),
              );
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
