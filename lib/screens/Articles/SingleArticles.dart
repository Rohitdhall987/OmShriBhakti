

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:omshribhakti/model/month_article.dart';
import 'package:omshribhakti/provider/auth_provider.dart';
import 'package:omshribhakti/services/article_service.dart';
import 'package:omshribhakti/widgets/ThumbnailCard.dart';

class SingleArticlesList extends ConsumerStatefulWidget {
  final String id;
  const SingleArticlesList({super.key,required this.id});

  @override
  ConsumerState<SingleArticlesList> createState() => _SingleArticlesListState();
}

class _SingleArticlesListState extends ConsumerState<SingleArticlesList> {

  SingleMonthArticle? monthlySeries;

  bool loaded=false;

  int? lastId;


  final ScrollController _scrollController = ScrollController();

  final ArticleService _articleService=ArticleService();



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // fetchData();
      }
    });
  }


  void fetchData()async{
    final user=ref.read(customUserProvider);
    monthlySeries=await _articleService.fetchMonthlySingleArticleById(user!.apiData!['token'], widget.id, lastId);
    loaded=true;
    setState(() {

    });
  }





  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:monthlySeries==null && !loaded?
          const Center(
            child: CircularProgressIndicator(),
          )
          : ListView.builder(
        controller: _scrollController,
        itemCount: monthlySeries!.singleArticles.length,
        itemBuilder: (context,index){
          if( index==monthlySeries!.singleArticles.length+1){
            return const Center(child: CircularProgressIndicator(),);
          }
          final singleArticle=monthlySeries!.singleArticles[index];
          lastId=singleArticle.id;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: GestureDetector(
                onTap: (){
                  GoRouter.of(context).pushNamed("ReadArticle",
                    pathParameters: {
                      'id':singleArticle.id.toString(),
                    }
                  );
                },
                child: thumbnailCard(MediaQuery.sizeOf(context).height*0.3, MediaQuery.sizeOf(context).width, singleArticle.title, singleArticle.image)
            ),
          );
        },
      ),
    );
  }
}
