import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
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
              // autoPlay: true,
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
        ],

      ),
    );
  }
}



class CategorySection extends StatelessWidget {
   CategorySection({super.key});
   
   // variable locale
   final categories=[
    {
      "icon":Icons.track_changes_outlined,
      "color":Colors.blue,
      "title":"CARD"
    },    {
      "icon":Icons.track_changes_outlined,
      "color":Colors.blue,
      "title":"CARD"
    },    {
      "icon":Icons.track_changes_outlined,
      "color":Colors.blue,
      "title":"CARD"
    },
        {
      "icon":Icons.track_changes_outlined,
      "color":Colors.blue,
      "title":"CARD"
    },
        {
      "icon":Icons.track_changes_outlined,
      "color":Colors.blue,
      "title":"CARD"
    },
   ];

    @override
  Widget build(BuildContext context) {
    return Container(
      height: 550,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                      Text(
                        'Categories', 
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // Ajoutez ici la logique pour gérer le bouton
                        },
                        icon: Icon(Icons.arrow_forward_ios),
                      ),
                    ],
              ),
            ),
            Container(
              height: 100,
              // color: Colors.green,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 25),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: categories[index]['color'] as Color,
                        ),
                        child: Icon(
                          categories[index]['icon'] as IconData,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      const SizedBox(height: 20), // Espace
                      Text(
                        categories[index]['title'] as String,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black.withOpacity(0.7),
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(width: 20), // Un séparateur
                itemCount: categories.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



