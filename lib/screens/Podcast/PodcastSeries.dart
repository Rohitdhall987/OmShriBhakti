import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:omshribhakti/provider/music_player_provider.dart';
import 'package:omshribhakti/provider/podcast_provider.dart';
import 'package:omshribhakti/widgets/CachedNetworkImage.dart';
import 'package:omshribhakti/widgets/ThumbnailCard.dart';

class PodcastSeriesPage extends ConsumerStatefulWidget {
  const PodcastSeriesPage({super.key});

  @override
  ConsumerState<PodcastSeriesPage> createState() => _PodcastSeriesPageState();
}

class _PodcastSeriesPageState extends ConsumerState<PodcastSeriesPage> {
  // final List<Map<String, String>> podcastList = [
  //   {
  //     "id": "1",
  //     "title": "Powerful Morning Mantras",
  //     "image": "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png"
  //   },
  //   {
  //     "id": "2",
  //     "title": "Meditative Evening Chants",
  //     "image": "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png"
  //   },
  //   // Add more dummy podcast items here
  // ];


  final ScrollController _scrollController = ScrollController();



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {

      ref.read(podcastProvider.notifier).fetchPodcast(isInitialLoad: true);

    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        ref.read(podcastProvider.notifier).fetchPodcast();

      }
    });
  }





  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }





  @override
  Widget build(BuildContext context) {
    final podcastState = ref.watch(podcastProvider);
    
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Podcast",
        ),
      ),
      body: podcastState.isLoading && podcastState.sanatanPodcat.isEmpty
          ? const Center(child: CircularProgressIndicator())
          :ListView.builder(
        controller: _scrollController,
        shrinkWrap: true,
        itemCount: podcastState.sanatanPodcat.length +
            (podcastState.hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == podcastState.sanatanPodcat.length) {
            // Loader at the bottom
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          final podcast = podcastState.sanatanPodcat[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4),
            child:  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).pushNamed("SingleSeries");
                    },
                    child: thumbnailCard(MediaQuery.of(context).size.height*0.3, MediaQuery.of(context).size.width, podcast.title, podcast.image),
                    // child: ClipRRect(
                    //   borderRadius: BorderRadius.circular(10),
                    //   child: Stack(
                    //     alignment: Alignment.bottomRight,
                    //     children: [
                    //       Container(
                    //         height: 190,
                    //         width: MediaQuery.of(context).size.width,
                    //         child: cachedNetworkImage(podcast["image"]!, BoxFit.fitWidth),
                    //       ),
                    //       Container(
                    //         height: 190,
                    //         width: MediaQuery.of(context).size.width,
                    //         decoration: BoxDecoration(
                    //           gradient: LinearGradient(
                    //             colors: [
                    //               Colors.black54,
                    //               Colors.transparent,
                    //               Colors.transparent,
                    //               Colors.black54,
                    //             ],
                    //             begin: Alignment.topCenter,
                    //             end: Alignment.bottomCenter,
                    //             stops: [0.0, 0.3, 0.7, 1],
                    //           ),
                    //         ),
                    //         child: Padding(
                    //           padding: const EdgeInsets.all(8.0),
                    //           child: Row(
                    //             crossAxisAlignment: CrossAxisAlignment.end,
                    //             children: [
                    //               Icon(Icons.headphones, color: Colors.white),
                    //               SizedBox(width: 4),
                    //               Container(
                    //                 width: MediaQuery.of(context).size.width / 1.3,
                    //                 child: Text(
                    //                   podcast["title"]!,
                    //                   overflow: TextOverflow.ellipsis,
                    //                   style: TextStyle(color: Colors.white, fontSize: 16),
                    //                 ),
                    //               ),
                    //               SizedBox(width: 4),
                    //               Icon(Icons.share, color: Colors.white),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  )
          );
        },
      ),
    );
  }
}
