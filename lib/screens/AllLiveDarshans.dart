import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:go_router/go_router.dart';
import 'package:omshribhakti/widgets/ThumbnailCard.dart';

class AllLiveDarshans extends StatelessWidget {
  const AllLiveDarshans({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Live Darshans"),
      ),
      body: ListView.builder(
          itemCount: 5+1,
          itemBuilder: (context,index){
            if(index == 5){
              return const Padding(
                padding:  EdgeInsets.all(8.0),
                child:  Center(child: CircularProgressIndicator(),),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                  onTap: ()=>GoRouter.of(context).pushNamed("VideoPlayer"),
                  child: thumbnailCard(MediaQuery.sizeOf(context).height *0.3, MediaQuery.sizeOf(context).width, "title dd s dfr df dh fdf fg h", "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png")),
            );
          }
      ),
    );
  }
}
