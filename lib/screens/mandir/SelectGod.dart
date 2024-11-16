import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:omshribhakti/widgets/GodCard.dart';

class SelectGod extends StatelessWidget {
  const SelectGod({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Mandir Gods"),
      ),
      body: GridView.builder(
          itemCount: 5,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8
          ),
          itemBuilder: (context,index){
            return GestureDetector(
                onTap: ()=>GoRouter.of(context).pushNamed("Mandir"),
                child: godCard(name: index.toString(), image: "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png",)
            );
          }
      ),
    );
  }
}
