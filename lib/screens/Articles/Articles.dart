

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:omshribhakti/provider/auth_provider.dart';
import 'package:omshribhakti/services/article_service.dart';
import 'package:omshribhakti/widgets/ArticleCard.dart';

class Articles extends ConsumerWidget{


   Articles({super.key});


   final ArticleService _articleService=ArticleService();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final user=ref.watch(customUserProvider);

    // TODO: implement build
    return Scaffold(
      body: FutureBuilder(
          future:_articleService.fetchMonthlyCategory(user!.apiData!["token"]),
          builder: (context,snapshot){
            if(!snapshot.hasData && snapshot.connectionState != ConnectionState.done){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final monthlyCategory=snapshot.data;

            return SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        const Text("Articles by Month",
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
                            itemCount: monthlyCategory!.length,
                            itemBuilder: (context,index){

                              // if(index == 5){
                              //   return const Padding(
                              //     padding:  EdgeInsets.all(8.0),
                              //     child:  Center(
                              //       child: CircularProgressIndicator(),
                              //     ),
                              //   );
                              // }

                              final category=monthlyCategory[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                // child: thumbnailCard(MediaQuery.sizeOf(context).height *0.3, MediaQuery.sizeOf(context).width, "title dd s dfr df dh fdf fg h", "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png"),
                                child: GestureDetector(
                                  onTap: ()=> GoRouter.of(context).pushNamed("ArticleByMonth",
                                      pathParameters: {
                                        "id":category.id.toString(),
                                      }),
                                  child: articleCard(
                                      type:"Articles",
                                      height: MediaQuery.sizeOf(context).height*0.25,
                                      width: MediaQuery.sizeOf(context).width,
                                      image: category.image,
                                      seriesCount: category.articleSeries,
                                      singleCount: category.singleArticles,
                                      date: "0000-00-00 00:00:00"
                                  ),
                                ),
                              );
                            }
                        ),
                      ],
                    ),
                  ),
                )
            );
          }
      )
    );
  }
}