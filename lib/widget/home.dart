import 'package:flutter/material.dart';
import 'package:quiz/widget/text_utils.dart';
import 'package:quiz/widget/quiz_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              new Card(
                elevation: 8.0,
                child: new Container(
                  height: MediaQuery.of(context).size.width*0.7,
                  width: MediaQuery.of(context).size.width*0.7,
                  child: new Image.asset('images/quiz_cover.jpeg', fit: BoxFit.cover),
                ),
              ),
            new RaisedButton(
              onPressed: (){
                Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                  return new QuizPage();
                }));
              },
              color: Colors.green,
              child: new TextUtils('Start the quiz', color: Colors.white,),)
          ],
        ),
      ),
    );
  }
}
