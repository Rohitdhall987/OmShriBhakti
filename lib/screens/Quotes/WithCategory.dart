import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart'as http;
import 'package:omshribhakti/widgets/CachedNetworkImage.dart';

class QuotesWithCategory extends StatefulWidget {
  final String id;
  const QuotesWithCategory({super.key,required this.id});
  @override
  QuotesWithCategoryState createState() => QuotesWithCategoryState();
}

class QuotesWithCategoryState extends State<QuotesWithCategory> {
  List _data=[];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    String Url = dotenv.get('BASE_URl', fallback: "");
    final response = await http.get(Uri.parse('${Url}SingleImageStatusCategory/${widget.id}'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      setState(() {
        _data = jsonResponse['ImageStatusByCategory'];
        _isLoading = false;
      });

    } else {
      // Handle error
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Image'),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
          ),
          itemCount: _data.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: GestureDetector(
                onTap: ()=>{
                  GoRouter.of(context).pushNamed("ImageEditor",pathParameters: {
                    'img':_data[index]["image"]
                  })
                },
                child: cachedNetworkImage(_data[index]["image"],BoxFit.fitHeight),
              ),
            );
          },
        ),
      ),
    );
  }
}
