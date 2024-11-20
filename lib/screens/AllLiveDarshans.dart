import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:omshribhakti/provider/all_live_darshan_provider.dart';
// import 'package:go_router/go_router.dart';
import 'package:omshribhakti/widgets/ThumbnailCard.dart';

class AllLiveDarshans extends ConsumerStatefulWidget {
  const AllLiveDarshans({super.key});

  @override
  ConsumerState<AllLiveDarshans> createState() => _AllLiveDarshansState();
}

class _AllLiveDarshansState extends ConsumerState<AllLiveDarshans> {

  final ScrollController _scrollController = ScrollController();


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {

      ref.read(allLiveDarshanProvider.notifier).fetchAllLiveDarshan(isInitialLoad: true);

    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        ref.read(allLiveDarshanProvider.notifier).fetchAllLiveDarshan();
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
    final LiveDarshanState = ref.watch(allLiveDarshanProvider);
    return Scaffold(
      appBar: AppBar(
        title:const Text("Live Darshans"),
      ),
      body: LiveDarshanState.isLoading && LiveDarshanState.liveDarshans.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        controller: _scrollController,
        itemCount: LiveDarshanState.liveDarshans.length +
            (LiveDarshanState.hasMore ? 1 : 0), // Add 1 for the loader
        itemBuilder: (context, index) {
          if (index == LiveDarshanState.liveDarshans.length) {
            // Loader at the bottom
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          final liveDarshan = LiveDarshanState.liveDarshans[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () =>
                  GoRouter.of(context).pushNamed("VideoPlayer"),
              child: thumbnailCard(
                MediaQuery.sizeOf(context).height * 0.3,
                MediaQuery.sizeOf(context).width,
                liveDarshan.title,
                liveDarshan.image,
              ),
            ),
          );
        },
      ),
    );
  }
}
