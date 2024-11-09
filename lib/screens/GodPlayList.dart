import 'package:flutter/material.dart';
import 'package:omshribhakti/utils/Colors.dart';
import 'package:omshribhakti/widgets/CachedNetworkImage.dart';
import 'package:omshribhakti/widgets/SongTitleCard.dart';

class GodPlaylist extends StatefulWidget {
  const GodPlaylist({super.key,required this.id,required this.name});

  final int id;
  final String name;

  @override
  State<GodPlaylist> createState() => _GodPlaylistState();
}

class _GodPlaylistState extends State<GodPlaylist> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
        ),
        body: SizedBox(
          height: double.maxFinite,
          width: double.maxFinite,
          child: Stack(
            children: [
              cachedNetworkImage( "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png", BoxFit.fitWidth),
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height*0.15,
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
                            height: 20,
                          ),
                          TabBar(
                            dividerHeight: 0,
                            indicatorColor: AppTheme.primary,
                            labelColor: AppTheme.primary,
                            unselectedLabelColor: Colors.white,
                            tabs: [
                              Tab(text: "Tab 1"),
                              Tab(text: "Tab 2"),
                              Tab(text: "Tab 3"),
                            ],

                          ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          // Tab 1 content
                          ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return  songTitleCard(context: context,id: index,name: "Something",);

                            },
                          ),
                          // Tab 2 content
                          ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return  songTitleCard(context: context,id: index,name: "Something",);
                            },
                          ),
                          // Tab 3 content
                          ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return  songTitleCard(context: context,id: index,name: "Something",);
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
