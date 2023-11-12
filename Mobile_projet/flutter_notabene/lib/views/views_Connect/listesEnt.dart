import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:flutter_notabene/services/api_service.dart';

import '../../main.dart';

class Company {
  final String name;

  Company(this.name);
}

class ListesInsertCompagnyWidget extends StatefulWidget {
  const ListesInsertCompagnyWidget({Key? key}) : super(key: key);

  @override
  State<ListesInsertCompagnyWidget> createState() => ListesInsertCompagnyWidgetState();
}

class ListesInsertCompagnyWidgetState extends State<ListesInsertCompagnyWidget> {
     int? userId;
  List<dynamic> companies = [];
   bool isLoading = true;

   @override
   void initState() {
    super.initState();
    final id = mainSession.userId;
      setState(() {
        this.userId = id;
      }); 
     getCompagny();
    }

    Future<void> getCompagny() async {
       setState(() {
      isLoading = true; 
    });
     final response= await ApiManager().fetchData("getAllEntreprises/${userId}", "message", "messageError");
     
     try {
       final res = response['allEntreprises'];
       setState(() {
         companies=List<dynamic>.from(res);
          isLoading = false; 
       });
     } catch (e) {
        print("erreur message $e");
     }
    }
    
    Future<void> deleteCompagny(int idCompagny) async {
  try {
    setState(() {
      isLoading = true; 
    });
    final response = await ApiManager().deleteData("deleteEntreprise/${userId}/${idCompagny}", "message", "messageError");

    if (response != null && response.containsKey("data") && response["data"] == "ok") {
      Flushbar(
        title: 'Succès',
        message: 'Suppression d\'entreprise réussie',
        duration: Duration(seconds: 1),
      )..show(context);
    
      setState(() {
        companies.removeWhere((company) => company["id_entreprise"] == idCompagny);
        isLoading = false; 
      });
    }
  } catch (e) {
    print("erreur message $e");
    setState(() {
      isLoading = false;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Center(
          child: Text(
            'Liste des entreprises enregistrées',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
      ),
      body:  isLoading 
          ? const Center(
              child: CircularProgressIndicator(),
            )
          :Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: companies.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                elevation: 1,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: Colors.white, 

                child: ListTile(
                  leading:  CircleAvatar(
                    backgroundImage: NetworkImage("${ApiManager().baseUrlImage}/imageEntreprise/${companies[index]["photo_entreprises"]}"),
                    radius: 20,
                  ),
                  title: Text(
                    companies[index]["nom_entreprise"],
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  subtitle:  Padding(
                    padding: EdgeInsets.only(top: 8), 
                    child: Text(
                      companies[index]["adresse_entreprise"],
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  trailing:Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    GestureDetector(
      onTap: () {
        _showDeleteConfirmationDialog(index);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey, 
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), 
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 2), 
            ),
          ],
        ),
        child: Icon(
          Icons.delete, 
          color: Colors.white, 
          size: 18, 
        ),
      ),
    ),
  ],
),

                ),
              );

          },
        ),
      ),
    );
  }

 void _showDeleteConfirmationDialog(int index) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Confirmation de suppression ${companies[index]["id_entreprise"]}"),
        content: Text("Voulez-vous vraiment supprimer cette entreprise ?"),
        actionsPadding: EdgeInsets.symmetric(horizontal: 20), 
        actions: [
          TextButton(
            child: const Text(
              "Annuler ",
              style: TextStyle(color: Colors.blue), 
            ),
            onPressed: () {
              Navigator.of(context).pop(); 
            },
          ),
          const SizedBox(width: 10), 
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red, 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), 
              ),
            ),
            child: const Text(
              "Supprimer",
              style: TextStyle(color: Colors.white, fontSize: 16), // Couleur et taille du texte
            ),
            onPressed: () {
              final idCompagny=companies[index]["id_entreprise"];
              deleteCompagny(idCompagny);
              Navigator.of(context).pop(); 
            },
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), 
        ),
      );
    },
  );
}


}



