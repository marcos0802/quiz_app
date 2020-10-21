import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:quiz/widget/home.dart';
import 'package:quiz/widget/text_utils.dart';
import 'package:quiz/model/question.dart';
import 'dart:async';

class QuizPage extends StatefulWidget{
  @override
  _QuizPageState createState() => new _QuizPageState();
}

class _QuizPageState extends State<QuizPage>{
  Question question;
  List<Question> listQuestion = [
    new Question('Is Paris the capital City of France?', true, 'Of course, Paris is the Main City of France', 'paris.jpeg'),
    new Question('Is the moon a planete?', false, 'The moon is not a planete is just a sattelite', 'lune.jpeg'),
    new Question('Flutter is a programming language ', false, 'Flutter is a SDK', 'flutter.png'),
    new Question('Louis XIV is a England Emperor', false, 'Louis XIV is a french emperor', 'louis.jpeg'),
    new Question('He is the main actress in the Lucifer show series', true, 'Yes is the main Actres', 'lucifer.jpeg'),
    new Question('This is the greatest building in Limonge City', true, 'This builiding is located on th 16 th street', 'palais.jpeg'),
    new Question('MineCradt is the basic game of Nitendo ', true, 'For Young aged from 2 to 5 years old', 'game.jpeg')
  ];
  int index = 0;
  int score = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    question = listQuestion[index];
  }
  @override
  Widget build(BuildContext context) {

    double size = MediaQuery.of(context).size.width*0.5;
    return new Scaffold(
      appBar: new AppBar(
        title: TextUtils('Quiz Part'),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new TextUtils('Question #${index+1}', color: Colors.grey[900],),
            new TextUtils('Score : $score / ${index+1}', color: Colors.grey[900],),
            new Card(
              elevation: 8.0,
              child: new Container(
                height: size,
                width: size,
                child: new Image.asset('images/'+question.imagePath,fit: BoxFit.cover,),
              ),
            ),
            new TextUtils(question.question, color: Colors.grey[900], textScaleFactor: 1.3,),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buttonBool(true),
                buttonBool(false)
              ],
            )
          ],
        )
      ),
    );
  }

  RaisedButton buttonBool(bool b){

    return new RaisedButton(
        elevation: 8.0,
        onPressed: (()=>dialog(b)),
        color: Colors.green,
        child: new TextUtils(b? 'True' : 'False'),);
  }

  Future<Null> dialog(bool b) async{
    bool answer = (b == question.reponse);
    String vrai = 'images/true.png';
    String faux = 'images/false.png';
    if(answer){ score++;}

    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return SimpleDialog(
            title: new TextUtils(answer? 'Congratulations !' : 'Sorry !',textScaleFactor: 1.4, color: answer? Colors.green : Colors.red),
            contentPadding: EdgeInsets.all(18.0),
            children: <Widget>[
              new Image.asset(answer ? vrai : faux, fit: BoxFit.cover),
              new Container(height: 20.0),
              new TextUtils(question.explication, textScaleFactor: 1.1,color: Colors.green[900]),
              new Container(height: 20.0),
              new RaisedButton(
                  onPressed: (){
                    Navigator.pop(context);
                    getNextQuestion();
                  },
                  color: Colors.green,
                  child: new TextUtils('Next Question', textScaleFactor: 1.2,color: Colors.white,),),

            ],
          );
        });

  }

  Future<Null> alert()async{
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext){
            return AlertDialog(
              title: TextUtils('End of the Quiz', color: Colors.deepPurpleAccent, textScaleFactor: 1.2,),
              contentPadding: EdgeInsets.all(10.0),
              content: new TextUtils('Your score is : $score / ${index+1}', color: Colors.grey[900],),
              actions: <Widget>[
                new FlatButton(
                    onPressed: (){
                      Navigator.pop(buildContext);
                      Navigator.pop(context);
                    },
                    child: new TextUtils('Finished', textScaleFactor: 1.4, color: Colors.deepPurpleAccent,))
              ],
            );
        });
  }

  void getNextQuestion(){
      if(index < listQuestion.length-1){
        index++;
        setState(() {
          question = listQuestion[index];
        });
      }else{
          alert();
      }
  }
}