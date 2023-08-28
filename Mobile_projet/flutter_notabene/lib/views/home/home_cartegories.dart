import 'package:flutter/material.dart';
import 'package:flutter_notabene/views/cartegories_pages/divers_page.dart';
import 'package:flutter_notabene/views/cartegories_pages/hotel_page.dart';
import 'package:flutter_notabene/views/cartegories_pages/restauraut_page.dart';
import 'package:flutter_notabene/views/cartegories_pages/spermarche_page.dart';

import '../cartegories_pages/banque_page.dart';


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
                  // return Column(
                  
                     return GestureDetector(
                  onTap: () {
                    switch (categories[index]['id_category']) {
                      case 1:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BanquePage(),
                          ),
                        );
                        break;
                      case 2:
                         Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RestaurantPage(),
                          ),
                        );
                        break;
                      case 3:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HotelPage(),
                          ),
                        );
                      case 4:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SpermarchePage(),
                          ),
                        );
                      case 5:
                         Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DiversPage(),
                          ),
                        );
                      
                    }
                  },
                  child: Column(
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
                  ),
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