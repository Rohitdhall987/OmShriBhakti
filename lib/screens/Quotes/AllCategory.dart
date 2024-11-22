import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omshribhakti/provider/quotes_category_provider.dart';
import 'package:omshribhakti/utils/Colors.dart';
import 'package:omshribhakti/widgets/CachedNetworkImage.dart';
import 'package:omshribhakti/widgets/quotesThumbnail.dart';
import 'package:omshribhakti/widgets/themeContainer.dart';

class QuotesAllCategory extends ConsumerStatefulWidget {
  const QuotesAllCategory({super.key});

  @override
  ConsumerState<QuotesAllCategory> createState() => _QuotesAllCategoryState();
}

class _QuotesAllCategoryState extends ConsumerState<QuotesAllCategory> {





  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {

      ref.read(quotesAllCategoryProvider.notifier).fetchQuotesCategory(isInitialLoad: true);

    });
  }







  @override
  Widget build(BuildContext context) {


    final quotesAllCategoryState = ref.watch(quotesAllCategoryProvider);


    return Scaffold(

      appBar: AppBar(
        title:const Text("Category"),
      ),
      body:quotesAllCategoryState.isLoading && quotesAllCategoryState.allCategory.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
          itemCount: quotesAllCategoryState.allCategory.length ,
          gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8
          ),
          itemBuilder: (context,index){

            final category = quotesAllCategoryState.allCategory[index];

            return themeContainer(
              child: GestureDetector(
                  // onTap: ()=>GoRouter.of(context).pushNamed("GodPlaylist",
                  //     pathParameters: {
                  //       "id":god.id.toString(),
                  //       "name":god.name,
                  //     }
                  // ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [

                        Expanded(
                            flex: 3,
                            child: SizedBox(
                              width: double.infinity,
                              child: cachedNetworkImage(category.image,BoxFit.fitHeight),
                            )
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Expanded(
                                child: Text(
                                  category.Title,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  category.hindiTitle, // Adjust this key based on your API response
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

              ),
            );
          }
      ),
    );
  }
}
