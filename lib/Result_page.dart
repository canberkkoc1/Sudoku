import 'package:flutter/material.dart';
import 'dil.dart';



class ResultPage extends StatefulWidget{
  @override
  _ResultPageState createState() => _ResultPageState();

}

class _ResultPageState extends State<ResultPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:Text(dil['sonuç_title'])
      ),
      body: Center(),
    );
  }
}