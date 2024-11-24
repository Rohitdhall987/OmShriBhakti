import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omshribhakti/provider/auth_provider.dart';
import 'package:omshribhakti/provider/yoga_all_category_provider.dart';
import 'package:omshribhakti/widgets/YogaCategory.dart';

class AllYogaCategory extends ConsumerStatefulWidget {
  const AllYogaCategory({super.key});

  @override
  ConsumerState<AllYogaCategory> createState() => _AllYogaCategoryState();
}

class _AllYogaCategoryState extends ConsumerState<AllYogaCategory> {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final customUser = ref.watch(customUserProvider);

      ref.read(yogaAllCategoryProvider.notifier).fetchQuotesCategory(isInitialLoad: true,token: customUser!.apiData!["token"]);

    });

  }


  @override
  Widget build(BuildContext context) {
    final yoga = ref.watch(yogaAllCategoryProvider);
    return  Scaffold(
      body: SafeArea(
        child:yoga.isLoading && yoga.allCategory.isNotEmpty?
              const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Category",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text("Get rid of your body problems with yoga and aurvedic medicine",
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
                    itemCount: yoga.allCategory.length,
                    itemBuilder: (context,index){
                      final category=yoga.allCategory[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: yogaCategoryCard(
                            height: MediaQuery.sizeOf(context).height*0.14,
                            width: MediaQuery.sizeOf(context).width,
                            category: category
                        ),
                      );
                    }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
