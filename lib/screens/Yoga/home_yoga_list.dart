import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:omshribhakti/model/home_yoga_list_model.dart';
import 'package:omshribhakti/provider/auth_provider.dart';
import 'package:omshribhakti/services/yoga_services.dart';

class HomeYogaLists extends ConsumerStatefulWidget {
  final String apiName;
  const HomeYogaLists({super.key, required this.apiName});

  @override
  ConsumerState<HomeYogaLists> createState() => _HomeYogaListsState();
}

class _HomeYogaListsState extends ConsumerState<HomeYogaLists> {
  final ScrollController _scrollController = ScrollController();
  int lastId = 0;
  bool isLoading = false;
  bool hasMore = true;

  final YogaService yogaService = YogaService();
  List<YogaList> yoga = [];

  @override
  void initState() {
    super.initState();
    fetchData();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent && !isLoading && hasMore) {
      fetchData();
    }
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final user = ref.read(customUserProvider);
      final newData = await yogaService.fetchYogaByApi(widget.apiName, user!.apiData!['token'], lastId);

      if (newData.isNotEmpty) {
        setState(() {
          yoga.addAll(newData);
          lastId = yoga.last.id; // Update lastId with the last item's id
        });
      } else {
        setState(() {
          hasMore = false;
        });
      }
    } catch (e) {
      print("Error fetching data: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Yogas",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                if (yoga.isEmpty && isLoading)
                  const Center(child: CircularProgressIndicator()),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: yoga.length,
                  itemBuilder: (context, index) {
                    final _yoga = yoga[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          GoRouter.of(context).pushNamed("VideoPlayer");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.orange.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      const Text(
                                        "Exercise",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        (index + 1).toString(),
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(child: Text(_yoga.title)),
                              const Icon(Icons.play_circle, color: Colors.white),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                if (!isLoading && yoga.isEmpty)
                  const Center(
                    child: Text(
                      "No Yoga",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                if (hasMore && isLoading && yoga.isNotEmpty)
                  const Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
