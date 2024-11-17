import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omshribhakti/provider/mantra_provier.dart';
import 'package:omshribhakti/utils/Colors.dart';
import 'package:omshribhakti/widgets/themeContainer.dart';

class MantraPage extends ConsumerStatefulWidget {
  const MantraPage({super.key});

  @override
  ConsumerState<MantraPage> createState() => _MantraPageState();
}

class _MantraPageState extends ConsumerState<MantraPage> {
  final bool _icon = false;


  final ScrollController _scrollController = ScrollController();



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {

      ref.read(mantrasProvider.notifier).fetchMantras(isInitialLoad: true);

    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        ref.read(mantrasProvider.notifier).fetchMantras();

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


    final mantrasState = ref.watch(mantrasProvider);


    return Scaffold(
      appBar: AppBar(
        title: Text("Mantras"),
      ),
      body:mantrasState.isLoading && mantrasState.mantras.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
            padding: const EdgeInsets.all(4.0),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: mantrasState.mantras.length +
                  (mantrasState.hasMore ? 1 : 0), // Add 1 for the loader
              itemBuilder: (context, index) {
                if (index == mantrasState.mantras.length) {
                  // Loader at the bottom
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final mantra = mantrasState.mantras[index];
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
                                mantra.category,
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
                            itemCount: mantra.mantra.length, // Static count for demo
                            itemBuilder: (context, index1) {

                              return Card(
                                elevation: 0,
                                child: ExpansionTile(
                                  childrenPadding: EdgeInsets.all(10),
                                  expandedCrossAxisAlignment:
                                  CrossAxisAlignment.end,
                                  title: Text(
                                    mantra.mantra[index1].title,
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
                                      data: mantra.mantra[index1].description,
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
    );
  }
}
