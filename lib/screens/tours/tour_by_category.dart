import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omshribhakti/model/tour_trips_model.dart';
import 'package:omshribhakti/provider/auth_provider.dart';
import 'package:omshribhakti/services/tour_services.dart';
import 'package:omshribhakti/widgets/trendingProduct.dart';

class TourByCategory extends ConsumerStatefulWidget {
  final String categoryId;
  final String name;
  const TourByCategory(
      {super.key, required this.categoryId, required this.name});

  @override
  ConsumerState<TourByCategory> createState() => _TourByCategoryState();
}

class _TourByCategoryState extends ConsumerState<TourByCategory> {
  final TourServices tourServices = TourServices();
  final ScrollController scrollController = ScrollController();

  List<AllTrips> trips = [];
  int lastId = 0;
  bool hasMore = true;
  bool isLoadingMore = false;
  bool initialLoad = true;

  @override
  void initState() {
    super.initState();
    fetchData(true);

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200 &&
          hasMore &&
          !isLoadingMore) {
        fetchData(false);
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void fetchData(bool isInitialLoad) async {
    if (isInitialLoad) {
      setState(() {
        initialLoad = true;
      });
    } else {
      setState(() {
        isLoadingMore = true;
      });
    }

    final user = ref.read(customUserProvider);
    final newTrips = await tourServices.fetchTourByCategory(
        user!.apiData!['token'], widget.categoryId, lastId);

    setState(() {
      if (newTrips.isNotEmpty) {
        trips.addAll(newTrips);
        lastId = newTrips.last.id; // Assuming trips have an `id` field
      } else {
        hasMore = false;
      }

      initialLoad = false;
      isLoadingMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: initialLoad
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: trips.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    // Uncomment and adjust the navigation logic if required
                    // onTap: () => GoRouter.of(context).pushNamed(
                    //   "ProductDetails",
                    //   pathParameters: {
                    //     'id': trips[index].id.toString(),
                    //   },
                    // ),
                    child: trendingProduct(
                      trips[index].image,
                      trips[index].title,
                    ),
                  );
                },
              ),
              if (isLoadingMore)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
