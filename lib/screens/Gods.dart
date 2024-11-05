import 'package:flutter/material.dart';
import 'package:omshribhakti/widgets/GodCard.dart';

class Gods extends StatelessWidget {
  const Gods({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        title: Text("Gods",
        ),
      ),
      body: GridView.builder(
          itemCount: 5,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8
          ),
          itemBuilder: (context,index){
            return godCard(name: index.toString(), image: "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png",);
          }
      ),
    );
  }
}
