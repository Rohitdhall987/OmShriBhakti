

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:omshribhakti/widgets/ArticleCard.dart';
import 'package:omshribhakti/widgets/ThumbnailCard.dart';

class Music extends ConsumerWidget{

  const Music({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  const Text("Songs by Month",
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics:const NeverScrollableScrollPhysics(),
                      itemCount: 5+1,
                      itemBuilder: (context,index){
                        if(index == 5){
                          return const Padding(
                            padding:  EdgeInsets.all(8.0),
                            child:  Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          // child: thumbnailCard(MediaQuery.sizeOf(context).height *0.3, MediaQuery.sizeOf(context).width, "title dd s dfr df dh fdf fg h", "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png"),
                          child: GestureDetector(
                            onTap: (){
                              GoRouter.of(context).pushNamed("SongsByMonth");
                            },
                            child: articleCard(
                                type:"Songs",
                                height: MediaQuery.sizeOf(context).height*0.25,
                                width: MediaQuery.sizeOf(context).width,
                                images: [
                                  "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png",
                                  "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png",
                                  "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png",
                                  "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png"
                                ],
                                seriesCount: 15,
                                singleCount: 5,
                                date: "2024-10-27 14:15:16"
                            ),
                          ),
                        );
                      }
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}