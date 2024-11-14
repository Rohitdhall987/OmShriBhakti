import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:omshribhakti/widgets/CachedNetworkImage.dart';
import 'package:omshribhakti/widgets/ThumbnailCard.dart';

class SongSeries extends StatelessWidget {
  const SongSeries({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Dummy image banner
            SizedBox(
                height: 200,
                width: double.infinity,
                child: cachedNetworkImage("https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png", BoxFit.fitWidth)
            ),

            // Song title and share button
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Sample Song Title",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),
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

            // Total parts
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: const [
                  Text(
                    "Total parts: 10",
                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                ],
              ),
            ),

            ListView.builder(
                physics:const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                          onTap: ()=>GoRouter.of(context).pushNamed("MusicPlayerPage"),
                          child: thumbnailCard(null, null, "hu d fasnb jkdg shb jk dfas", "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png")
                      )
                  );
                }),
          ],
        ),
      ),
    );
  }
}
