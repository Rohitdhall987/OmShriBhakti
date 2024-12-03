import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:omshribhakti/provider/Navigation_Provider.dart';
import 'package:omshribhakti/provider/auth_provider.dart';
import 'package:omshribhakti/services/ecom_services.dart';
import 'package:omshribhakti/services/live_darshan_service.dart';
import 'package:omshribhakti/services/quotes_services.dart';
import 'package:omshribhakti/utils/Colors.dart';
import 'package:omshribhakti/widgets/SliderCard.dart';
import 'package:omshribhakti/widgets/liveDarshanCard.dart';
import 'package:omshribhakti/widgets/MenuItem.dart';
import 'package:omshribhakti/widgets/quotesThumbnail.dart';
import 'package:omshribhakti/widgets/speciaIItem.dart';
import 'package:omshribhakti/widgets/trendingProduct.dart';
import 'package:omshribhakti/widgets/wallet.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  static const double sideGaps=8.0;

  static const List<Map<String,dynamic>> menuItems=[
    {
      "name":"Horoscope",
      "icon":FontAwesomeIcons.starOfDavid,
      "routeName":"",
    },
    {
      "name":"Geeta",
      "icon":FontAwesomeIcons.book,
      "routeName":"Geeta",
    },
    {
      "name":"Mantra",
      "icon":FontAwesomeIcons.scroll,
      "routeName":"MantraPage",
    },
    {
      "name":"Songs",
      "icon":FontAwesomeIcons.compactDisc,
      "routeName":"Music",
    },
    {
      "name":"Mandir",
      "icon":FontAwesomeIcons.gopuram,
      "routeName":"SelectGod",
    },
    {
      "name":"Podcast",
      "icon":FontAwesomeIcons.podcast,
      "routeName":"PodcastSeriesPage",
    },
    {
      "name":"Gods",
      "icon":FontAwesomeIcons.om,
      "routeName":"Gods",
    },
    {
      "name":"Free Coin",
      "icon":FontAwesomeIcons.coins,
      "routeName":"Web",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //App bar with wallet
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: sideGaps),
                child: Row(
                  children: [
                    SizedBox(
                        width: MediaQuery.sizeOf(context).width*0.105 ,
                        child: Image.asset("images/app_icon.png")
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    SizedBox(
                        width: MediaQuery.sizeOf(context).width*0.25,
                        child: Image.asset("images/logo_text.png")
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width*0.1,
                    ),
                    Expanded(child: GestureDetector(
                          onTap: ()=>GoRouter.of(context).pushNamed("Web"),
                        child: Consumer(
                            builder: (context,ref,child){
                              final user=ref.watch(customUserProvider);
                              return wallet(user!);
                            }
                        )
                    )
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              // profile section
              Consumer(
                builder: (context,ref,child){
                  final customUser = ref.watch(customUserProvider);
                  if(customUser!.signInType!="google"){
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: sideGaps),
                      child: GestureDetector(
                        onTap: ()async{
                          await ref.read(customUserProvider.notifier).signInWithGoogle();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical:  8.0,horizontal: 16),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppTheme.primary,
                              width: 2
                            ),
                              borderRadius: BorderRadius.circular(100)
                          ),
                          child:const Text("Login",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: AppTheme.primary
                            ),
                          ),
                        ),
                      ),
                    ) ;
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: sideGaps),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("jai Shree ram",
                              style: TextStyle(
                                  color: AppTheme.textGray,
                                  fontSize: 12
                              ),
                            ),
                            Text(customUser.apiData!["username"],
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: ()async{
                            await ref.read(customUserProvider.notifier).signOut();
                          },
                          child: Text("Log Out",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: AppTheme.primary
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),

              SizedBox(
                height: 16,
              ),
              // membership renew box
              // Container(
              //   padding: const EdgeInsets.all(8.0),
              //   margin: const EdgeInsets.symmetric(horizontal: sideGaps),
              //
              //   decoration: BoxDecoration(
              //     color: AppTheme.backgroundLight,
              //     border: Border.all(
              //       color: Colors.yellow
              //     ),
              //     borderRadius: BorderRadius.circular(10)
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(vertical: 4.0),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Expanded(
              //           flex: 4,
              //             child: Text("3 days left in membership",
              //           style: TextStyle(
              //             color: Colors.white
              //           ),
              //         )
              //         ),
              //         Expanded(
              //           flex: 2,
              //             child: Container(
              //           padding: const EdgeInsets.symmetric(vertical: 8.0),
              //           decoration: BoxDecoration(
              //             color: Colors.white,
              //             borderRadius: BorderRadius.circular(5)
              //           ),
              //           child: Center(child: Text("Renew Now")),
              //         )
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              //  SizedBox(
              //    height: 20,
              //  ),

               //live darshan

               Padding(
                 padding: const EdgeInsets.symmetric(vertical: 8.0 ,horizontal: sideGaps),
                 child: Text("🔴 Live Indian Temple",
                  style: TextStyle(
                    color: Colors.white
                  ),
                 ),
               ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height*0.1,
                child: Consumer(
                    builder: (context,ref,child){
                      final user = ref.watch(customUserProvider);
                      LiveDarshanService service=LiveDarshanService();
                      return FutureBuilder(
                          future: service.fetchHomeLiveDarshan(user!.apiData!["token"]),
                          builder: (context,snapshot) {
                            if(snapshot.connectionState == ConnectionState.done && !snapshot.hasError){
                              return ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemBuilder: (context,index){
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: SizedBox(
                                          width: MediaQuery.sizeOf(context).width*0.6,
                                          child: GestureDetector(
                                              onTap: ()=>GoRouter.of(context).pushNamed("VideoPlayer"),
                                              child: liveDarshanCard(image: snapshot.data![index].image, title: snapshot.data![index].title))
                                      ),
                                    );
                                  }
                              );
                            }
                            return ListView.builder(
                                itemCount: 4,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (context,index){
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: SizedBox(
                                        width: MediaQuery.sizeOf(context).width*0.6,
                                        child: GestureDetector(
                                            onTap: ()=>GoRouter.of(context).pushNamed("VideoPlayer"),
                                            child: liveDarshanCard(image: "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png", title: "Loading"))
                                    ),
                                  );
                                }
                            );
                          }
                      );
                    }
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: ()=>GoRouter.of(context).pushNamed("AllLiveDarshans"),
                    child: Text("See All Temples",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                  ),
                  Icon(Icons.keyboard_double_arrow_right_outlined,
                    color: Colors.white,
                  )
                ],
              ),

              SizedBox(
                height: 30,
              ),

              //menu grid

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: sideGaps),
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height*0.235,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                      itemCount: menuItems.length,
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8
                      ),
                      itemBuilder:(context,index){
                        return Consumer(
                          builder: (context,ref,child) {
                            return GestureDetector(
                              onTap: (){
                                final user=ref.read(customUserProvider);
                                if(menuItems[index]["routeName"].toString().isEmpty){
                                  return;
                                }
                                if(menuItems[index]["routeName"]=="Web" && user!.signInType !="google" ){
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    content: Text("Please Login First"),
                                  ));
                                  return;
                                }
                                GoRouter.of(context).pushNamed(menuItems[index]["routeName"]);
                              },
                                child: menuItem(context,menuItems[index]["icon"], menuItems[index]["name"])
                            );
                          }
                        );
                      }
                  ),
                ),
              ),

              SizedBox(
                height: 30,
              ),

              // special section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: sideGaps),
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height*0.14,
                  child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio:3.6
                      ),
                      itemBuilder:(context,index){
                        return Consumer(
                          builder: (context,ref,child){

                            return GestureDetector(
                                onTap: (){
                                  if(ref.read(customUserProvider)?.signInType=="google"){
                                    GoRouter.of(context).pushNamed("QuizCategory");
                                  }else{
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                      content: Text("Please Login First"),
                                    ));
                                  }

                                },
                                child: specialItem("https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png","Quiz Game", "Play & Earn"));
                          },
                        );
                      }
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              
              //trending products list
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: sideGaps),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.shopping_cart_rounded,
                          color: Colors.white,
                        ),
                        Text("Trending Products",
                          style: TextStyle(
                              color: Colors.white
                          ),
                        )
                      ],
                    ),
                    Consumer(
                      builder: (context,ref,child) {

                        return GestureDetector(
                          onTap: (){
                            ref.read(navigationIndexProvider.notifier).state=2;
                          },
                          child: Text("See All",
                            style: TextStyle(
                              color: AppTheme.primary
                            ),
                          ),
                        );
                      }
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height*0.225,
                child: Consumer(
                  builder: (context,ref,child) {
                    final user=ref.watch(customUserProvider);
                    EcomServices ecomService=EcomServices();
                    return FutureBuilder(
                      future:ecomService.fetchTrendingProducts(user!.apiData!["token"]) ,
                      builder: (context,snapshot) {
                        if(snapshot.connectionState==ConnectionState.done && snapshot.hasData){
                          final all=snapshot.data!.trendingProducts;
                          return ListView.builder(
                              itemCount: all.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context,index){
                                final product=all[index];
                                return GestureDetector(
                                  onTap: ()=>GoRouter.of(context).pushNamed("ProductDetails",pathParameters: {
                                    'id':product.productId.toString(),
                                  }),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: SizedBox(
                                        width: MediaQuery.sizeOf(context).width*0.4,
                                        child: trendingProduct(product.image, product.title)
                                    ),
                                  ),
                                );
                              }
                          );
                        }
                        return ListView.builder(
                          itemCount: 4,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context,index){
                              return Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: SizedBox(
                                  width: MediaQuery.sizeOf(context).width*0.4,
                                    child: trendingProduct("https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png", "Loading")
                                ),
                              );
                            }
                        );
                      }
                    );
                  }
                ),
              ),
              SizedBox(
                height: 30,
              ),
              CarouselSlider(
                  items: [
                    GestureDetector(
                      onTap: ()=>GoRouter.of(context).pushNamed("Web"),
                      child: SlicerCard(title: "title",  fromState: "fromState", toState: "toState", date: "2024-10-25 14:15:16", image: "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png"),
                    ),
                    GestureDetector(
                      onTap: ()=>GoRouter.of(context).pushNamed("Web"),
                      child: SlicerCard(title: "title",  fromState: "fromState", toState: "toState", date: "2024-10-27 14:15:16", image: "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png"),
                    ),
                  ],
                  options: CarouselOptions(
                      height: MediaQuery.sizeOf(context).height*0.4,
                      viewportFraction: 1,
                      autoPlay: true,
                      padEnds: false
                  )
              ),
              SizedBox(
                height: 30,
              ),
              Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height*0.29,


                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height*0.02,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors:[
                                AppTheme.background,
                                Colors.transparent
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter
                          )
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SizedBox(
                      height: MediaQuery.sizeOf(context).height*0.29,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Yoga & Meditation",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18
                                    ),
                                  ),
                                  Text("Improve Health",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12
                                    ),
                                  )
                                ],
                              ),
                              GestureDetector(
                                onTap: (){
                                  GoRouter.of(context).pushNamed("AllYogaCategory");
                                },
                                child: Text("See All",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  quotesThumbnail(context, "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png", "title",),
                                  quotesThumbnail(context, "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png", "title",),
                                  quotesThumbnail(context, "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png", "title",),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height*0.29,


                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height*0.02,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors:[
                                AppTheme.background,
                                Colors.transparent
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter
                          )
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SizedBox(
                      height: MediaQuery.sizeOf(context).height*0.29,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Share Quotes",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18
                                    ),
                                  ),
                                  Text("With your photo and name",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12
                                    ),
                                  )
                                ],
                              ),
                              GestureDetector(
                                onTap: (){
                                  GoRouter.of(context).pushNamed("QuotesAllCategory");
                                },
                                child: Text("See All",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 16,
                              ),
                              Consumer(
                                builder: (context,ref,child) {
                                  final user=ref.watch(customUserProvider);
                                  QuotesService quotesServices=QuotesService();
                                  return FutureBuilder(
                                    future: quotesServices.fetchHomeCategories(user!.apiData!['token']),
                                    builder: (context,snapshot) {
                                      if(!snapshot.hasData && snapshot.connectionState != ConnectionState.done){
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            quotesThumbnail(context, "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png", "Loading", ),
                                            quotesThumbnail(context, "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png", "Loading", ),
                                            quotesThumbnail(context, "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png", "Loading", ),
                                          ],
                                        );
                                      }
                                      final categories=snapshot.data!;
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: categories.map((data)=>GestureDetector(
                                          onTap: (){
                                            GoRouter.of(context).pushNamed("QuotesWithCategory",
                                              pathParameters: {
                                                'id':data.id.toString()
                                              }
                                            );
                                          },
                                            child: quotesThumbnail(context, data.image, data.Title, )
                                        )
                                        ).toList(),
                                      );
                                    }
                                  );
                                }
                              ),
                              SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
