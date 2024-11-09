import 'package:go_router/go_router.dart';
import 'package:omshribhakti/screens/AllLiveDarshans.dart';
import 'package:omshribhakti/screens/Articles/ArticleByMonth.dart';
import 'package:omshribhakti/screens/GodPlayList.dart';
import 'package:omshribhakti/screens/Gods.dart';
import 'package:omshribhakti/screens/Mantra.dart';
import 'package:omshribhakti/screens/Music.dart';
// import 'package:omshribhakti/screens/MusicPlayer.dart';
import 'package:omshribhakti/screens/NavigationBarScreen.dart';
import 'package:omshribhakti/screens/Players/VideoPlayer.dart';
import 'package:omshribhakti/screens/SongsByMonth.dart';
import 'package:omshribhakti/screens/SplashScreen.dart';
import 'package:omshribhakti/screens/UpdateAppPage.dart';
import 'package:omshribhakti/screens/Web/Web.dart';
import 'package:omshribhakti/screens/geeta/GeetaAdhyaya.dart';
import 'package:omshribhakti/screens/geeta/ReadShloak.dart';
import 'package:omshribhakti/screens/geeta/Shloak.dart';

final GoRouter routes = GoRouter(routes: [
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
      path: "/ReadShloak",
      name: "ReadShloak",
      builder: (context,state)=> const ReadShloak()
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
]);
