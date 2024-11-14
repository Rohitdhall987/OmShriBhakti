import 'package:flutter/material.dart';
import 'package:omshribhakti/widgets/trendingProduct.dart';

class ProductByCategory extends StatelessWidget {
  const ProductByCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category"),
      ),
      body: GridView.builder(
          itemCount: 5,
          gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 16,crossAxisSpacing: 16),
          itemBuilder: (context,index){
            return trendingProduct("https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png", "item $index");
          }
      ),
    );
  }
}
