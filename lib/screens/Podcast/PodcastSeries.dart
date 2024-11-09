import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:omshribhakti/widgets/CachedNetworkImage.dart';

class PodcastSeriesPage extends StatefulWidget {
  const PodcastSeriesPage({super.key});

  @override
  State<PodcastSeriesPage> createState() => _PodcastSeriesPageState();
}

class _PodcastSeriesPageState extends State<PodcastSeriesPage> {
  final List<Map<String, String>> podcastList = [
    {
      "id": "1",
      "title": "Powerful Morning Mantras",
      "image": "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png"
    },
    {
      "id": "2",
      "title": "Meditative Evening Chants",
      "image": "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png"
    },
    // Add more dummy podcast items here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Podcast",
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: podcastList.length,
              itemBuilder: (context, index) {
                final podcast = podcastList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4),
                  child: GestureDetector(
                    onTap: () {
                      GoRouter.of(context).pushNamed("SanatanPodcast", pathParameters: {
                        'id': podcast["id"]!,
                      });
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            height: 190,
                            width: MediaQuery.of(context).size.width,
                            child: cachedNetworkImage(podcast["image"]!, BoxFit.fitWidth),
                          ),
                          Container(
                            height: 190,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black54,
                                  Colors.transparent,
                                  Colors.transparent,
                                  Colors.black54,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [0.0, 0.3, 0.7, 1],
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Icon(Icons.headphones, color: Colors.white),
                                  SizedBox(width: 4),
                                  Container(
                                    width: MediaQuery.of(context).size.width / 1.3,
                                    child: Text(
                                      podcast["title"]!,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(Icons.share, color: Colors.white),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(color: Colors.redAccent),
          ],
        ),
      ),
    );
  }
}
