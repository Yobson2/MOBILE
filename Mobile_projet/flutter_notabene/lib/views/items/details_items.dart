import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_notabene/services/api_service.dart';

import '../../components/moreAvis_component.dart';
import '../carte_view.dart';

class MyDetailsItems extends StatefulWidget {
  final String? nomEntreprise;
  final int? idEntreprise;
  final int? idLocalisation;
  final String? adresseEntreprise;
  final String? categorieName;
  const MyDetailsItems({Key? key, this.nomEntreprise, this.idEntreprise, this.adresseEntreprise,this.idLocalisation,this.categorieName }) : super(key: key);
 State<MyDetailsItems> createState() => MyDetailsItemsState();
}

class MyDetailsItemsState extends State<MyDetailsItems> {
  bool printBtn = true;

  @override
  void initState() {
    super.initState();
    printBtn = true;
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize(
          preferredSize: Size.fromHeight(60.0), 
          child: AppBar(
            backgroundColor: Colors.blue,
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.0), 
                bottomRight: Radius.circular(30.0),
              ),
            ),
            centerTitle: true,
          ),
        ),
    
      body: SingleChildScrollView(
        child: Column(
          children: [
            
            DetailsHeader(nom: widget.nomEntreprise, idCompagny:widget.idEntreprise, adresseEntreprise:widget.adresseEntreprise), 
            MyChangeInfos(adresseEntreprise:widget.adresseEntreprise),
            const Infos1Description(),
            InfosAvis(idEntreprise:widget.idEntreprise,categorieName:widget.categorieName),
            SizedBox(height: 10), 
          ],
        ),
      ),
    );
  }
}

class DetailsHeader extends StatelessWidget {
  final String? nom;
   final int? idCompagny; 
   final String? adresseEntreprise; 
  const DetailsHeader({Key? key, this.nom, this.idCompagny, this.adresseEntreprise}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Text(
              "$nom", 
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
                  "(1) Avis",
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
        height: 220,
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
          // _buildTitle("Description"),
          SizedBox(height: 10),
          // _buildDescription(
          //   "Bienvenue sur notre plateforme d'informations. Cette section contient des détails essentiels que vous devez connaître pour naviguer au mieux dans notre application. Prenez le temps de lire ces informations attentivement afin de profiter pleinement de toutes les fonctionnalités que nous offrons.",
          // ),
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
  final String? categorieName;

  const InfosAvis({Key? key, this.idEntreprise,this.categorieName});

  @override
  InfosAvisState createState() => InfosAvisState();
}

class InfosAvisState extends State<InfosAvis> {
  List<dynamic> myItemsData = [];
  List<dynamic> myItemsDataCommentaire = [];

  Future<void> getData() async {
    try {
      final reponse = await ApiManager().fetchData("getAllCommentaire/${widget.categorieName}/${widget.idEntreprise}", "message de recuperation des commentaires", "messageError");

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
            const Text(
              'Notes et avis ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
             const SizedBox(height: 5),
            const Text(
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
  final String? categorieName;
  const AvisListe({Key? key, this.commentaires,this.categorieName});

  @override
  Widget build(BuildContext context) {

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
                      Container(
                        color: Colors.transparent,
                        width: 140,
                          child: Text(
                                 "${commentaires['nom_utilisateur']}",
                                    style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                           
                      ),
                      const Spacer(flex: 4,),
              
                  Container(
                    
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                               final userName= commentaires['nom_utilisateur'];
                              final usercontenu= commentaires['contenu_commentaire']; usercontenu;
                              final entrepriseName= commentaires['entreprise']['nom_entreprise'];
                              final heure=commentaires['heure'];
                              final date=commentaires['date_commentaire'];
                              final nbre_etoiles=commentaires['nombre_etoiles'];
                                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return  AvisModal(userName:userName,usercontenu:usercontenu,entrepriseName:entrepriseName,heure:heure,date:date,nbre_etoiles:nbre_etoiles, idPhoto:commentaires['id_photo'],idLoc: commentaires['entreprise']['id_Localisation']);
                            },
                          );  
                          },
                          child: Icon(Icons.more_horiz)
                        ),
                        const SizedBox(width: 5),
                      ],
                    ),
                  ),
                  ],
                ),
                Text(
                 commentaires['contenu_commentaire'] ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    for (int i = 0; i < (commentaires['nombre_etoiles'] ?? 0); i++)
                      Icon(Icons.star, color: Colors.yellow, size: 16),
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