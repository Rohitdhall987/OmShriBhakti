import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:omshribhakti/utils/Colors.dart';
import 'package:omshribhakti/widgets/themeContainer.dart';

class MantraPage extends StatelessWidget {
  const MantraPage({super.key});
  final bool _icon = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mantras"),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 3, // Static count for demo
                itemBuilder: (context, index0) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: themeContainer(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Row(
                              children: [
                                Text(
                                  "Category ${index0 + 1}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 16,color: AppTheme.primary),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 3, // Static count for demo
                              itemBuilder: (context, index1) {
                                String htmlContent =
                                    "<p>Sample mantra description in HTML.</p>";
                                return Card(
                                  elevation: 0,
                                  child: ExpansionTile(
                                    childrenPadding: EdgeInsets.all(10),
                                    expandedCrossAxisAlignment:
                                    CrossAxisAlignment.end,
                                    title: Text(
                                      "Mantra ${index1 + 1}",
                                      style: TextStyle(
                                        color:
                                        _icon ? Colors.black : Colors.black,
                                      ),
                                    ),
                                    trailing: Icon(
                                      _icon
                                          ? Icons.arrow_drop_down_circle
                                          : Icons.arrow_drop_down,
                                      color: _icon ? Colors.black : Colors.black,
                                    ),
                                    children: [
                                      Html(
                                        data: htmlContent,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            // Navigate to the music player or audio functionality
                                            print("Play Mantra Audio");
                                          },
                                          child: Container(
                                            width: 90,
                                            decoration: BoxDecoration(
                                              color: AppTheme.primary,
                                              borderRadius:
                                              BorderRadius.circular(5),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 4.0, horizontal: 8),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        right: 10.0),
                                                    child: Text(
                                                      "Listen",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.headphones,
                                                    color: Colors.white,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                    onExpansionChanged: (condition) {
                                      // Handle expansion change if needed
                                    },
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
