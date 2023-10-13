import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'home/home_avis_recents.dart';
import 'home/home_cartegories.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController _searchController = TextEditingController();
  List<String> _allItems = ['Item 1', 'Item 2', 'Item 3']; 
  List<String> _searchResults = [];

  void _search() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _searchResults = _allItems
          .where((item) => item.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              width: 380,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        _search();
                      },
                      decoration: InputDecoration(
                        hintText: 'Rechercher...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Afficher la liste des résultats si elle n'est pas vide
            // if (_searchResults.isNotEmpty) 
            //   ListView.builder(
            //     shrinkWrap: true,
            //     itemCount: _searchResults.length,
            //     itemBuilder: (BuildContext context, int index) {
            //       return ListTile(
            //         title: Text(_searchResults[index]),
            //       );
            //     },
            //   ),
            // CarouselSlider(
            //   options: CarouselOptions(
            //     height: 155.0,
            //     enlargeCenterPage: true,
            //     autoPlay: true,
            //     aspectRatio: 16 / 9,
            //     autoPlayCurve: Curves.fastOutSlowIn,
            //     enableInfiniteScroll: true,
            //     autoPlayAnimationDuration: Duration(milliseconds: 800),
            //     viewportFraction: 0.9,
            //   ),
            //   items: [1, 2, 3].map((i) {
            //     return Builder(
            //       builder: (BuildContext context) {
            //         return Container(
            //           width: MediaQuery.of(context).size.width,
            //           margin: EdgeInsets.symmetric(horizontal: 5.0),
            //           decoration: BoxDecoration(
            //             color: Colors.amber,
            //             borderRadius: BorderRadius.circular(10.0),
            //           ),
            //           child: Center(
            //             child: Text(
            //               'Image $i',
            //               style: TextStyle(fontSize: 16.0),
            //             ),
            //           ),
            //         );
            //       },
            //     );
            //   }).toList(),
            // ),
            const CategorySection(),
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


