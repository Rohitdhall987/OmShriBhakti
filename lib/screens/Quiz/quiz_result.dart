import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:omshribhakti/model/quiz_result.dart';
import 'package:omshribhakti/widgets/themeContainer.dart';

class QuizResultPage extends StatelessWidget {
  final dynamic jsonResult;
  const QuizResultPage({super.key, required this.jsonResult});

  @override
  Widget build(BuildContext context) {
    final result=QuizResult.fromJson(jsonDecode(jsonResult));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Results'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            themeContainer(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Quiz Summary',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text('Correct Answers: ${result.result.correctAnswers}',style: TextStyle(
                        color: Colors.white
                    ),),
                    Text('Incorrect Answers: ${result.result.incorrectAnswers}',style: TextStyle(
                        color: Colors.white
                    ),),
                    CircularProgressIndicator(
                      value: result.result.finalScore/100,
                      backgroundColor: Colors.white,
                    ),
                    Text('Total Questions: ${result.result.totalQuestions}',style: TextStyle(
                        color: Colors.white
                    ),),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: result.result.resultData.length,
              itemBuilder: (context, index) {
                final questionData = result.result.resultData[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Q.${index + 1}: ${questionData.question.trim()}',
                          // style: TextStyle(
                          //   color: Colors.white
                          // )
                        ),
                        const SizedBox(height: 8),
                        Text('Your Answer: ${questionData.submittedAnswer}'),
                        Text('Correct Answer: ${questionData.correctAnswer}'),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              questionData.isCorrect ? '✔ Correct' : '✘ Incorrect',
                              style: TextStyle(
                                color: questionData.isCorrect
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
