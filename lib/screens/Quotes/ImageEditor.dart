import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

class ImageEditor extends StatefulWidget {
  final String url;

  const ImageEditor({Key? key, required this.url}) : super(key: key);

  @override
  State<ImageEditor> createState() => _ImageEditorState();
}

class _ImageEditorState extends State<ImageEditor>
    with SingleTickerProviderStateMixin {
  double TextSize = 12.0;
  double ImageSize = 40.0;
  TextEditingController _controller = TextEditingController();
  String profile = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8SKUQ2F4m0jZMWD8_IWKHUFY1BHhZLGP985T3_8kacieuKr9OMy4U_K4arWT0QDVuFYs&usqp=CAU";

  Color _BorderColor = Colors.white;
  Color _TextBackground = Colors.white;
  Color _TextForgound = Colors.black;
  String selectedImagePath = "";
  int selectednum = 0;
  Color _BottomStrip = Colors.brown.shade400;
  final GlobalKey globalKey = GlobalKey();
  double viewfraction = 0.90;
  bool showloading = false;
  int selectedstyle = 0;
  late TabController _tabcontroller;



  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImagePath = pickedFile.path;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _tabcontroller = TabController(length: 1, vsync: this);
    _controller.text = "";

  }
  @override
  void dispose() {
    super.dispose();
    _tabcontroller.dispose();

  }





  List<Widget> displayIcons = [];

  @override
  Widget build(BuildContext context) {
    // List FrameTitle = [
    //   "Rectangle Transparent",
    //   "Circle Transparent",
    //   "Rectangle Colored Border",
    //   "Circle Colored Border",
    // ];

    displayIcons = [
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: selectedImagePath == ""
            ? Image.network(
          profile, // Using widget.url here
          fit: BoxFit.cover, // or whatever fit you prefer
        )
            : Image.file(
          File(selectedImagePath),
          fit: BoxFit.fill,
        ),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: selectedImagePath == ""
            ? Image.network(
          profile, // Using widget.url here
          fit: BoxFit.cover, // or whatever fit you prefer
        )
            : Image.file(
          File(selectedImagePath),
          fit: BoxFit.fill,
        ),
      ),
      Container(
        color: _BorderColor,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: selectedImagePath == ""
                  ? Image.network(
                profile, // Using widget.url here
                fit: BoxFit.cover, // or whatever fit you prefer
              )
                  : Image.file(
                File(selectedImagePath),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100), color: _BorderColor),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: selectedImagePath == ""
                ? Image.network(
              profile, // Using widget.url here
              fit: BoxFit.cover, // or whatever fit you prefer
            )
                : Image.file(
              File(selectedImagePath),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    ];

    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Editor"),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height / 2.5,
                    child: TabBarView(
                      viewportFraction: viewfraction,
                      controller: _tabcontroller,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: AspectRatio(
                              aspectRatio: 1/1,
                              child: RepaintBoundary(
                                key: _tabcontroller.index == 0 ? globalKey : null,
                                child: Stack(
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 1/1,
                                      child: Image.network(
                                        widget.url,
                                        fit: BoxFit.fill,
                                      ),

                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Stack(
                                          alignment: Alignment.centerLeft,
                                          children: [
                                            Row(
                                              children: [


                                                selectedImagePath!="" || _controller.text!="" ?Container(
                                                  color: Colors.white,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      children: [
                                                        selectedImagePath!=""?SizedBox(
                                                            height: ImageSize,
                                                            width: ImageSize,
                                                            child: displayIcons[1]
                                                        ):SizedBox(),
                                                        _controller.text!=""?Container(
                                                          decoration: BoxDecoration(
                                                              color: _TextBackground,
                                                              borderRadius: const BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
                                                          ),
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Center(
                                                              child: Text(
                                                                _controller.text,
                                                                style: TextStyle(
                                                                    color: _TextForgound,
                                                                    fontSize: TextSize),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                            :
                                                        SizedBox(),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                                    :
                                                SizedBox()
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: _selectImage,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: Stack(
                                          children: [
                                            SizedBox(
                                              height: 80,
                                              width: 80,
                                              child: selectedImagePath.isEmpty
                                                  ? Image.network(
                                                profile,
                                                fit: BoxFit.cover,
                                              )
                                                  : Image.file(
                                                File(selectedImagePath),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Container(
                                              height: 80,
                                              width: 80,
                                              color: Colors.black.withOpacity(0.5),
                                              child: Center(
                                                child: Icon(Icons.add,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller: _controller,
                                          onChanged: (value) {
                                            setState(() {});
                                          },
                                          style:const TextStyle(
                                            color: Colors.white
                                          ),
                                          decoration:const InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: "Title",
                                            counterText: "",

                                            contentPadding: EdgeInsets.symmetric(
                                                vertical: 8.0, horizontal: 8.0),
                                          ),
                                          maxLength: 15,
                                        ),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),

                      ],
                    ),
                  ),
                  // const SizedBox(
                  //   height: 24,
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              showloading = true;
                            });

                            _captureAndShare();
                          },
                          child: Container(
                            width: 130,
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(width: 1)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Share",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.share,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),


                      ],
                    ),
                  ),



                  // if (_isNativeAdTopLoaded)
                  //   AspectRatio(
                  //       aspectRatio: 1,
                  //       child: AdWidget(ad: _nativeAdTop!)
                  //   ),
                ],
              ),
            ),
          ),
        ),
        showloading?Container(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          color: Colors.black.withOpacity(0.2),
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        ):
        SizedBox(),
      ],
    );
  }

  Future<void> _captureAndShare() async {
    try {
      // Capture widget as image
      final Uint8List imageBytes = await _captureWidget();
      setState(() {
        showloading = false;
      });
      // Save captured image to device
      final Directory tempDir = await getTemporaryDirectory();
      final File imageFile = File('${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.png');
      await imageFile.writeAsBytes(imageBytes);

      // Share captured image using Share.shareFiles()
      await Share.shareXFiles([XFile(imageFile.path)],
        text: 'इस तरह की और शानदार स्टेटस इमेजेस के लिए ओम श्री भक्ति ऐप डाउनलोड करें \n https://play.google.com/store/apps/details?id=com.omshribhakti.omshribhakti&hl=en-IN',);
    } catch (e) {
      debugPrint('Error sharing image: $e');
    }
  }

  Future<Uint8List> _captureWidget() async {
    try {
      final RenderRepaintBoundary boundary =
      globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      // Convert widget to image
      final ui.Image image = await boundary.toImage(pixelRatio: 5.0);
      final ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData != null) {
        return byteData.buffer.asUint8List();
      } else {
        throw Exception('Failed to capture widget as image');
      }
    } catch (e) {
      throw Exception('Error capturing widget: $e');
    }
  }
}
