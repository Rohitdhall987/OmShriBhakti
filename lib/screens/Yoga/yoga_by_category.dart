import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:omshribhakti/provider/auth_provider.dart';
import 'package:omshribhakti/provider/yoga_by_category_provider.dart';

class YogaByCategory extends ConsumerStatefulWidget {
  final int id;
  final String title;
  const YogaByCategory({super.key,required this.id,required this.title});

  @override
  ConsumerState<YogaByCategory> createState() => _YogaByCategoryState();
}

class _YogaByCategoryState extends ConsumerState<YogaByCategory> {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final customUser = ref.watch(customUserProvider);

      ref.read(yogaByCategoryProvider.notifier).fetchYogaByCategory(isInitialLoad: true,token: customUser!.apiData!["token"],id:widget.id);

    });

  }


  @override
  Widget build(BuildContext context) {
    final yoga = ref.watch(yogaByCategoryProvider);
    return  Scaffold(
      body: SafeArea(
        child:yoga.isLoading && yoga.allYoga.isNotEmpty?
        const Center(
          child: CircularProgressIndicator(),
        )
            : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics:const NeverScrollableScrollPhysics(),
                    itemCount: yoga.allYoga.length,
                    itemBuilder: (context,index){
                      final _yoga=yoga.allYoga[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child:GestureDetector(
                          onTap: (){
                            GoRouter.of(context).pushNamed("VideoPlayer");
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.orange.shade300,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Row(
                              children: [
                                 Container(
                                   decoration: BoxDecoration(
                                     color: Colors.orange,
                                     borderRadius: BorderRadius.circular(10)
                                   ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text("Exercise",style: TextStyle(color: Colors.white),),
                                        Text((index+1).toString(),style: TextStyle(color: Colors.white),)
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(child: Text(_yoga.title)),
                                Icon(Icons.play_circle,color: Colors.white,),
                                SizedBox(
                                  width: 8,
                                ),
                              ],
                            ),
                          ),
                        )
                      );
                    }
                ),
                if(yoga.allYoga.isEmpty)const Center(child: Text("No Yoga",style: TextStyle(color: Colors.white),),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
