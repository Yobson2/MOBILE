import 'package:flutter/material.dart';
import 'package:flutter_simpleapp/screem/home_screem.dart';


final List<Map<String, dynamic>>listHastags=[
  {
    "id":1,
    "name":"#flutter"
  },
  {
    "id":2,/*  */
    "name":"#dart"
  },{
    "id":3,
    "name":"#JavaScript"
  }
];


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yoyo tags',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:HomeScreem(),
    );
  }
}
