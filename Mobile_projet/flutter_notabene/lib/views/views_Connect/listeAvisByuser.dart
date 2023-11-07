import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:flutter_notabene/services/api_service.dart';

import '../../main.dart';

class ListesInsertAvisWidget extends StatefulWidget {
  const ListesInsertAvisWidget({Key? key}) : super(key: key);

  @override
  State<ListesInsertAvisWidget> createState() => ListesInsertAvisWidgetState();
}

class ListesInsertAvisWidgetState extends State<ListesInsertAvisWidget> {
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
            'Mes avis',
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
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: Colors.white, 

                child: ListTile(
                  leading:  CircleAvatar(
                    backgroundImage: NetworkImage("http://192.168.1.4:8082/imageEntreprise/${companies[index]["photo_entreprises"]}"),
                    radius: 20,
                  ),
                  title: Text(
                    companies[index]["nom_entreprise"],
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  subtitle:  Padding(
                    padding: EdgeInsets.only(top: 8), 
                    child: Text(
                      "Vous avez laissé 45 commentaires concernant cette entreprise.",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  trailing:Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    GestureDetector(
      onTap: () {
       
      },
      child: Container(
        padding: EdgeInsets.all(8),
        child: Icon(
          Icons.horizontal_rule, 
          color: Colors.black, 
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
}



