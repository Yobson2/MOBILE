import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_notabene/services/api_service.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';
import '../models/carousel_model.dart';
import '../screens/login_screen.dart';
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
      setState(() {
        searchResults = allItems;
         isLoading = false;
      });
    }
  }
   
    Future<void> _search() async {
      setState(() {
    isLoading = true; 
     });
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


       setState(() {
          isLoading = false; 
        });
    }

  @override
  Widget build(BuildContext context) {
           final isLoggedIn = mainSession.userId!= 0;
    // print("object  $searchResultsFinal");
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0), 
          child: AppBar(
             automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0), 
                bottomRight: Radius.circular(10.0),
              ),
            ),
            title:   Row(
          children: [
            Text(
                'NOTA',
                style: GoogleFonts.lilitaOne(
                   color: Colors.black,
                    fontSize: 17
                    )
              ),
              Text(
                'BENE',
                 style: GoogleFonts.lilitaOne(
                   color: Colors.yellow,
                    fontSize: 17
                    )
              ),
          ],
        ),
        actions: [
          isLoggedIn ?
         Container(
        padding: const EdgeInsets.all(2),
        width: 50,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.black12, 
            width: 2.0, 
          ),
        ),
        child: const ClipOval(
          child: Image(
            image: NetworkImage(
              'https://images.unsplash.com/photo-1699378999301-8c88a6a237d9?q=80&w=1364&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            ),
            fit: BoxFit.fill,
          ),
        ),
      )

          :InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginForm()),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            width: 50,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0), 
              color: Colors.blue,
            ),
            child: Icon(
              Icons.person_outline,
              color: Colors.black, 
            ),
          ),
        )

          
        ],
    
            centerTitle: true,
          ),
        ),
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
                     if (searchResultsFinal.isEmpty || index >= searchResultsFinal.length) {
                  return Container(
                    child: Center(
                      child: Text('Aucun résultat trouvé'),
                    ),
                  );
                }

                    return ListTile(
  title: Container(
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          searchResultsFinal[index]['nom_entreprise'],
          style: TextStyle(
            fontSize: 18,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.location_on, size: 14),
            SizedBox(width: 4),
            Flexible(
              child: Text(
                searchResultsFinal[index]['adresse_entreprise'],
                softWrap: true,
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                searchResultsFinal[index]['categories'],
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        Divider(),
      ],
    ),
  ),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyDetailsItems(
          idEntreprise: searchResultsFinal[index]["id_entreprise"],
          nomEntreprise: searchResultsFinal[index]["nom_entreprise"],
          idLocalisation: searchResultsFinal[index]["id_Localisation"],
          adresseEntreprise: searchResultsFinal[index]["adresse_entreprise"],
          categorieName: searchResultsFinal[index]["categories"],
        ),
      ),
    );
  },
);

                  },
                ), 
                ),
             ),
          if (!_searchController.text.isNotEmpty)  
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

           if (!_searchController.text.isNotEmpty)
            const CategorySection(),
          if (!_searchController.text.isNotEmpty)
            MySecondBloc(),
          ],
         
          
        ),
      ),
    );
  }
}

class MySecondBloc extends StatelessWidget {
  const MySecondBloc();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Simule un chargement asynchrone pendant 2 secondes
      future: Future.delayed(Duration(seconds: 2)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Affiche le loader pendant le chargement
          return Container(
            height: 400,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          // Une fois le chargement terminé, affiche le contenu de la page
          return Container(
            height: 400,
            child: Column(
              children: [
                // MyComment()

                 Expanded(
                  child: MyComment()), 
              ],
            ),
          );
        }
      },
    );
  }
}
