import 'package:flutter/material.dart';

class SearchLocalisationScreem extends StatefulWidget {
  const SearchLocalisationScreem({Key? key}) : super(key: key);

  @override
  _SearchLocalisationScreemState createState() => _SearchLocalisationScreemState();
}

class _SearchLocalisationScreemState extends State<SearchLocalisationScreem> {
  List<String> suggestions = [];
  TextEditingController _searchController = TextEditingController();

  void _onSearchChanged(String query) {
    if (query.isNotEmpty) {
      // Mettez à jour les suggestions ici en fonction de la requête
      setState(() {
        suggestions = [
          'Paris',
          'New York',
          'London',
          'Tokyo',
          'Tokyo',
          'Tokyo',
          'Tokyo',
          'Tokyo',
        ];
      });
    } else {
      setState(() {
        suggestions.clear(); // Effacer les suggestions si le champ est vide
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0.0,
      //   backgroundColor: Colors.white,
      //   leading: const Padding(
      //     padding: EdgeInsets.only(left: 10.0),
      //     child:CircleAvatar(
      //       backgroundColor: Colors.grey,
      //       child: Icon(
      //         Icons.send
      //       ),
      //       ) ,
          
      //     ),
      //     title: const Text(
      //       "data",
      //       style: TextStyle(color: Colors.grey),
            
      //       ),
           
      // ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              style: TextStyle(fontSize: 18.0, color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Chercher un lieu ',
                labelStyle: TextStyle(fontSize: 18.0),
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2.0,
                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: ListTile(
                    title: Text(
                      suggestions[index],
                      style: TextStyle(fontSize: 18.0),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Suggestion sélectionnée'),
                            content: Text('Vous avez sélectionné : ${suggestions[index]}'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
