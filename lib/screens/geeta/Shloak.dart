import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:omshribhakti/utils/Colors.dart';
import 'package:omshribhakti/widgets/GeetaCard.dart';
import 'package:omshribhakti/widgets/themeContainer.dart';

class GeetaShlok extends StatelessWidget {
  const GeetaShlok({super.key, required this.adhaya,required this.shloka });

  final int adhaya;
  final int shloka;




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:  Text("Adhaya $adhaya"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            itemCount: shloka,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8
            ),
            itemBuilder: (context,index){

              return GestureDetector(
                onTap: ()=>GoRouter.of(context).pushNamed("ReadShloak"),
                child: themeContainer(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Shloka ${index +1}",
                          style: const TextStyle(
                            color: AppTheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 24
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Languages 3',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    )),
              );
            }
        ),
      ),
    );
  }
}
