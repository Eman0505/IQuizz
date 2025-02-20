import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '/result.dart';
import 'package:flutter_quizapp/questionandanswer.dart';

var quiz = QuestionAnswer(); //place database in a variable
var questionNumber = 1; //initialize start of number question
var skip = 0;

class Quiz extends StatefulWidget {
  var y, titl;
  Quiz({Key? mykey, this.y, this.titl}) : super(key: mykey);

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  //Generate random number from 0 to number of question
  int randomNumber = Random().nextInt(2);
  //widget for choices
  Widget choose(String abcd, int x) {
    return Container(
      child: MaterialButton(
        height: 50,
        minWidth: 310,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
          side: const BorderSide(
              color: Color.fromRGBO(5, 195, 107, 100), width: 5),
        ),
        child: Text(
          abcd, //display choices from a to d
          //textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        onPressed: () {
          if (quiz.sagot[int.parse("${widget.y}")][randomNumber][x] ==
              quiz.tama[int.parse("${widget.y}")][randomNumber]) {
            debugPrint("Correct");
          } else {
            debugPrint("Wrong");
          }
          //Reset timer
          //call a function after clicking any button
          updateQuestion();
        },
        splashColor: Color.fromRGBO(5, 195, 107, 100),
      ),
      decoration: BoxDecoration(
        color: Color.fromRGBO(81, 231, 168, 100),
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(81, 231, 168, 45),
            offset: Offset(
              -3.0,
              4.0,
            ),
            blurRadius: 10.0,
          ),
        ],
      ),
    );
  }

//initialization for timer
  bool canceltimer = false;
  int timeLeft = 10;
  var timestring = "10";
  @override
  void initState() {
    starttimer();
    super.initState();
  }

//timer countdown
  void starttimer() async {
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t) {
      setState(() {
        if (timeLeft < 1) {
          t.cancel();

          updateQuestion();
          skip++;
        } else if (canceltimer == true) {
          t.cancel();
        } else {
          timeLeft--;
        }
        timestring = timeLeft.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            "${widget.titl}",
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontFamily: 'Poppins-ExtraBold',
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
          ),
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromRGBO(81, 231, 168, 1),
          elevation: 3, // 0 yung value para mawala yung back shadow sa app bar
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            iconSize: 35,
            color: Colors.black,
            onPressed: () => {
              Navigator.pop(context),
            },
          ),
        ),
        body: Container(
          margin: EdgeInsets.fromLTRB(26.0, 10.0, 26.0, 35),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 15),
                  alignment: Alignment.topCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      //Display timer
                      Text(timestring),
                      //Display question number
                      Text(
                        "Question ${questionNumber}",
                        style: TextStyle(
                            fontSize: 21,
                            fontFamily: 'Poppins Medium',
                            fontWeight: FontWeight.w500),
                      ),

                      // Question-Box
                      Container(
                        margin: EdgeInsets.fromLTRB(5.0, 20.0, 5.0, 20.0),
                        padding: const EdgeInsets.fromLTRB(14, 28, 13, 28),
                        child: new Center(
                          child: Text(
                            quiz.tanong[int.parse("${widget.y}")][randomNumber],
                            maxLines: 5,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                              fontSize: 22.0,
                              fontFamily: 'Lora',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(81, 231, 168, 100),
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(81, 231, 168, 45),
                              offset: Offset(
                                -3.0,
                                4.0,
                              ),
                              blurRadius: 10.0,
                            ),
                          ],
                        ),
                      ),
                      //display all choices

                      for (int x = 0;
                          x <
                              quiz.sagot[int.parse("${widget.y}")][randomNumber]
                                  .length;
                          x++) ...[
                        //call widget for choices and pass 2 parameters

                        choose(
                            quiz.sagot[int.parse("${widget.y}")][randomNumber]
                                [x],
                            x),
                        const Padding(padding: EdgeInsets.all(5.0))
                      ],

                      new MaterialButton(
                        height: 35.0,
                        minWidth: 120.0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                              color: Color.fromRGBO(5, 195, 107, 50), width: 3),
                        ),
                        child: new Text(
                          "SKIP ",
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                            fontFamily: 'Poppins Medium',
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () => {
                          //Generate random number from 0 to number of question
                          //Generate random number from 0 to number of question
                          randomNumber = Random().nextInt(
                              quiz.tanong[int.parse("${widget.y}")].length),
                          skip++,
                          debugPrint(skip.toString()),
                          //call a function after clicking any button
                          updateQuestion(),
                        },
                        splashColor: Color.fromRGBO(5, 195, 107, 50),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  void updateQuestion() {
    setState(() {
      canceltimer = false;
      if (questionNumber == 20) {
        //Proceed to the result page
        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => new Result()));
      } else {
        //proceed to next question
        randomNumber =
            Random().nextInt(quiz.tanong[int.parse("${widget.y}")].length);

        questionNumber++;
      }
      timeLeft = 10;
      starttimer();
    });
  }
}
