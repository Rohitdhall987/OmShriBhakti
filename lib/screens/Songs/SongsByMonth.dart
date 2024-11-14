import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:omshribhakti/utils/Colors.dart';
import 'package:omshribhakti/widgets/ThumbnailCard.dart';

class SongsByMonth extends StatelessWidget {
  const SongsByMonth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Single Song",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height*0.25,
                    width: MediaQuery.sizeOf(context).width,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: GestureDetector(
                              onTap: ()=>GoRouter.of(context).pushNamed("MusicPlayerPage"),
                                child: thumbnailCard(MediaQuery.sizeOf(context).height*0.4, MediaQuery.sizeOf(context).width*0.7, "title", "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png")
                            ),
                          );
                        },
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Center(
                    child:Text("View All",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primary
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text("Series",
                    style: TextStyle(
                        color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics:const  NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: GestureDetector(
                          onTap: ()=>GoRouter.of(context).pushNamed("SongSeries"),
                            child: thumbnailCard(MediaQuery.sizeOf(context).height*0.3, MediaQuery.sizeOf(context).width, "title", "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png")
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}
