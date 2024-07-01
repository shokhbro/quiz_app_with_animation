import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PageviewBuilder extends StatefulWidget {
  final String question;
  final List<dynamic> answers;
  final int index;
  final int correct;
  final VoidCallback nextQuestion;

  const PageviewBuilder({
    super.key,
    required this.answers,
    required this.question,
    required this.index,
    required this.nextQuestion,
    required this.correct,
  });

  @override
  State<PageviewBuilder> createState() => _PageviewBuilderState();
}

class _PageviewBuilderState extends State<PageviewBuilder> {
  int correctIndex = -1;
  bool isCorrect = false;
  bool isChecked = false;

  List<String> options = ["A)", "B)", "C)", "D)"];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            widget.question,
            style: const TextStyle(
              fontFamily: 'Lato',
              fontSize: 20,
            ),
          ),
        ),
        for (int i = 0; i < widget.answers.length; i++)
          ListTile(
            leading: Text(
              options[i],
              style: const TextStyle(
                fontFamily: 'Lato',
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            title: Text(
              widget.answers[i],
              style: const TextStyle(
                fontFamily: 'Lato',
                fontSize: 18,
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  isChecked = true;
                  correctIndex = i;
                  isCorrect = (i == widget.correct);
                });
                widget.nextQuestion();
              },
              icon: i == correctIndex
                  ? const Icon(Icons.check_box)
                  : const Icon(Icons.check_box_outline_blank),
            ),
          ),
        if (isChecked)
          isCorrect
              ? Lottie.asset(
                  'assets/lotties/done.json',
                  width: 200,
                  height: 200,
                )
              : Lottie.asset(
                  'assets/lotties/incorrect.json',
                  width: 100,
                  height: 100,
                ),
      ],
    );
  }
}
