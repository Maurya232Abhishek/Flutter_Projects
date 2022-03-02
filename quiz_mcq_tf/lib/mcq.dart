import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);



class  QuizApp extends StatelessWidget {
  QuizPage quizPage = QuizPage(title: 'MCQ App');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch:Colors.teal,
      ),

      home: quizPage,
    );
  }
}

class QuizPage extends StatefulWidget {
  final String title;
  List<dynamic> que=[];
  String currentQuestionText="Click any button to start";
  Question? currentQuestion;
  String opta="opta";
  String optb="optb";
  String optc="optc";
  String optd="optd";
  int queno=-1;
  String prevAns="0";
  int score=0;
  String submitText="Click here to Start";
  bool isOptVisible=false;
  //bool isTrueVisible=true;
  getDownloadedData() async{
    final url=Uri.https(
        "gist.githubusercontent.com",
        "/Maurya232Abhishek/f48ba715ea183db4ae4d3a2884421a68/raw/f8f0fc6037df4f3e24bf97244a6c3fd7b1050e9e/mcq.json",
        {});
    try{
      final response =await http.get(url);
      print(response);
      print(response.statusCode);
      final jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);
      QuestionsArray array = QuestionsArray.fromJson(jsonResponse);
      print(array);
      print(array.lstQuestions);
      for (var v in array.lstQuestions)
      {
        Question question=Question.fromJson(v);
        print(v);
        que.add(question);
      }
      return true;
    }
    catch(e){
      print(e);
      return false;
    }

  }
  String getTitle(){
    return "Quiz App";
  }
  //*****************************************//
  QuizPage({Key?key, required this.title}): super(key: key);
  TextStyle radiostyle = const TextStyle(color: Colors.white);
  @override
  _QuizPageState createState() => _QuizPageState();
}





class _QuizPageState extends State<QuizPage>{
  //List<dynamic>? que;
  //String currentQueText="Click Start to Start Quiz";
  int _result=0;
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
        widget.isOptVisible=true;
        widget.submitText="Submit";
        if (widget.queno < widget.que.length)
        {
          print("set");
          widget.currentQuestion=widget.que[widget.queno];
          widget.currentQuestionText=widget.currentQuestion!.question;
          widget.opta=widget.currentQuestion!.opta;
          widget.optb=widget.currentQuestion!.optb;
          widget.optc=widget.currentQuestion!.optc;
          widget.optd=widget.currentQuestion!.optd;
          widget.prevAns=widget.currentQuestion!.correctans;
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
        widget.opta=widget.currentQuestion!.opta;
        widget.optb=widget.currentQuestion!.optb;
        widget.optc=widget.currentQuestion!.optc;
        widget.optd=widget.currentQuestion!.optd;

        if (ans==widget.prevAns)
        {
          widget.score++;
        }
        widget.prevAns=widget.currentQuestion!.correctans;
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
      widget.prevAns="-1";
//       widget.isFalseVisible=false;
      widget.isOptVisible=false;
      widget.currentQuestionText="!!!!!Test Over!!!!!!\n\n\n Score : $s ";
    }
    _result=0;
    //widget.queno++;

  }
  @override
  Widget build(BuildContext context){

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          title: Text(widget.getTitle()),
          centerTitle:true,
        ),
        body:Padding(
          padding: const EdgeInsets.all(8.0),
          child:Column(

            children:
            [Expanded(
              flex:4,
              child:Center(



                child:Text(widget.currentQuestionText,
                  style:const TextStyle(fontSize:20 , color:Colors.white,),
                ),
              ),),

              Expanded(
                flex:2,
                child:Visibility(
                  visible:widget.isOptVisible,
                  child:Row(
                    children:[Expanded(
                      child: RadioListTile<int?>(
                        title: Text(
                          widget.opta,
                          style: widget.radiostyle,
                        ),
                        value: 1,
                        groupValue: _result,
                        onChanged: (int? value) {
                          setState(() {
                            _result = 1;
                          });
                        },
                      ),
                    ),
                      Expanded(
                        child: RadioListTile<int?>(
                          title: Text(
                            widget.optb,
                            style: widget.radiostyle,
                          ),
                          value: 2,
                          groupValue: _result,
                          onChanged: (int? value) {
                            setState(() {
                              _result = 2;
                            });
                          },
                        ),
                      ),],),),),

              Expanded(
                flex:2,
                child:Visibility(
                  visible:widget.isOptVisible,
                  child:Row(
                    children:[Expanded(
                      child: RadioListTile<int?>(
                        title: Text(
                          widget.optc,
                          style: widget.radiostyle,
                        ),
                        value: 3,
                        groupValue: _result,
                        onChanged: (int? value) {
                          setState(() {
                            _result = 3;
                          });
                        },
                      ),
                    ),
                      Expanded(
                        child: RadioListTile<int?>(
                          title: Text(
                            widget.optd,
                            style: widget.radiostyle,
                          ),
                          value: 4,
                          groupValue: _result,
                          onChanged: (int? value) {
                            setState(() {
                              _result = 4;
                            });
                          },
                        ),
                      ),],),),),

              Expanded(
                flex:1,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),

                  child:ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      primary:Colors.green,
                      minimumSize: const Size.fromHeight(21),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        widget.submitText,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                    onPressed: (){
                      setState((){
                        setQuestion("$_result");
//                    widget.submitText="Submit";
                      });
                    },


                  ),
                ),
              ),



            ],
          ),
        ),


      ),


    );

  }

}
class QuestionsArray{
  List<dynamic> lstQuestions=[];
  QuestionsArray({required this.lstQuestions});
  factory QuestionsArray.fromJson(Map<String, dynamic> json){
    return QuestionsArray(lstQuestions: json['questions'] as List<dynamic>);
  }

}


class Question{
  final String question;
  final String correctans;
  final String opta,optb,optc,optd;
  Question({required this.question,required this.opta,required this.optb, required this.optc,required this.optd, required this.correctans});
  factory Question.fromJson(Map<String,dynamic> json){
    return Question(
      question:json['question'] as String,
      correctans: json["correctanswer"] as String,
      opta: json['opta'] as String,
      optb: json['optb'] as String,
      optc: json['optc'] as String,
      optd: json['optd'] as String,
    );
  }
  @override
  String toString(){
    return "Question="+question+"opta= $opta optb= $optb optc= $optc optd= $optd"+",Correct Ans = $correctans";
  }
}