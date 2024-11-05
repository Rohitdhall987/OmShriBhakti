

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omshribhakti/widgets/ThumbnailCard.dart';

class Videos extends ConsumerWidget{

  const Videos({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
          child: ListView.builder(
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
                  child: thumbnailCard(MediaQuery.sizeOf(context).height *0.3, MediaQuery.sizeOf(context).width, "title dd s dfr df dh fdf fg h", "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png"),
                );
              }
          )
      ),
    );
  }
}