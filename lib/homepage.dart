import 'dart:convert';
import 'dart:io';
import 'package:api_intregraion/api_model.dart';
import 'package:api_intregraion/sliderScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<ApiModel> _apiData = <ApiModel>[];

  @override
  void initState() {
    _fetchApiData();
    super.initState();

  }

  void _fetchApiData() async {
    final request =
        await http.post(Uri.parse('https://fabcurate.easternts.in/top.json'));
    try {
      if (request.statusCode == 200) {
        final jsonData = jsonDecode(request.body);
        if (jsonData['main_sticky_menu'] != null) {
          jsonData['main_sticky_menu'].forEach((v) {
            _apiData.add(ApiModel.fromJson(v));
          });
        }
        setState((){});
      }
    } on SocketException catch (_) {
      print('internet not working');
    } catch (_) {
      print('something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Api integration'),
      ),
      body: GridView.builder(
          itemCount: _apiData.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).orientation == Orientation.landscape ? 3 : 2,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
            childAspectRatio: (2 / 1.2),
          ),
          itemBuilder: (context, index) {
            final item = _apiData[index];
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (_) =>   SliderScreen(todo: _apiData,))),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(item.image)),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
