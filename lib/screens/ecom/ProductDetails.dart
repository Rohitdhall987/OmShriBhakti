import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omshribhakti/provider/auth_provider.dart';
import 'package:omshribhakti/services/ecom_services.dart';
import 'package:omshribhakti/utils/Colors.dart';

class ProductDetails extends ConsumerStatefulWidget {
  final String productId;
  const ProductDetails({super.key,required this.productId});

  @override
  ConsumerState<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends ConsumerState<ProductDetails> {

  Map<String,dynamic>productData={};

  List<String> images =[];
  int itemcount = 1;

  bool loaded=false;

  EcomServices ecomServices=EcomServices();



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {

      fetchData();

    });

  }

  void fetchData()async{
    final user=ref.read(customUserProvider);
    productData=await ecomServices.fetchProductsDetails(user!.apiData!["token"],widget.productId);
    productData=productData["products"];
    images=[productData["image_1"]];
    if(productData["image_2"]!=null){
      images.add(productData["image_2"]);
    }
    if(productData["image_3"]!=null){
      images.add(productData["image_3"]);
    }
    setState(() {
      loaded=true;
    });
  }




  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
      ),
      body: loaded?Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            height: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image carousel
                  CarouselSlider(
                    items: images.map((imgUrl) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            imgUrl,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                          ),
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      height: 200,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 9,
                    ),
                  ),

                  // Product title and price
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productData["title"],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              "₹${(int.parse(productData["price"]) * (1 - int.parse(productData["discount"]) / 100)).toStringAsFixed(2)}",
                              style:  TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primary
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "₹${productData["price"]}",
                              style: const TextStyle(
                                fontSize: 14,
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${productData["discount"]}% OFF",
                          style: const TextStyle(
                            color: AppTheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Quantity section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (itemcount > 1) {
                                  setState(() {
                                    itemcount--;
                                  });
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppTheme.primary,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding: const EdgeInsets.all(8),
                                child: const Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                itemcount.toString(),
                                style: const TextStyle(fontSize: 18,color: Colors.white),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if(itemcount<int.parse(productData["quantity"])){
                                  setState(() {
                                    itemcount++;
                                  });
                                }
                                // Increment logic
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppTheme.primary,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding: const EdgeInsets.all(8),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Quantity left: ${productData["quantity"]}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Product description
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Description",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Html(
                      data: productData["description"],
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

          // Bottom "Place Order" button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {
                // Place order logic
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    int.parse(productData["quantity"]) > 0
                        ? "Place Order"
                        : "Out of Stock",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ):const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
