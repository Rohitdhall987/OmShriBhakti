import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:omshribhakti/widgets/CachedNetworkImage.dart';

class ReadArticle extends StatelessWidget {
  const ReadArticle({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data for placeholders
    final String dummyTitle = "Sample Topic Title";
    final String dummyDescription = "<p>This is a sample description with HTML content to demonstrate layout.</p><p>It includes <b>bold text</b>, <i>italic text</i>, and other <u>HTML elements</u>.</p>";
    final String dummyImage = 'https://via.placeholder.com/150';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Read Article",
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // Placeholder for image banner
                  Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child:cachedNetworkImage("https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png", BoxFit.fitWidth)
                  ),

                  // Title and share button
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 40,
                          child: Text(
                            dummyTitle,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Dummy action for share
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Share icon tapped")),
                            );
                          },
                          child: const Icon(Icons.share,color: Colors.white,),
                        ),
                      ],
                    ),
                  ),

                  // HTML Content with white text style
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Html(
                      data: dummyDescription,
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
        ],
      ),
    );
  }
}
