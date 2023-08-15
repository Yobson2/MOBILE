// Your API key is: 32783279c49d406987968904e23c2c20

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text('Yoyo'),
           Text('News', style: TextStyle(
            color: Colors.yellow,
            fontWeight: FontWeight.bold,
            fontSize: 20, 
           ),),
        ],),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Container(
        child: CategoryTitle(),
      )
    );
  }
}


class CategoryTitle extends StatelessWidget {

 final imageUrl, categorieName;
 CategoryTitle({this.imageUrl, this.categorieName});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          // Image.network(imageUrl, width: 120,height: 60,)
        ],
      ),
    );
  }
}