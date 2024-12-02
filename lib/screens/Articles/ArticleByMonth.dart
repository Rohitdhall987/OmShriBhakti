
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:omshribhakti/provider/auth_provider.dart';
import 'package:omshribhakti/services/article_service.dart';
import 'package:omshribhakti/utils/Colors.dart';
import 'package:omshribhakti/widgets/ThumbnailCard.dart';

class ArticleByMonth extends ConsumerWidget {
  final String id;
  ArticleByMonth({super.key,required this.id});

  final ArticleService _articleService=ArticleService();

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final user=ref.watch(customUserProvider);
    return Scaffold(
      body: SafeArea(
          child:

            SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Single Article",
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
                        child: FutureBuilder(
                          future: _articleService.fetchMonthlySingleArticleById(user!.apiData!["token"], id,null),
                          builder: (context,snapshot) {
                            if(!snapshot.hasData && snapshot.connectionState != ConnectionState.done){
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            final monthlySingle=snapshot.data!;
                            return ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: monthlySingle.singleArticles.length,
                                itemBuilder: (context,index){
                                  final singleArticle=monthlySingle.singleArticles[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: GestureDetector(
                                        onTap: (){
                                          GoRouter.of(context).pushNamed("ReadArticle");
                                        },
                                        child: thumbnailCard(MediaQuery.sizeOf(context).height*0.4, MediaQuery.sizeOf(context).width*0.7, singleArticle.title, singleArticle.image)
                                    ),
                                  );
                                },
                            );
                          }
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        onTap: (){
                          GoRouter.of(context).pushNamed("SingleArticlesList",
                            pathParameters: {
                              'id':id,
                            }
                          );
                        },
                        child: Center(
                          child:Text("View All",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primary
                            ),
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
                      FutureBuilder(
                        future: _articleService.fetchMonthlyArticleSeriesById(user.apiData!["token"],id),
                        builder: (context,snapshot) {
                          if(!snapshot.hasData && snapshot.connectionState != ConnectionState.done){
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          final monthlySeries=snapshot.data!;
                          return ListView.builder(
                            shrinkWrap: true,
                            physics:const  NeverScrollableScrollPhysics(),
                            itemCount: monthlySeries.articleSeries.length,
                            itemBuilder: (context,index){
                              final articleSeries=monthlySeries.articleSeries[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: GestureDetector(
                                  onTap: (){
                                    GoRouter.of(context).pushNamed("ArticleSeries");
                                  },
                                    child: thumbnailCard(MediaQuery.sizeOf(context).height*0.3, MediaQuery.sizeOf(context).width, articleSeries.title, articleSeries.image)
                                ),
                              );
                            },
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
