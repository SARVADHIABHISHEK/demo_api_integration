import 'package:api_intregraion/Create_registration_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      theme: ThemeData(fontFamily: 'Overpass Mono'),
      title: 'Demo Api Integration',
      debugShowCheckedModeBanner: false,
      home: const RegistrationForm(),
    );
  }
}
