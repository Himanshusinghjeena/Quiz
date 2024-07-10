// ignore_for_file: use_super_parameters, sized_box_for_whitespace, prefer_const_constructors, unnecessary_brace_in_string_interps, avoid_print, prefer_final_fields, unused_field, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math';

import 'package:quiz_app/option.dart';


class QuizApp extends StatefulWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  bool optionSelected = false;
  int a = 0;
  int b = 0;
  int c = 0;
  int ans = 0;
  int correct = 0;
  int wrong = 0;
  int points = 0;
  int ques = 1;
  List<int> optionValues = [];

  void generateNew() {
    a = Random().nextInt(100) + 1;
    b = Random().nextInt(100) + 1;
    c = a + b;
  }

  void generateOptions() {
    int min = c - 5;
    int max = c + 5;
    Set<int> values = {c};
    while (values.length < 4) {
      int randomNumber = min + Random().nextInt(max + 1 - min);
      values.add(randomNumber);
    }
    optionValues = values.toList();
    optionValues.shuffle();
    ans = optionValues.indexOf(c);
  }

  void checkAnswer(int option) {
    setState(() {
      if (c == option) {
        correct++;
        points += 5;
      } else {
        wrong++;
      }
      optionSelected = true;
    });
    Timer(Duration(milliseconds: 400), () {
      generateNextQuestion();
    });
  }

  void generateNextQuestion() {
    ques++;
    if (ques <= 10) {
      setState(() {
        optionSelected = false;
        generateNew();
        generateOptions();
      });
    } else if (ques == 11) {
      showResultsDialog();
    }
  }

  showResultsDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SizedBox(
                height: 120,
                width: 50,
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text("Your Score is $points"),
                    Text("Correct Answers: $correct"),
                    Text("Wrong Answers: $wrong")
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffa80aa0),
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    "OK",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => QuizApp()),
                    );
                  },
                ),
              ],
            ));
  }

  @override
  void initState() {
    generateNew();
    generateOptions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color(0xffa80aa0),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
            ),
            Positioned(
              top: 70,
              left: 20,
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Correct: $correct",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Wrong: $wrong",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Points: $points",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              top: 200,
              child: Container(
                height: 150,
                width: 300,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Question $ques/10",
                      style: TextStyle(
                        color: Color(0xffa80aa0),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "The Addition of $a and $b is ?",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 370,
              left: 20,
              right: 20,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.40,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Options(
                        index: optionValues[0],
                        onTap: () {
                          checkAnswer(optionValues[0]);
                        },
                        isCorrect: optionValues[0] == c,
                        isEnabled: !optionSelected,
                        isWrongSelected: optionSelected && optionValues[0] != c,
                      ),
                      Options(
                        index: optionValues[1],
                        onTap: () {
                          checkAnswer(optionValues[1]);
                        },
                        isCorrect: optionValues[1] == c,
                        isEnabled: !optionSelected,
                        isWrongSelected: optionSelected && optionValues[1] != c,
                      ),
                      Options(
                        index: optionValues[2],
                        onTap: () {
                          checkAnswer(optionValues[2]);
                        },
                        isCorrect: optionValues[2] == c,
                        isEnabled: !optionSelected,
                        isWrongSelected: optionSelected && optionValues[2] != c,
                      ),
                      Options(
                        index: optionValues[3],
                        onTap: () {
                          checkAnswer(optionValues[3]);
                        },
                        isCorrect: optionValues[3] == c,
                        isEnabled: !optionSelected,
                        isWrongSelected: optionSelected && optionValues[3] != c,
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
