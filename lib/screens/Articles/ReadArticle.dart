import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omshribhakti/provider/auth_provider.dart';
import 'package:omshribhakti/services/article_service.dart';
import 'package:omshribhakti/widgets/CachedNetworkImage.dart';

class ReadArticle extends ConsumerWidget {
  final String id;
  const ReadArticle({super.key,required this.id});

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final user=ref.watch(customUserProvider);

     ArticleService articleService=ArticleService();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Read Article",
        ),
      ),
      body: FutureBuilder(
        future: articleService.getArticle(user!.apiData!['token'], id),
        builder: (context,snapshot) {
          if(!snapshot.hasData && snapshot.connectionState != ConnectionState.done){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final article=snapshot.data!;
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      // Placeholder for image banner
                      Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child:cachedNetworkImage(article.data.image, BoxFit.fitWidth)
                      ),

                      // Title and share button
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 40,
                              child: Text(
                                article.data.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
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

                      // HTML Content with white text style
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Html(
                          data: article.data.description,
                          style: {
                            "body": Style(
                              color: Colors.white, // Sets text color to white
                            ),
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
