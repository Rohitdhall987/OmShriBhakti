import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:omshribhakti/provider/podcast_series_provider.dart';
import 'package:omshribhakti/widgets/CachedNetworkImage.dart';

class SingleSeries extends ConsumerStatefulWidget {
  final int id;
  const SingleSeries({super.key,required this.id});

  @override
  ConsumerState<SingleSeries> createState() => _SingleSeriesState();
}

class _SingleSeriesState extends ConsumerState<SingleSeries> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(singleSeriesProvider.notifier).fetchSingleSeries(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(singleSeriesProvider);
    final podcast=state.podcast!;
    return Scaffold(
      body: state.isLoading?
          const Center(
            child: CircularProgressIndicator(),
          )
      :SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: cachedNetworkImage(podcast.audio.image, BoxFit.fitWidth)
            ),

            // Song title and share button
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                    podcast.audio.title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),
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
                children:  [
                  Text(
                    "Total parts ${podcast.audioSeason.length}",
                    style:const TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                ],
              ),
            ),

            ListView.builder(
                physics:const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: podcast.audioSeason.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                        GoRouter.of(context).pushNamed("MusicPlayerPage");
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: cachedNetworkImage(podcast.audioSeason[index].image, BoxFit.fitHeight)
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
