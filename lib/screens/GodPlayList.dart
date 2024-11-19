import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:omshribhakti/model/GodDataModel.dart';
import 'package:omshribhakti/services/gods_services.dart';
import 'package:omshribhakti/utils/Colors.dart';
import 'package:omshribhakti/widgets/CachedNetworkImage.dart';
import 'package:omshribhakti/widgets/SongTitleCard.dart';

class GodPlaylist extends ConsumerStatefulWidget {
  const GodPlaylist({super.key,required this.id,required this.name});

  final int id;
  final String name;

  @override
  ConsumerState<GodPlaylist> createState() => _GodPlaylistState();
}

class _GodPlaylistState extends ConsumerState<GodPlaylist> {

  GodDataModel? godData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_)async{
      final fetchedData = await ref.read(godsServiceProvider).fetchGodsPlaylist(widget.id);
      setState(() {
        godData = fetchedData;
      });
    });
  }


  @override
  Widget build(BuildContext context) {

    return godData == null ?
        const Center(
          child: CircularProgressIndicator(),
        )
    :DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
        ),
        body: SizedBox(
          height: double.maxFinite,
          width: double.maxFinite,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width*0.8,
                  child: cachedNetworkImage( godData!.godImage.image, BoxFit.fitWidth)
              ),
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height*0.25,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
                        color: AppTheme.background
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          TabBar(
                            dividerHeight: 0,
                            indicatorColor: AppTheme.primary,
                            labelColor: AppTheme.primary,
                            unselectedLabelColor: Colors.white,
                            tabs: [
                              Tab(text: "Aarti"),
                              Tab(text: "Bhajan"),
                              Tab(text: "Chaisa"),
                              Tab(text: "Paath"),
                              Tab(text: "Others"),
                            ],

                          ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          // Tab 1 content
                          ListView.builder(
                            itemCount: godData!.aarti.length,
                            itemBuilder: (context, index) {
                              return  songTitleCard(context: context,id: godData!.aarti[index].id,name: godData!.aarti[index].title,singer:godData!.aarti[index].singer);
                            },
                          ),
                          // Tab 2 content
                          ListView.builder(
                            itemCount: godData!.bhajan.length,
                            itemBuilder: (context, index) {
                              return songTitleCard(context: context,id: godData!.bhajan[index].id,name: godData!.bhajan[index].title,singer:godData!.bhajan[index].singer);
                            },
                          ),
                          // Tab 3 content
                          ListView.builder(
                            itemCount: godData!.chalisa.length,
                            itemBuilder: (context, index) {
                              return songTitleCard(context: context,id: godData!.chalisa[index].id,name: godData!.chalisa[index].title,singer:godData!.chalisa[index].singer);
                            },
                          ),
                          // Tab 4 content
                          ListView.builder(
                            itemCount: godData!.paath.length,
                            itemBuilder: (context, index) {
                              return songTitleCard(context: context,id: godData!.paath[index].id,name: godData!.paath[index].title,singer:godData!.paath[index].singer);
                            },
                          ),
                          // Tab 5 content
                          ListView.builder(
                            itemCount: godData!.song.length,
                            itemBuilder: (context, index) {
                              return songTitleCard(context: context,id: godData!.song[index].id,name: godData!.song[index].title,singer:godData!.song[index].singer);
                            },
                          ),
                        ],
                      ),
                    ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
