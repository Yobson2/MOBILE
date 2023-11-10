import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_notabene/services/api_service.dart';

import '../main.dart';
import '../models/carousel_model.dart';
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
  bool isLoading = true;
 
  @override
  void initState() {
    super.initState();
  }

  Future<void> getAllData() async {
    final response = await ApiManager().fetchData("getAllEntreprise", "message ok", "messageError barre de recherche");
    
    if (response != null) {
      final allItems = response['allEntreprises'];
      print("resultat recherche $allItems");
      setState(() {
        searchResults = allItems;
         isLoading = false;
      });
    }
  }
   
    Future<void> _search() async {
    //   setState(() {
    // isLoading = true; 
    //  });
       getAllData();
      String query = _searchController.text;
      List<dynamic> filteredResults = [];
        print("object112  $searchResults");  
      if (query.isNotEmpty) {
        for (var item in searchResults) {
          if (item['nom_entreprise'] != null && item['nom_entreprise'].toLowerCase().contains(query)) {
            filteredResults.add(item);
          }
        }

         
      }
        print("object2  $filteredResults");  
        setState(() {
          searchResultsFinal=filteredResults;
          
        });


       setState(() {
          isLoading = false; 
        });
    }

  @override
  Widget build(BuildContext context) {
    print("object  $searchResultsFinal");
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
                                   searchResultsFinal[index]['categories'] ,
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
              
           CarouselSlider(
          options: CarouselOptions(
            height: 200,
            autoPlay: true,
            enlargeCenterPage: true,
          ), 
          items: [
         CarouselItem(
          title: 'Bienvenue sur Notabene',
          description: "Si vous appréciez notre service, n'hésitez pas à le partager !",
          color: Colors.blue,
          icon: Icons.star, 
        ),
        CarouselItem(
          title: 'Explorer la carte',
          description: "Découvrez notre large sélection de fonctionnalités et de contenus.",
          color: Colors.cyan,
          icon: Icons.explore, 
        ),
        CarouselItem(
          title: "Prendre des photos",
          description: "Capturez vos moments préférés et partagez-les avec vos amis.",
          color: Colors.orange,
          icon: Icons.camera_alt, 
        ),
           
          ],
        ),

          // if(searcheck=false) 
            const CategorySection(),
            MySecondBloc(isLoading:isLoading)
          ],
         
          
        ),
      ),
    );
  }
}

class MySecondBloc extends StatelessWidget {
   final bool? isLoading;

  const MySecondBloc({ this.isLoading});
  @override
  Widget build(BuildContext context) {

    print("mes test $isLoading");
    return Container(
      height: 400,
      child: Column(
        children: [
          Expanded(child: isLoading==false
                  ? const Center(child: CircularProgressIndicator())
                  : MyComment()),
        ],  
      ),  
    );
  }
}
