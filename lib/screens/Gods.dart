import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:omshribhakti/provider/gods_provider.dart';
import 'package:omshribhakti/widgets/GodCard.dart';

class Gods extends ConsumerStatefulWidget {
  const Gods({super.key});

  @override
  ConsumerState<Gods> createState() => _GodsState();
}

class _GodsState extends ConsumerState<Gods> {


  final ScrollController _scrollController = ScrollController();



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {

      ref.read(godsProvider.notifier).fetchGods(isInitialLoad: true);

    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        ref.read(godsProvider.notifier).fetchGods();

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


    final godState = ref.watch(godsProvider);


    return Scaffold(

      appBar: AppBar(
        title: Text("Gods"),
      ),
      body:godState.isLoading && godState.allGod.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
          controller: _scrollController,
          itemCount: godState.allGod.length +
              (godState.hasMore ? 1 : 0), // Add 1 for the loader
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8
          ),
          itemBuilder: (context,index){

            if (index == godState.allGod.length) {
              // Loader at the bottom
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            final god = godState.allGod[index];

            return GestureDetector(
              onTap: ()=>GoRouter.of(context).pushNamed("GodPlaylist",
                pathParameters: {
                  "id":god.id.toString(),
                  "name":god.name,
                }
              ),
                child: godCard(name: god.name, image: god.image,)
            );
          }
      ),
    );
  }
}
