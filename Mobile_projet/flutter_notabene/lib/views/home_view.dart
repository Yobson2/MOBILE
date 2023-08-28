import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'home/home_avis_recents.dart';
import 'home/home_cartegories.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body:SingleChildScrollView(
        child:Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: 155.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.9, //pour la largeur
            ),
            items: [1, 2, 3].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                       borderRadius: BorderRadius.circular(10.0), 
                    ),
                    child: Center(
                      child: Text(
                        'Image $i',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          CategorySection(),
          MySecondeBloc(),
        ],

      ), ) 
    );
  }
}

class MySecondeBloc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
              height: 300,
              child: Column(
                children: [
                  Expanded(child: MyComment())
                ],  
              ),  
            );
  }
}
