import 'package:flutter/material.dart';
import 'package:flutter_notabene/services/api_service.dart';
import 'package:google_fonts/google_fonts.dart';

class ListesBlocItems extends StatefulWidget {
  final String? title;
  final int? id;

  ListesBlocItems({Key? key, this.id, this.title }) : super(key: key);

  @override
  _ListesBlocItemsState createState() => _ListesBlocItemsState();
}

class _ListesBlocItemsState extends State<ListesBlocItems> {
   Map<String, dynamic> myItemsData = {}; 
  //  List<dynamic> myItemsData = [];
  
  @override
  void initState() {
    super.initState();
    myCustomFunction();
  }

  Future<void> myCustomFunction() async {
    final requete= await ApiManager().fetchData("getAllEntreprise/${widget.title}", "Les données des entreprises ont été recuperer", "Error lors de la recuperation");
    final res= requete['allEntreprises'];

    print("mes données $res");
   try {
      setState(() {
      myItemsData =res;

    });
    
   } catch (e) {
      print("Erreur : Les données n'ont pas été recuperer");
   }

   
  }

  @override
  Widget build(BuildContext context) {
     print("my données : $myItemsData");
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
            child: myItemsData != null
              ? ListView.builder(
                  itemCount: myItemsData.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> item = myItemsData[index];
                    return MyItems(item: item);
                  },
                )
              : Center(
                  child: CircularProgressIndicator(), 
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
    return Card(
       color: Colors.white,
      child: ListTile(
        leading: CircleAvatar(
          // backgroundImage: NetworkImage(''),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nom de l'endroit",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Icon(Icons.location_on, size: 14),
                SizedBox(width: 4),
                Text( item['nom_entreprise'],), 
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
    );
  }
}
