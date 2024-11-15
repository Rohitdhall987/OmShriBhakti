import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:omshribhakti/widgets/CachedNetworkImage.dart';
import 'package:omshribhakti/widgets/trendingProduct.dart';

class EcomHome extends StatelessWidget {
  const EcomHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Text("Category",
                    style:TextStyle(
                        color: Colors.white
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 96,
                child: ListView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          height: 80,
                          width: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                              child: GestureDetector(
                                onTap: (){
                                  GoRouter.of(context).pushNamed("ProductByCategory");
                                },
                                  child: cachedNetworkImage("https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png", BoxFit.fitHeight)
                              )
                          )
                      ),
                    );
                }
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Text("Random Items",
                    style:TextStyle(
                      color: Colors.white
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics:const NeverScrollableScrollPhysics(),
                itemCount: 5,
                  gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 16,crossAxisSpacing: 16),
                  itemBuilder: (context,index){
                    return GestureDetector(
                        onTap: ()=>GoRouter.of(context).pushNamed("ProductDetails"),
                        child: trendingProduct("https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png", "item $index")
                    );
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
