import 'package:flutter/material.dart';

class ListesInsertCompagnyWidget extends StatefulWidget {
  const ListesInsertCompagnyWidget({ Key? key}) : super(key: key);

  @override
  State<ListesInsertCompagnyWidget> createState() => ListesInsertCompagnyWidgetState();
}

class ListesInsertCompagnyWidgetState extends State<ListesInsertCompagnyWidget> {
  @override
  Widget build(BuildContext context) {
   
    List<Widget> compagnies = [
      const Card(
        child: ListTile(
          leading: Icon(Icons.business),
          title: Text(
            'Entreprise 1',
            style: TextStyle(fontSize: 14), 
          ),
        ),
      ),
      const Card(
        child: ListTile(
          leading: Icon(Icons.business),
          title: Text(
            'Entreprise 2',
            style: TextStyle(fontSize: 14), 
          ),
        ),
      ),
       const Card(
        child: ListTile(
          leading: Icon(Icons.business),
          title: Text(
            'Entreprise 3',
            style: TextStyle(fontSize: 14), 
          ),
        ),
      ),
       const Card(
        child: ListTile(
          leading: Icon(Icons.business),
          title: Text(
            'Entreprise 4',
            style: TextStyle(fontSize: 14), 
          ),
        ),
      ),
    ];

  
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        backgroundColor: Colors.transparent, 
        elevation: 0, 
        title:const Center(
            child: Text(
              'Liste des entreprises enregistrées',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          )

      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: compagnies,
        ),
      ),
    );
  }
}
