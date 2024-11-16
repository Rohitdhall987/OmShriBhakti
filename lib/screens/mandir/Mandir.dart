


import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:http/http.dart' as http;



class Mandir extends StatefulWidget {
  // final String godImage;
  const Mandir({super.key});

  @override
  State<Mandir> createState() => _MandirState();
}

class _MandirState extends State<Mandir> {

  bool isvisible=false;
  bool isvisible2=false;

  String GogImage="https://file.aiquickdraw.com/imgcompressed/img/compressed_4408d7f32aaff4239b5aecefbbe534a6.webp";

  final AudioPlayer player = AudioPlayer();

  Future<dynamic> playAudioFromAsset(String assetsmp3) async {

    await player.setAsset(assetsmp3);
    player.play();



  }
  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body:

        SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            // height: MediaQuery.sizeOf(context).height-(MediaQuery.sizeOf(context).height/20),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width:MediaQuery.of(context).size.width,
                  child: Image.network("https://${dotenv.env['DOMAIN']}/public/storage/image/mandirBackground/bg_2.png",
                    fit: BoxFit.fill,
                  ),
                ),

                Visibility(
                    visible: isvisible,
                    child: Image.asset('images/circle.gif',scale: 2,)
                ),

                Stack(

                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height/3.2,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height/3,
                              child: Image.network(GogImage,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Container(
                              height: 90,
                            )
                          ],
                        ),

                        Container(
                          height: 70,
                          width: double.infinity,

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Draggable(
                                child: Container(
                                  height: 70,
                                  width: 150,
                                  child: Image.asset('images/thali.png',fit: BoxFit.fitWidth,),
                                ),
                                feedback: Container(
                                  height: 70,
                                  width: 150,
                                  child: Image.asset('images/thali.png',fit: BoxFit.fitWidth,),
                                ),
                                childWhenDragging: Container(),
                                onDragStarted: (){
                                  setState(() {
                                    isvisible = true;
                                    isvisible2=true;
                                  });
                                  playAudioFromAsset("assets/arti.mp3");
                                },
                                onDragUpdate: (details){
                                  //playAudioFromAsset("assets/arti.mp3");

                                  player.setLoopMode(LoopMode.one); // Set loop mode to LoopMode.one



                                },
                                onDragEnd: (details){
                                  player.setLoopMode(LoopMode.off); // Set loop mode to LoopMode.one
                                  setState(() {
                                    isvisible = false;
                                    isvisible2=false;
                                  });
                                },
                              ),

                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){
                            playAudioFromAsset("assets/bell.mp3");
                          },
                          child: Container(
                              height: 300,
                              child: Image.asset("images/bell.gif")
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            playAudioFromAsset("assets/bell.mp3");
                          },
                          child: Container(
                              height: 300,
                              child: Image.asset("images/bell.gif")
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 50,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap:  (){ playAudioFromAsset("assets/arti.mp3");},
                                child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(1000),
                                        color: Colors.blue
                                    ),

                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset("images/aaartiJot.png",),
                                    )
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isvisible2=true;
                                  });
                                  Future.delayed(Duration(seconds: 2),(){
                                    setState(() {
                                      isvisible2=false;
                                    });
                                  });
                                },
                                child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(1000),
                                        color: Colors.blue
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset("images/flower.png",),
                                    )
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap:  (){ playAudioFromAsset("assets/shankh.mpeg");},
                                child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(1000),
                                        color: Colors.blue
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset("images/shank.png",),
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Image.asset('images/mandir_top.png'),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                            visible: isvisible2,
                            child: Image.asset('images/falling.gif')
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        )
    );
  }
}

double getWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}
