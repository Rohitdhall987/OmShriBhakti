import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:omshribhakti/model/quiz_question_model.dart';
import 'package:omshribhakti/provider/auth_provider.dart';
import 'package:omshribhakti/services/quiz_service.dart';
import 'package:omshribhakti/utils/Colors.dart';
import 'package:omshribhakti/widgets/quiz_question.dart';

class QuizPage extends ConsumerStatefulWidget {
  final int categoryId;
  const QuizPage({super.key, required this.categoryId});

  @override
  ConsumerState<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends ConsumerState<QuizPage> {
  QuizService quizService = QuizService();
  late List<int?> selectedAnswers;
  bool hasLoaded=false;
  late List<QuizQuestion> quizQuestions;
  bool canSubmit=false;
  bool loading=false;
  late Timer _timer;
  double _progress = 0.0; // 0 to 1 for the progress bar
  int _remainingTime = 120; // 2 minutes in seconds

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {

      fetchQuestion();

    });

    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
          _progress = (120 - _remainingTime) / 120;
        } else {
          timer.cancel();
          context.pop();
        }
      });
    });
  }

  void fetchQuestion()async{
    final user = ref.read(customUserProvider);
    quizQuestions=await quizService.fetchQuizQuestion(
      token: user!.apiData!["token"],
      userId: user.apiData!["userId"],
      categoryId: widget.categoryId,
    );

    setState(() {
      hasLoaded=true;
      selectedAnswers = List<int?>.filled(quizQuestions.length, null);
    });
  }


  void submit(){
    if(!canSubmit){
      return;
    }
    setState(() {
      loading=true;
    });
    final user = ref.read(customUserProvider);
    quizService.submitQuiz(token: user!.apiData!["token"], userId: user.apiData!["userId"], categoryId: widget.categoryId, answers: selectedAnswers, questionsId: quizQuestions.map((question)=>question.id).toList()).then(
            (data){
              loading=false;
              if(jsonDecode(data)["message"]=="success"){
                if(mounted){
                  GoRouter.of(context).pushReplacementNamed("QuizResultPage",
                    pathParameters: {
                      "data":data.toString()
                    }
                  );
                }
              }
            }
   );
  }


  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
           !hasLoaded?
             const Center(
              child: CircularProgressIndicator(),
            ):
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Text("Total Questions: ${quizQuestions.length}",
                    style: const TextStyle(
                      color: Colors.white
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: quizQuestions.length,
                      itemBuilder: (context, index) {
                        return questionWidget(
                          question: quizQuestions[index],
                          index: index,
                          selectedValue: selectedAnswers[index],
                          onChange: (value) {
                            setState(() {
                              selectedAnswers[index] = value;
                              int unansweredCount = selectedAnswers.where((answer) => answer == null).length;
                              canSubmit = (unansweredCount == 0);
                            });
                          },

                        );
                      },
                    ),
                  ),
                  !loading?MaterialButton(
                    color:canSubmit? AppTheme.primary:Colors.grey,
                    textColor: Colors.white,
                    onPressed:submit,
                    child: const Text("SUBMIT"),
                  ):const CircularProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: LinearProgressIndicator(
                      value: _progress,
                      backgroundColor: Colors.grey.shade300,
                      color: AppTheme.primary,
                      minHeight: 8.0,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Time Remaining: ${_remainingTime ~/ 60}:${(_remainingTime % 60).toString().padLeft(2, '0')}",
                    style: const TextStyle(fontSize: 16,color: Colors.white),
                  ),
                ],
              ),
            ),
          )
    );
  }
}

