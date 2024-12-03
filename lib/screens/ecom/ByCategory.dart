import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:omshribhakti/provider/auth_provider.dart';
import 'package:omshribhakti/services/ecom_services.dart';
import 'package:omshribhakti/widgets/trendingProduct.dart';

class ProductByCategory extends ConsumerWidget {
  final String name;
  final String id;
  const ProductByCategory({super.key,required this.name,required this.id});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    EcomServices ecomServices=EcomServices();
    final user=ref.watch(customUserProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: FutureBuilder(
        future: ecomServices.fetchProductByCategory(user!.apiData!['token'], id),
        builder: (context,snapshot) {
          if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
            final products=snapshot.data!;
            return GridView.builder(
                itemCount: products.length,
                gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 16,crossAxisSpacing: 16),
                itemBuilder: (context,index){
                  return GestureDetector(
                      onTap: ()=>GoRouter.of(context).pushNamed("ProductDetails",pathParameters: {
                        'id':products[index].productId.toString(),
                      }),
                      child: trendingProduct(products[index].image_1,products[index].title)
                  );
                }
            );
          }
          return GridView.builder(
              itemCount: 5,
              gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 16,crossAxisSpacing: 16),
              itemBuilder: (context,index){
                return trendingProduct("https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png", "item $index");
              }
          );
        }
      ),
    );
  }
}
