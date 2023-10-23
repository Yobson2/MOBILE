import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_notabene/services/api_service.dart';

import '../carte_view.dart';

class MyDetailsItems extends StatelessWidget {
  final String? nomEntreprise;
  final int? idEntreprise;
  final String? adresseEntreprise;
  const MyDetailsItems({Key? key, this.nomEntreprise, this.idEntreprise, this.adresseEntreprise, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            DetailsHeader(nom: nomEntreprise, idCompagny:idEntreprise), 
            MyChangeInfos(adresseEntreprise:adresseEntreprise),
            const Infos1Description(),
            InfosAvis(idEntreprise:idEntreprise),
            SizedBox(height: 20), 
          ],
        ),
      ),
    );
  }
}

class DetailsHeader extends StatelessWidget {
  final String? nom;
   final int? idCompagny; 

  const DetailsHeader({Key? key, this.nom, this.idCompagny}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 13.3 / 9,
              viewportFraction: 1,
              autoPlayAnimationDuration: Duration(milliseconds: 1000),
            ),
            items: [
              Image.asset('assets/images/pict2.jpg'),
              Image.asset('assets/images/pict2.jpg'),
              Image.asset('assets/images/pict2.jpg'),
            ],
          ),
          const SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Text(
              "$nom $idCompagny", 
              style: const TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Row(
              children: [
                for (int i = 0; i < 3; i++)
                  const Icon(Icons.star, color: Colors.yellow, size: 20),
                const SizedBox(width: 10),
                const Text(
                  "(100) Avis",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



class MyChangeInfos extends StatelessWidget {
  
  
  final String? adresseEntreprise;

  const MyChangeInfos({Key? key, this.adresseEntreprise,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top:0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DefaultTabController(
            length: 2,
            child: Column(
              children: [
                const TabBar(
                  labelColor: Colors.black,
                  tabs: [
                    Tab(text: "À savoir"),
                    Tab(text: "Carte",),
                  ],
                ),
                SizedBox(
                  height: 130,
                  child: MyTables(adresseEntreprise:adresseEntreprise),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class MyTables extends StatelessWidget {
  final String ? adresseEntreprise;
  const MyTables({Key? key, this.adresseEntreprise}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        height: 300,
        color: const Color.fromRGBO(238,232,244,1),
        child:  TabBarView(
          children: <Widget>[
            Center(
              child: Infos1Blocs(adresseEntreprise:adresseEntreprise),
            ),
            Center(
              child: Infos2(),
            ),
          ],
        ),
      ),
    );
  }
}




//-------------------------MES INFORMATIONS---------------------------------------

class Infos2 extends StatelessWidget {
  const Infos2({Key? key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
       
         Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) =>  MapSample(),
            ),
        );
      },
      child: SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset("assets/images/map.png"),
        ],
      ), ),
    );
  }
}




//////Infos 1-------------------------------

class Infos1Blocs extends StatelessWidget {
  final String? adresseEntreprise;

  Infos1Blocs({Key? key, this.adresseEntreprise}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Infos1(adresseEntreprise: adresseEntreprise),
        ],
      ),
    );
  }
}




class Infos1 extends StatelessWidget {
  final String?  adresseEntreprise;
  const Infos1({Key? key, this.adresseEntreprise}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Horaires ",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 18),
          Container(
            margin: EdgeInsets.only(left: 10),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.red, size: 20),
                    SizedBox(width: 6),
                    Text(
                      adresseEntreprise!,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Container(
            // color: Colors.amber,
            margin: EdgeInsets.only(left: 10), 
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.open_in_new, color: Colors.yellow, size: 20),
                    SizedBox(width: 6),
                    Text(
                      "Ouvert à 20:00",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  
                  children: [
                    Icon(Icons.close_fullscreen, color: Colors.blue, size: 20),
                    SizedBox(width: 6),
                    Text(
                      "Fermé à 20:00",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
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
  }
}

class Infos1Description extends StatelessWidget {
  const Infos1Description({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle("Description"),
          SizedBox(height: 10),
          _buildDescription(
            "Bienvenue sur notre plateforme d'informations. Cette section contient des détails essentiels que vous devez connaître pour naviguer au mieux dans notre application. Prenez le temps de lire ces informations attentivement afin de profiter pleinement de toutes les fonctionnalités que nous offrons.",
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildDescription(String description) {
    return Text(
      description,
      style: TextStyle(
        fontSize: 15,
      ),
    );
  }
}
class InfosAvis extends StatefulWidget {
  final int? idEntreprise;

  const InfosAvis({Key? key, this.idEntreprise});

  @override
  InfosAvisState createState() => InfosAvisState();
}

class InfosAvisState extends State<InfosAvis> {
  List<dynamic> myItemsData = [];
  List<dynamic> myItemsDataCommentaire = [];

  Future<void> getData() async {
    try {
      final reponse = await ApiManager().fetchData("getAllCommentaire/${widget.idEntreprise}", "message de recuperation des commentaires", "messageError");

      setState(() {
        myItemsData = reponse['utilisateursAvecCommentaires'];
      });

    } catch (e) {
      print("Erreur : Les données n'ont pas été récupérées $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notes et avis ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Notes et avis validés par des utilisateurs ayant bénéficié du même service.',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: myItemsData.map((commentaire) {
                return AvisListe(
                  commentaires: commentaire,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class AvisListe extends StatelessWidget {
  final dynamic commentaires;
  const AvisListe({Key? key, this.commentaires});

  @override
  Widget build(BuildContext context) {

    // print("object $commentaires");
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage("https://images.unsplash.com/photo-1524499982521-1ffd58dd89ea?auto=format&fit=crop&q=80&w=1571&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                      Flexible(
                      child: Text(
                    "${commentaires['nom_utilisateur']} befbbb b b",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                     ),
                      const Spacer(),
              
                  Container(
                    
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                           
                          },
                          child: Column(
                            children: [
                              const Icon(Icons.photo_album_outlined, color: Colors.grey,),
                              Text(
                              "Photos ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 8,
                              ),
                            ),
                            ]),
                        ),
                        const SizedBox(width: 5),
                        InkWell(
                          onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                builder: (context) =>  MapSample(),
                                ),
                            );
                          },
                          child:const Column(
                            children: [
                              Icon(Icons.map_outlined,color: Colors.grey,),
                              Text(
                              "Explorer ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 8,
                              ),
                            ),
                            ]),
                          
                          
                          
                        ),
                      ],
                    ),
                  ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                 commentaires['contenu_commentaire'] ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    for (int i = 0; i < (commentaires['nombre_etoiles'] ?? 0); i++)
                      Icon(Icons.star, color: Colors.yellow, size: 20),
                    SizedBox(width: 5),
                    Spacer(),
                    Text(
                      "${commentaires['heure']}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "${commentaires['date_commentaire']}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
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
  }
  
}