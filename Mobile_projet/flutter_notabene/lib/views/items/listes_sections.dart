import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_notabene/main.dart';
import 'package:flutter_notabene/services/api_service.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/moreAvis_component.dart';
import '../carte_view.dart';
import 'details_items.dart';

class ListesBlocItems extends StatefulWidget {
  final String? title;
  final int? id;

  ListesBlocItems({Key? key, this.id, this.title }) : super(key: key);

  @override
  _ListesBlocItemsState createState() => _ListesBlocItemsState();
}

class _ListesBlocItemsState extends State<ListesBlocItems> { 
   List<dynamic> myItemsData = [];
   bool isLoading = true;
  
  @override
  void initState() {
    super.initState();
    myCustomFunction();
  }

  Future<void> myCustomFunction() async {
    try {
      final requete = await ApiManager().fetchData(
          "getAllCommentaire/${widget.title}",
          "Les données des entreprises ont été recuperer",
          "Error lors de la recuperation");

      final res = requete['utilisateursAvecCommentaires'];

       Timer(Duration(seconds: 1), () {
      setState(() {
       myItemsData = List<dynamic>.from(res);
        isLoading = false;
      });
    });
    } catch (e) {
      print("Erreur : Les données n'ont pas été recuperer $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            backgroundColor: Colors.blue,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
            ),
            title: Column(
              children: [
                Text(
                  "${widget.title ?? ""}",
                  style: GoogleFonts.quicksand(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  "(${myItemsData.length}) Avis",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                )
              ],
            ),
            centerTitle: true,
            toolbarHeight: 80,
            elevation: 0.0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                 Navigator.pop(context);
                setState(() {
                  mainSession.nbreTolalEtoille=0;
                });
              },
            ),
          ),
        ),

      body: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 0.0, top: 0.0, right: 10.0,left: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : myItemsData.isNotEmpty
                    ? ListView.builder(
                        itemCount: myItemsData.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> item = myItemsData[index];
                          return MyItems(item: item,categorieName:widget.title);
                        },
                      )
                    : Center(
                        child: Text("Aucune donnée disponible"), 
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyItems extends StatelessWidget {
   final Map<String, dynamic> item;
   final String? categorieName;

  MyItems({ required this.item,this.categorieName});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child:Card(
       color: Colors.white,
      child: ListTile(
        leading: const CircleAvatar(
          backgroundImage: NetworkImage('https://plus.unsplash.com/premium_photo-1664870883044-0d82e3d63d99?auto=format&fit=crop&q=80&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=1470'),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             
            Row(
              children: [
                SizedBox(
                  width: 120,
                  child: Text(
                              item['nom_utilisateur'] ?? '',
                              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                              ),
                            ),
                ),
                 const Spacer(flex: 15,),
            InkWell(
              onTap: () {
                final userName= item['nom_utilisateur'];
                final usercontenu= item['contenu_commentaire'];
                final entrepriseName = item['entreprise'] != null ? item['entreprise']['nom_entreprise'] : 'null';
                final idLoc= item['entreprise'] != null ? item['entreprise']['id_Localisation']:  item['id_localisation'];
                final heure=item['heure'];
                final date=item['date_commentaire'];
                final nbre_etoiles=item['nombre_etoiles'];
              
              
                          showDialog(
              context: context,
              builder: (BuildContext context) {
                return  AvisModal(userName:userName,usercontenu:usercontenu,entrepriseName:entrepriseName,heure:heure,date:date,nbre_etoiles:nbre_etoiles, idPhoto:item['id_photo'],idLoc: idLoc);
              },
            );  
                          },
                          child: const Column(
                            children: [
                              Icon(Icons.more_horiz, color: Colors.grey,),
                            ]),
                        ),
              ],
            ),
             const SizedBox(height: 6,),
            Row(
                children: [
                 Flexible(
                  child:Text(
                    "${item['contenu_commentaire']} ",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                )),
                ],
              ),
              Row(
                children: [
                  for (int i = 0; i < (item['nombre_etoiles'] ?? 0); i++)
                      Icon(Icons.star, color: Colors.yellow, size: 12),
                ],
              ),
              //  const Spacer(flex: 3,),

               Row(
              
                  children: [
                    Text(
                      "${item['heure']}",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                    item['date_commentaire'] ,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                    
                      
                  ],
                ),

          ],
        ),
        
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.start,
      children: [
      if(item['entreprise'] != null)
        InkWell(
          onTap: () {
                 final name= item['entreprise']['nom_entreprise'] ?? 'null';
                final idEntreprise=item['entreprise']['id_entreprise'];
                final adresseEntreprise=item['entreprise']['adresse_entreprise'];
                final idLocalisation=item['entreprise']['id_Localisation'];
           Navigator.push(
              context,
               MaterialPageRoute(builder: (context) => MyDetailsItems(nomEntreprise:name, idEntreprise:idEntreprise,adresseEntreprise:adresseEntreprise,idLocalisation:idLocalisation,categorieName:categorieName)),
              );           
            },
          child: const Column(
          children: [
             Icon(Icons.info, color: Colors.grey,),
                 
                 ]),
                ),
                 const SizedBox(width: 5),
              Flexible(
                child:   Text(
      item['entreprise'] != null
        ? "${item['entreprise']['nom_entreprise'] ?? 'Nom non disponible'}"
        : '',
      style: TextStyle(
        fontSize: 10,
        color: Colors.grey,
        fontWeight: FontWeight.normal,
      ),
        ),
                
                )
      
      ],
      ),

        
      ),
    ));
  }
}


