import 'package:cht/models/quiz.dart';
import 'package:cht/screens/auth/progress_bar.dart';
import 'package:cht/util/ui_helper.dart';
import 'package:flutter/material.dart';

class QuizWidget extends StatefulWidget {
  QuizWidget({Key key, this.quiz}) : super(key: key);
  final Quiz quiz;

  @override
  State<QuizWidget> createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  int questionNum = 0;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0,
        titleSpacing: 0,
        title: _progress(),
      ),
      backgroundColor: Colors.purple,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                _question(),
                ...widget.quiz.questions[questionNum].options
                    .map((e) => _option(e))
                    .toList(),
                _next_or_submit()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _progress() {
    return ProgressBar(
      backgroundcolor: Colors.purple,
      height: 50,
      width: screenWidth,
      percentage: (questionNum + 1) / widget.quiz.questions.length,
    );
  }

  Widget _question() {
    return Container(
      width: screenWidth,
      height: 100,
      child: Center(
        child: Text(widget.quiz.questions[questionNum].question),
      ),
    );
  }

  Widget _option(Option option) {
    return Container(
      child: Center(
        child: Text(option.option),
      ),
    );
  }

  Widget _next_or_submit() {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            if (widget.quiz.questions.length == questionNum + 1) {
              //submmit
            } else
              questionNum++;
          });
        },
        child: Text(widget.quiz.questions.length == questionNum + 1
            ? "Submit"
            : "Next"));
  }
}
