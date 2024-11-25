import 'package:go_router/go_router.dart';
import 'package:omshribhakti/app.dart';
import 'package:omshribhakti/screens/AllLiveDarshans.dart';
import 'package:omshribhakti/screens/Articles/ArticleByMonth.dart';
import 'package:omshribhakti/screens/Articles/ArticleSeries.dart';
import 'package:omshribhakti/screens/Articles/ReadArticle.dart';
import 'package:omshribhakti/screens/GodPlayList.dart';
import 'package:omshribhakti/screens/Gods.dart';
import 'package:omshribhakti/screens/Mantra.dart';
import 'package:omshribhakti/screens/Players/MusicPlayer.dart';
import 'package:omshribhakti/screens/Podcast/PodcastSeries.dart';
import 'package:omshribhakti/screens/Podcast/SingleSeries.dart';
import 'package:omshribhakti/screens/Quotes/AllCategory.dart';
import 'package:omshribhakti/screens/Quotes/ImageEditor.dart';
import 'package:omshribhakti/screens/Quotes/WithCategory.dart';
import 'package:omshribhakti/screens/Songs/Song.dart';
import 'package:omshribhakti/screens/NavigationBarScreen.dart';
import 'package:omshribhakti/screens/Players/VideoPlayer.dart';
import 'package:omshribhakti/screens/Songs/SongSeries.dart';
import 'package:omshribhakti/screens/Songs/SongsByMonth.dart';
import 'package:omshribhakti/screens/SplashScreen.dart';
import 'package:omshribhakti/screens/UpdateAppPage.dart';
import 'package:omshribhakti/screens/Web/Web.dart';
import 'package:omshribhakti/screens/Yoga/all_yoga_category.dart';
import 'package:omshribhakti/screens/Yoga/yoga_by_category.dart';
import 'package:omshribhakti/screens/ecom/ByCategory.dart';
import 'package:omshribhakti/screens/ecom/ProductDetails.dart';
import 'package:omshribhakti/screens/geeta/GeetaAdhyaya.dart';
import 'package:omshribhakti/screens/geeta/ReadShloak.dart';
import 'package:omshribhakti/screens/geeta/Shloak.dart';
import 'package:omshribhakti/screens/mandir/Mandir.dart';
import 'package:omshribhakti/screens/mandir/SelectGod.dart';
import 'package:omshribhakti/utils/Observer.dart';





GoRouter route(){
  final GoRouter routes = GoRouter(
        navigatorKey: rootNavigatorKey,
      observers: [GoRouterObserver()],
      routes: [
        GoRoute(
            path: "/",
            name: "Splash",
            builder: (context, state) => const SplashScreen()),
        GoRoute(
            path: "/Update",
            name: "Update",
            builder: (context, state) => const UpdateApp()),
        GoRoute(
            path: "/NavigationBarScreen",
            name: "NavigationBarScreen",
            builder: (context, state) => const NavigationBarScreen()),
        GoRoute(
            path: "/SongsByMonth",
            name: "SongsByMonth",
            builder: (context, state) => const SongsByMonth()),
        GoRoute(
            path: "/ArticleByMonth",
            name: "ArticleByMonth",
            builder: (context, state) => const ArticleByMonth()),
        GoRoute(
            path: "/Gods",
            name: "Gods",
            builder: (context, state) => const Gods()),
        GoRoute(
            path: "/AllLiveDarshans",
            name: "AllLiveDarshans",
            builder: (context, state) => const AllLiveDarshans()),
        GoRoute(
            path: "/GodPlaylist/:id/:name",
            name: "GodPlaylist",
            builder: (context, state) =>  GodPlaylist(id: int.parse(state.pathParameters["id"]!), name: state.pathParameters["name"]!)),
        GoRoute(
            path: "/Geeta",
            name: "Geeta",
            builder: (context, state) => const  Geeta()),
        GoRoute(
            path: "/GeetaShlok/:adhyaya/:shloka",
            name: "GeetaShlok",
            builder: (context, state) => GeetaShlok(adhaya:int.parse( state.pathParameters["adhyaya"]!), shloka: int.parse( state.pathParameters["shloka"]!))),
        GoRoute(
            path: "/ReadShloak/:adhyaya/:shlokaNumber",
            name: "ReadShloak",
            builder: (context,state)=>  ReadShloak(adhyaya: int.parse( state.pathParameters["adhyaya"]!), shlokaNumber: int.parse( state.pathParameters["shlokaNumber"]!))
        ),
        GoRoute(
            path: "/MantraPage",
            name: "MantraPage",
            builder: (context,state)=> const MantraPage()
        ),
        GoRoute(
            path: "/Music",
            name: "Music",
            builder: (context,state)=> const Music()
        ),
        GoRoute(
            path: "/Web",
            name: "Web",
            builder: (context,state)=> const Web()
        ),
        GoRoute(
            path: "/VideoPlayer",
            name: "VideoPlayer",
            builder: (context,state)=> const VideoPlayer()
        ),
            GoRoute(
            path: "/MusicPlayerPage",
            name: "MusicPlayerPage",
            builder: (context,state)=> const MusicPlayerPage()
        ),
        GoRoute(
            path: "/PodcastSeriesPage",
            name: "PodcastSeriesPage",
            builder: (context,state)=> const PodcastSeriesPage()
        ),
        GoRoute(
            path: "/SingleSeries/:id",
            name: "SingleSeries",
            builder: (context,state)=>  SingleSeries(id: int.parse(state.pathParameters["id"]!),)
        ),
        GoRoute(
            path: "/ArticleSeries",
            name: "ArticleSeries",
            builder: (context,state)=> const ArticleSeries()
        ),
        GoRoute(
            path: "/ReadArticle",
            name: "ReadArticle",
            builder: (context,state)=> const ReadArticle()
        ),
        GoRoute(
            path: "/ProductByCategory",
            name: "ProductByCategory",
            builder: (context,state)=> const ProductByCategory()
        ),
        GoRoute(
            path: "/SongSeries",
            name: "SongSeries",
            builder: (context,state)=> const SongSeries()
        ),
        GoRoute(
            path: "/ProductDetails",
            name: "ProductDetails",
            builder: (context,state)=> const ProductDetails()
        ),
        GoRoute(
            path: "/SelectGod",
            name: "SelectGod",
            builder: (context,state)=> const SelectGod()
        ),
        GoRoute(
            path: "/Mandir",
            name: "Mandir",
            builder: (context,state)=> const Mandir()
        ),
        GoRoute(
            path: "/QuotesAllCategory",
            name: "QuotesAllCategory",
            builder: (context,state)=> const QuotesAllCategory()
        ),
        GoRoute(
            path: "/QuotesWithCategory/:id",
            name: "QuotesWithCategory",
            builder: (context,state)=> QuotesWithCategory(id: state.pathParameters["id"]!)
        ),
        GoRoute(
            path: "/ImageEditor/:img",
            name: "ImageEditor",
            builder: (context,state)=> ImageEditor(url: state.pathParameters["img"]!,)
        ),
        GoRoute(
            path: "/AllYogaCategory",
            name: "AllYogaCategory",
            builder: (context,state)=>const AllYogaCategory()
        ),
        GoRoute(
            path: "/YogaByCategory/:id/:title",
            name: "YogaByCategory",
            builder: (context,state)=> YogaByCategory(id: int.parse(state.pathParameters["id"]!), title: state.pathParameters["title"]!)
        ),
      ]);
  return routes;
}
