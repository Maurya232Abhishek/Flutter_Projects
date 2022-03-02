import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

void main() async {
  VSJApp vsjApp = VSJApp();
  runApp(vsjApp);
}

class VSJApp extends StatelessWidget {

  VSJHomePage vsjHomePage = VSJHomePage(title: 'Quiz App');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: vsjHomePage,
    );
  }
}

class VSJHomePage extends StatefulWidget {
  final String title;
  List<dynamic> que=[];
  String currentQuestionText="Click any button to start";
  Question? currentQuestion;
  int queno=-1;
  String prevAns="";
  int score=0;
  String trueText="Click here to Start";
  bool isFalseVisible=false;
  bool isTrueVisible=true;


  getDownloadedData() async {
    final url = Uri.https(
        "gist.githubusercontent.com",
        "/Maurya232Abhishek/2900a20b034608ebbcbf164134958c2d/raw/c8c301a84e2bb3504349bab1d57c9db127449a80/question.json",
        {});

    try {
      final response = await http.get(url);
      print(response);
      print(response.statusCode);
      final jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);
      QuestionsArray array = QuestionsArray.fromJson(jsonResponse);
      print(array);
      print(array.lstQuestions);
      int count=0;
      for (var v in array.lstQuestions) {
        print(v);

        Question question = Question.fromJson(v);
        que.add(question);
        if (count==0)
        {
          currentQuestion=question;
          currentQuestionText=question.question;
        }

        //print(question);
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  //*****************************************************************************************
  VSJHomePage({Key? key, required this.title}) : super(key: key);

  String getTitle() {
    return "Quiz App ";
  }


  @override
  _VSJPageState createState() => _VSJPageState();
}

class _VSJPageState extends State<VSJHomePage> {
  bool isQuizOver()
  {
    if (widget.que.length<=widget.queno)
    {
      return true;

    }
    return false;
  }
  bool isLastQuestion()
  {
    if(widget.que.length-1==widget.queno)
    {
      return true;
    }
    return false;
  }
  void  setQuestion(String ans) async
  {
    if (widget.queno==-1)
    {
      bool s = await widget.getDownloadedData();
      if(s==true){
        widget.queno++;
        widget.isFalseVisible=true;
        widget.trueText="True";
        if (widget.queno < widget.que.length)
        {
          print("set");
          widget.currentQuestion=widget.que[widget.queno];
          widget.currentQuestionText=widget.currentQuestion!.question;
          widget.prevAns=widget.currentQuestion!.correctanswer;
        }
        setState(() {});
      }
    }

    else if(!isQuizOver())
    {


      int s=widget.score;
      print("Score $s");
      print(widget.queno);
      widget.queno++;
      int x=widget.queno;
      print("queno $x");
      print(widget.que.length);
      if (widget.queno < widget.que.length)
      {
        print("set");
        widget.currentQuestion=widget.que[widget.queno];
        widget.currentQuestionText=widget.currentQuestion!.question;

        if (ans==widget.prevAns)
        {
          widget.score++;
        }
        widget.prevAns=widget.currentQuestion!.correctanswer;
      }

      print("helllo");
    }
    if (isQuizOver())
    {
      if (ans==widget.prevAns)
      {
        widget.score++;
      }
      int s=widget.score;
      widget.prevAns="";
      widget.isFalseVisible=false;
      widget.isTrueVisible=false;
      widget.currentQuestionText="!!!!!Test Over!!!!!!"+"\n\n\n"+"Score : $s ";
    }

    //widget.queno++;

  }

  @override
  Widget build(BuildContext context) {
    String t=widget.trueText;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          title: Text(widget.getTitle()),
          centerTitle: true,
        ),
        body: Column(
          children: [

            Expanded(

              child: Row(
                children:[Expanded(
                  child:Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [Text(widget.currentQuestionText , textAlign: TextAlign.center,style: const TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                      ),),/*Text("Correct Answer")*/],),),),

                ],
              ),
            ),
            Center(
              child:Visibility(
                visible:widget.isTrueVisible,
                child: Card(
                  child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(

                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child:  Padding(
                        padding:  EdgeInsets.all(8.0),
                        child:  Text(
                          widget.trueText,
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                      onPressed: () {


                        setQuestion("true");

                        setState((){ });
                      },
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible:widget.isFalseVisible,
              child:Center(
                child: Card(
                  child:Padding(
                    padding: const EdgeInsets.all(8.0),

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child: const Padding(
                        padding:  EdgeInsets.all(8.0),
                        child:  Text(
                          "False",
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                      onPressed: () {
                        setState((){
                          //widget.queno+=1;
                          setQuestion("false");
                        });




                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionsArray {
  List<dynamic> lstQuestions;

  QuestionsArray({required this.lstQuestions});

  factory QuestionsArray.fromJson(Map<String, dynamic> json) {
    return QuestionsArray(lstQuestions: json['questions'] as List<dynamic>);
  }
}

class Question {
  final String question, correctanswer;

  Question({required this.question, required this.correctanswer});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
        question: json['question'] as String,
        correctanswer: json['correctanswer'] as String);
  }

  @override
  String toString() {
    return "Question=" + question + ", Correct Answer=" + correctanswer;
  }
}