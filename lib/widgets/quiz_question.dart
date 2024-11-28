import 'package:flutter/material.dart';
import 'package:omshribhakti/model/quiz_question_model.dart';

Widget questionWidget({
  required QuizQuestion question,
  required int index,
  required int? selectedValue,
  required void Function(int?) onChange,
}) {
  final options = [
    question.opt_1,
    question.opt_2,
    question.opt_3,
    question.opt_4,
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "${index+1}. ${question.question.trim()}",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),

      ...List.generate(options.length, (index) {
        final optionValue = index + 1;
        return RadioListTile<int>(
          value: optionValue,
          groupValue: selectedValue,
          onChanged: onChange,
          title: Text(
            options[index],
            style: const TextStyle(color: Colors.white),
          ),
          activeColor: Colors.red, // Customize active color if needed
        );
      }),
      const SizedBox(height: 16.0),
    ],
  );
}
