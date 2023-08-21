import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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


class CategorySection extends StatelessWidget {
  CategorySection({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> categories = [
    {
      "icon": Icons.security,
      "color": Color(0xFF1E3C72),
      "title": "BANQUE",
      "id_category":1
    },
    {
      "icon": Icons.read_more,
      "color": Color(0xFFD32F2F),
      "title": "RESTAURAUT",
      "id_category":2
    },
    {
      "icon": Icons.hotel_class,
      "color": Color(0xFF757575),
      "title": "HOTEL",
      "id_category":3
    },
    {
      "icon": Icons.shopping_basket,
      "color": Color(0xFFF57C00),
      "title": "SUPERMARCHE",
      "id_category":4
    },
    {
      "icon": Icons.diversity_2,
      "color": Color(0xFF4CAF50),
      "title": "DIVERS",
      "id_category":5
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Colors.black,
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
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Add your onPressed logic here
                    },
                    icon: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            ),
            Container(
              height: 100,
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
                          color: categories[index]['color'],
                        ),
                        child: Icon(
                          categories[index]['icon'],
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        categories[index]['title'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black.withOpacity(0.7),
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(width: 10),
                itemCount: categories.length,
              ),
            ),
            
          ],
          
        ),
        
      ),
      
      
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

class MyComment extends StatelessWidget {
  final List<Map<String, dynamic>> avisRecents = [
 
    {
      "name": 'John',
      "surname": 'Doe',
      "photoUrl": 'https://images.unsplash.com/photo-1692116716561-953cc9a868b6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1374&q=80',
      "time": '12/12/2021',
      "starCount": 4,
      "comment": 'Great experience! Highly recommended.',
    },
    {
      "name": 'John',
      "surname": 'Doe',
      "photoUrl": '',
       "time": '12/12/2021',
      "starCount": 4,
      "comment": 'Great experience! Highly recommended.',
    },
    {
      "name": 'John',
      "surname": 'Doe',
      "photoUrl": '',
       "time": '12/12/2021',
      "starCount": 4,
      "comment": 'Great experience! Highly recommended.',
    },
    {
      "name": 'John',
      "surname": 'Doe',
      "photoUrl": '',
        "time": '12/12/2021',
      "starCount": 4,
      "comment": 'Great experience! Highly recommended.',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Évaluations récentes',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Expanded( // Wrap the ListView.builder with Expanded
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: avisRecents.length,
              itemBuilder: (context, index) {
                final avis = avisRecents[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        // backgroundImage: NetworkImage(avis["photoUrl"]),
                        radius: 30,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${avis["name"]} ${avis["surname"]}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              avis["comment"],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 18,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  '${avis["starCount"]} etoiles',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  avis["time"],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                    
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
