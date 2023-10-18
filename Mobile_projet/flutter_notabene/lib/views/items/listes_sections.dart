import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_notabene/services/api_service.dart';
import 'package:google_fonts/google_fonts.dart';

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
          "getAllEntreprise/${widget.title}",
          "Les données des entreprises ont été recuperer",
          "Error lors de la recuperation");

      final res = requete['allEntreprises'];

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
      appBar: AppBar(
        title: Text(
          "${widget.title ?? ""}",
          style: GoogleFonts.quicksand(
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        toolbarHeight: 80,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
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
                          return MyItems(item: item);
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

  MyItems({ required this.item,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
           Navigator.push(
              context,
               MaterialPageRoute(builder: (context) => MyDetailsItems()),
              );
        print("Vous avez cliqué sur l'élément ${item['nom_entreprise']}");
      },
      child: SingleChildScrollView(
        child:Card(
       color: Colors.white,
      child: ListTile(
        leading: const CircleAvatar(
          backgroundImage: NetworkImage('https://plus.unsplash.com/premium_photo-1664870883044-0d82e3d63d99?auto=format&fit=crop&q=80&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=1470'),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              item['nom_entreprise'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
                children: [
                  Icon(Icons.location_on, size: 14),
                  SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      item['adresse_entreprise'] ,
                      softWrap: true, 
                      style: TextStyle(
                        fontSize: 13, 
                        
                      ),
                    ),
                  ),
                ],
              ),

          ],
        ),
        subtitle: Text("Informations sur l'endroit"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow, size: 12),
                    Icon(Icons.star, color: Colors.yellow, size: 12),
                    Icon(Icons.star, color: Colors.yellow, size: 12),
                    Icon(Icons.star, color: Colors.yellow, size: 12),
                    Icon(Icons.star, color: Colors.yellow, size: 12),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ))
    );
  }
}
