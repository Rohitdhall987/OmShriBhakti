import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:omshribhakti/utils/Colors.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data
    final Map<String, dynamic> productData = {
      "title": "Sample Product",
      "unit": "1kg",
      "price": "500",
      "discount": "20",
      "quantity": "10",
      "description":
      "<p>This is a <b>sample product description</b> with some HTML formatting.</p><p>It contains details about the product, including specifications and usage information.</p>",
      "images": [
        "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png",
        "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png",
        "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png"
      ]
    };
    List<String> images = productData["images"];
    int itemcount = 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Product"),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SingleChildScrollView(
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
                                // Decrement logic
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
      ),
    );
  }
}
