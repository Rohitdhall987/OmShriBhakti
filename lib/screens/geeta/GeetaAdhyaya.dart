import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:omshribhakti/widgets/GeetaCard.dart';

class Geeta extends StatelessWidget {
  const Geeta({super.key});





  @override
  Widget build(BuildContext context) {

    const geetaShlokaCount = [
      {"adhyaya": 1, "shloka_count": 47},
      {"adhyaya": 2, "shloka_count": 72},
      {"adhyaya": 3, "shloka_count": 43},
      {"adhyaya": 4, "shloka_count": 42},
      {"adhyaya": 5, "shloka_count": 29},
      {"adhyaya": 6, "shloka_count": 47},
      {"adhyaya": 7, "shloka_count": 30},
      {"adhyaya": 8, "shloka_count": 28},
      {"adhyaya": 9, "shloka_count": 34},
      {"adhyaya": 10, "shloka_count": 42},
      {"adhyaya": 11, "shloka_count": 55},
      {"adhyaya": 12, "shloka_count": 20},
      {"adhyaya": 13, "shloka_count": 34},
      {"adhyaya": 14, "shloka_count": 27},
      {"adhyaya": 15, "shloka_count": 20},
      {"adhyaya": 16, "shloka_count": 24},
      {"adhyaya": 17, "shloka_count": 28},
      {"adhyaya": 18, "shloka_count": 78},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Geeta"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            itemCount: geetaShlokaCount.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8
            ),
            itemBuilder: (context,index){
              final adhyayaData = geetaShlokaCount[index];
              return GestureDetector(
                onTap: ()=>GoRouter.of(context).pushNamed("GeetaShlok",pathParameters: {"adhyaya":adhyayaData["adhyaya"].toString(),"shloka":adhyayaData["shloka_count"].toString()}),
                  child: geetaCard(adhyayaData)
              );
            }
        ),
      ),
    );
  }
}
