import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:omshribhakti/provider/auth_provider.dart';
import 'package:omshribhakti/services/article_service.dart';
import 'package:omshribhakti/widgets/CachedNetworkImage.dart';
import 'package:omshribhakti/widgets/ThumbnailCard.dart';

class ArticleSeries extends ConsumerWidget {
  final String id;
  const ArticleSeries({super.key,required this.id});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final user=ref.watch(customUserProvider);
    ArticleService articleSeries= ArticleService();
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: articleSeries.fetchSingleWebReadingSeason(user!.apiData!['token'], id),
          builder: (context,snapshot) {
            if(!snapshot.hasData && snapshot.connectionState!=ConnectionState.done){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final singleWebReadingSeason=snapshot.data!;
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // Dummy image banner
                  SizedBox(
                      height: MediaQuery.sizeOf(context).height*0.3,
                      width: double.infinity,
                      child: cachedNetworkImage(singleWebReadingSeason.singleWebReading.image, BoxFit.fitWidth)
                  ),
            
                  // Song title and share button
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Text(
                          singleWebReadingSeason.singleWebReading.title,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Dummy action for share
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Share icon tapped")),
                            );
                          },
                          child: const Icon(Icons.share,color: Colors.white,),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children:  [
                        Text(
                          "Total parts: ${singleWebReadingSeason.seasons.length}",
                          style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                      ],
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Html(
                      data: singleWebReadingSeason.singleWebReading.description,
                      style: {
                        "body": Style(
                          color: Colors.white, // Sets text color to white
                        ),
                      },
                    ),
                  ),                  // Total parts

            
                  ListView.builder(
                      physics:const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: singleWebReadingSeason.seasons.length,
                      itemBuilder: (context, index) {
                        final season=singleWebReadingSeason.seasons[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: (){
                              GoRouter.of(context).pushNamed("ReadArticle",
                                pathParameters: {
                                  'id':season.id.toString(),
                                }
                              );
                            },
                              child: thumbnailCard(MediaQuery.sizeOf(context).height*0.3, MediaQuery.sizeOf(context).width, season.title, season.image)
                          )
                        );
                      }),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
