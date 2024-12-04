import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omshribhakti/model/tour_category_model.dart';
import 'package:omshribhakti/model/tour_trips_model.dart';
import 'package:omshribhakti/provider/auth_provider.dart';
import 'package:omshribhakti/services/tour_services.dart';
import 'package:omshribhakti/widgets/trendingProduct.dart';

class AllTours extends ConsumerStatefulWidget {
  const AllTours({super.key});

  @override
  ConsumerState<AllTours> createState() => _AllToursState();
}

class _AllToursState extends ConsumerState<AllTours> {
  final TourServices tourServices = TourServices();
  TourCategoryModel? categories;
  final Map<int, ScrollController> _scrollControllers = {};
  final Map<int, List<AllTrips>> _trips = {};
  final Map<int, bool> _loading = {};
  final Map<int, bool> _hasMore = {};
  final Map<int, int> _lastId = {};

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  @override
  void dispose() {
    // Dispose all scroll controllers
    _scrollControllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  Future<void> fetchCategories() async {
    final user = ref.read(customUserProvider);
    categories = await tourServices.fetchTourCategory(user!.apiData!['token']);
    if (categories != null) {
      for (var category in categories!.tripCategories) {
        final categoryId = category.id;
        _scrollControllers[categoryId] = ScrollController();
        _trips[categoryId] = [];
        _loading[categoryId] = false;
        _hasMore[categoryId] = true;
        _lastId[categoryId] = 0;

        // Add scroll listener for infinite scroll
        _scrollControllers[categoryId]!.addListener(() {
          if (_scrollControllers[categoryId]!.position.pixels >=
              _scrollControllers[categoryId]!.position.maxScrollExtent &&
              !_loading[categoryId]! &&
              _hasMore[categoryId]!) {
            print('Scroll triggered for category $categoryId');
            fetchTrips(categoryId);
          }
        });

        // Fetch initial data for each category
        fetchTrips(categoryId);
      }
    }
    setState(() {});
  }

  Future<void> fetchTrips(int categoryId) async {
    if (_loading[categoryId]!) return;

    print('Fetching trips for category $categoryId...');
    _loading[categoryId] = true;

    final user = ref.read(customUserProvider);
    final newTrips = await tourServices.fetchTourByCategory(
      user!.apiData!['token'],
      categoryId,
      _lastId[categoryId]!,
    );

    setState(() {
      if (newTrips.isNotEmpty) {
        _trips[categoryId]!.addAll(newTrips);
        _lastId[categoryId] = newTrips.last.id;
      } else {
        _hasMore[categoryId] = false;
      }
      _loading[categoryId] = false;
    });

    print('Trips fetched for category $categoryId: ${newTrips.length}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: categories != null
            ? SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Categories",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  itemCount: categories!.tripCategories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final category = categories!.tripCategories[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          // Handle category tap if needed
                        },
                        child: Text(
                          category.title,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Trending Tours",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              ...categories!.tripCategories.map((category) {
                final categoryId = category.id;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        category.title,
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height*0.25,
                      child: ListView.builder(
                        controller: _scrollControllers[categoryId],
                        scrollDirection: Axis.horizontal,
                        itemCount: _trips[categoryId]!.length ,
                        itemBuilder: (context, index) {
                          // if (index == _trips[categoryId]!.length) {
                          //   // If more data is available, show a progress indicator.
                          //   return const Center(
                          //     child: CircularProgressIndicator(),
                          //   );
                          // }
                          final trip = _trips[categoryId]![index];
                          return SizedBox(
                            width: MediaQuery.sizeOf(context).width*0.6,
                            child: trendingProduct(
                              trip.image,
                              trip.title,
                            ),
                          );
                        },
                      ),
                    ),

                  ],
                );
              }).toList(),
            ],
          ),
        )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
