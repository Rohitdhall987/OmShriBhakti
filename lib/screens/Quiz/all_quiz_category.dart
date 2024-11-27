import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omshribhakti/provider/auth_provider.dart';
import 'package:omshribhakti/services/quiz_service.dart';
import 'package:omshribhakti/widgets/QuizCategory.dart';

class QuizCategory extends ConsumerWidget {
  const QuizCategory({super.key});



  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final user=ref.watch(customUserProvider);
    final QuizService service=QuizService();
    return Scaffold(
      appBar: AppBar(
        title: const Text("QUIZ"),
      ),
      body:FutureBuilder(
          future: service.fetchQuizCategory(user!.apiData!["token"]),
          builder: (context,snapshot){
            if(snapshot.connectionState ==ConnectionState.done && !snapshot.hasError){
              return GridView.builder(
                  shrinkWrap: true,
                  physics:const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 16,crossAxisSpacing: 16),
                  itemBuilder: (context,index){
                    return GestureDetector(
                        child: quizCategory(snapshot.data![index].title, snapshot.data![index].image)
                    );
                  }
              );
            }
            return GridView.builder(
                shrinkWrap: true,
                physics:const NeverScrollableScrollPhysics(),
                itemCount: 5,
                gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 16,crossAxisSpacing: 16),
                itemBuilder: (context,index){
                  return GestureDetector(
                      child: quizCategory("Loading", "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png")
                  );
                }
            );
          }
      ),
    );
  }
}
