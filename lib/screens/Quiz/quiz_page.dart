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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {

      fetchQuestion();

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
    final user = ref.read(customUserProvider);
    quizService.submitQuiz(token: user!.apiData!["token"], userId: user.apiData!["userId"], categoryId: widget.categoryId, answers: selectedAnswers, questionsId: quizQuestions.map((question)=>question.id).toList()).then(
            (data){
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
                  MaterialButton(
                    color:canSubmit? AppTheme.primary:Colors.grey,
                    textColor: Colors.white,
                    onPressed:submit ,
                    child: const Text("SUBMIT"),
                  )
                ],
              ),
            ),
          )
    );
  }
}

