import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:omshribhakti/model/product_category.dart';
import 'package:omshribhakti/model/random_products_model.dart';
import 'package:omshribhakti/provider/auth_provider.dart';
import 'package:omshribhakti/services/ecom_services.dart';
import 'package:omshribhakti/widgets/CachedNetworkImage.dart';
import 'package:omshribhakti/widgets/trendingProduct.dart';

class EcomHome extends ConsumerStatefulWidget {
  const EcomHome({super.key});

  @override
  ConsumerState<EcomHome> createState() => _EcomHomeState();
}

class _EcomHomeState extends ConsumerState<EcomHome> {
  int lastId=0;

  final ScrollController _scrollController = ScrollController();


  final EcomServices ecomServices=EcomServices();

  List<RandomProducts> randomProducts=[];
  List<Catgeory> categories=[];

  @override
  void initState() {
    super.initState();
    fetchCategories();
    fetchData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchData();
      }
    });
  }

  void fetchCategories()async{
    final user=ref.read(customUserProvider);
    categories=await ecomServices.fetchProductCategory(user!.apiData!['token']);
    setState(() {

    });
  }

  void fetchData()async{
    final user=ref.read(customUserProvider);
    final newData=await ecomServices.fetchRandomProducts(user!.apiData!['token'], lastId);
    print("randomProducts");
    setState(() {
      randomProducts.addAll(newData);

      print(randomProducts);
    });
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Text("Category",
                    style:TextStyle(
                        color: Colors.white
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: (MediaQuery.sizeOf(context).height*0.1)+36,
                child:
                   !categories.isNotEmpty ?
                       ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                          itemCount: 8,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context,index){
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  SizedBox(
                                      height: MediaQuery.sizeOf(context).height*0.1,
                                      width: MediaQuery.sizeOf(context).height*0.1,
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(100),
                                          child: cachedNetworkImage("https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png", BoxFit.fitHeight)
                                      )
                                  ),
                                  const Text("Loading",
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                      )
                    :
                     ListView.builder(
                      itemCount: categories.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(
                                  height: MediaQuery.sizeOf(context).height*0.1,
                                  width: MediaQuery.sizeOf(context).height*0.1,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                      child: GestureDetector(
                                        onTap: (){
                                          GoRouter.of(context).pushNamed("ProductByCategory",
                                            pathParameters: {
                                              "id":categories[index].id.toString(),
                                              "name":categories[index].categoryName,
                                            }
                                          );
                                        },
                                          child: cachedNetworkImage(categories[index].categoryImg, BoxFit.fitHeight)
                                      )
                                  )
                              ),
                              Text(categories[index].categoryName,
                                style:const TextStyle(
                                  color: Colors.white
                                ),
                              )
                            ],
                          ),
                        );
                    }
                    )


              ),
             const SizedBox(
                height: 16,
              ),
             const Row(
                children: [
                  Text("Trending Products",
                    style:TextStyle(
                      color: Colors.white
                    ),
                  ),
                ],
              ),
             const SizedBox(
                height: 16,
              ),

              randomProducts.isNotEmpty?

                       GridView.builder(
                      shrinkWrap: true,
                      physics:const NeverScrollableScrollPhysics(),
                      itemCount: randomProducts.length,
                      gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 16,crossAxisSpacing: 16),
                      itemBuilder: (context,index){
                        lastId=randomProducts[index].productId;
                        return GestureDetector(
                            onTap: ()=>GoRouter.of(context).pushNamed("ProductDetails",pathParameters: {
                              'id':randomProducts[index].productId.toString(),
                            }),
                            child: trendingProduct(randomProducts[index].image_1, randomProducts[index].title)
                        );
                      }
                  ):
              GridView.builder(
                  shrinkWrap: true,
                  physics:const NeverScrollableScrollPhysics(),
                  itemCount: 8,
                  gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 16,crossAxisSpacing: 16),
                  itemBuilder: (context,index){
                    return trendingProduct("https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png", "item $index");
                  }
              )

            ],
          ),
        ),
      ),
    );
  }
}
