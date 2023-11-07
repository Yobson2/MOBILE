import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_notabene/services/api_service.dart';

import '../services/localisation_search.dart';
import 'home/home_avis_recents.dart';
import 'home/home_cartegories.dart';
import 'items/details_items.dart';


class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> searchResults = [];
  List<dynamic> searchResultsFinal = [];
  bool searcheck=true;
  @override
  void initState() {
    super.initState();
  }

  Future<void> getAllData() async {
    final response = await ApiManager().fetchData("getAllEntreprise", "message ok", "messageError barre de recherche");
    
    if (response != null) {
      final allItems = response['allEntreprises'];
      // print("resultat recherche $allItems");
      setState(() {
        searchResults = allItems;
      });
    }
  }
   
    Future<void> _search() async {
      getAllData();
      String query = _searchController.text;
      List<dynamic> filteredResults = [];
       
      if (query.isNotEmpty) {
        for (var item in searchResults) {
          if (item['nom_entreprise'] != null && item['nom_entreprise'].toLowerCase().contains(query)) {
            filteredResults.add(item);
          }
        }

             
      }
        setState(() {
          searchResultsFinal=filteredResults;
        });


        // print("Filtered results $searchResultsFinal");
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
                  const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        _search(); 
                        setState(() {
                          searcheck=true;
                        }); 
                      },
                      decoration: const InputDecoration(
                        hintText: 'Rechercher...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
             // Afficher les résultats ici
            if (searchResultsFinal.isNotEmpty)
             Padding(
               padding: const EdgeInsets.only(right: 0.0,left: 0.0),
                child: Container(
                   decoration: BoxDecoration(
                    
                    color: Colors.white10,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white10.withOpacity(0.2),
                        blurRadius: 1.0,
                      ),
                    ],
                  ),
                  child:ListView.builder(
                  shrinkWrap: true,
                  itemCount: searchResultsFinal.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                           Row(
                            children: [
                               Text(searchResultsFinal[index]['nom_entreprise'],
                               style: const TextStyle(
                                    fontSize: 18, 
                                    color: Colors.black54
                                    
                                  ),
                               ),
                            ],
                           ),
                            
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                 const Icon(Icons.location_on, size: 14),
                              const SizedBox(width: 4),
                              Flexible(
                                
                                child: Text(
                                 searchResultsFinal[index]['adresse_entreprise']  ,
                                  softWrap: true, 
                                  style: const TextStyle(
                                    fontSize: 13, 
                                    
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10,),
                              
                               Container(
                                alignment: Alignment.centerRight,
                                width: 180,
                                 child: Text(
                                  'categories',
                                  style: const TextStyle(
                                      fontSize: 10, 
                                      color: Colors.blue, 
                                      
                                    ),
                                  
                                  ),
                               ),
                               
                              ],
                            ),
                            const Divider()
                          ],
                        )
                      ),
                      onTap: () {
                        Navigator.push(
                             context,
                            MaterialPageRoute(builder: (context) => MyDetailsItems(idEntreprise:searchResultsFinal[index]["id_entreprise"],nomEntreprise:searchResultsFinal[index]["nom_entreprise"],idLocalisation:searchResultsFinal[index]["id_Localisation"],adresseEntreprise:searchResultsFinal[index]["adresse_entreprise"],categorieName:"BANQUE")),
                          );
                        },
                    );
                  },
                ), 
                ),
             ),
              
          //   CarouselSlider(
          //   options: CarouselOptions(
          //   height: 180,
            
          //   autoPlay: true,
          //   enlargeCenterPage: true,
          // ), 
          // items: [
          //     // Cadre 1
          //     SingleChildScrollView(
          //       child: Container(
          //         height: 200,
          //         width: 300,
          //     margin: EdgeInsets.all(5.0),
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(8.0),
          //       color: Colors.blue,
          //     ),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         // Image.network(
          //         //   'https://images.unsplash.com/photo-1682687981907-170c006e3744?auto=format&fit=crop&q=80&w=1471&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          //         //   height: 200,
          //         // ),
          //         SizedBox(height: 10),
          //         Text(
          //           'Titre 1',
          //           style: TextStyle(fontSize: 24, color: Colors.white),
          //         ),
          //         Text(
          //           'Description 1',
          //           style: TextStyle(fontSize: 16, color: Colors.white),
          //         ),
          //       ],
          //     ),
          //   ),)
            
            


          // ],),
          // if(searcheck=false) 
            const CategorySection(),
            // MySecondBloc()
          ],
         
          
        ),
      ),
    );
  }
}

class MySecondBloc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        children: [
          Expanded(child: MyComment()),
        ],  
      ),  
    );
  }
}
