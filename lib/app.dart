import 'package:api_intregraion/homepage.dart';
import 'package:flutter/material.dart';
class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const  MaterialApp(
      title: 'Demo Api Integration',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
