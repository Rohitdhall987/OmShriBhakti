import 'package:flutter/material.dart';

class Gods extends StatelessWidget {
  const Gods({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GridView.builder(
              itemCount: 5,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8
              ),
              itemBuilder: (context,index){
                return Container(
                  color: Colors.green,
                    child: Text("data",style: TextStyle(color: Colors.white),)
                );
              }
          )
      ),
    );
  }
}
