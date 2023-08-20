import 'package:flutter/material.dart';

final List<Map<String, dynamic>>listHastags=[];
class ListeView extends StatelessWidget {
  const ListeView({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    //isEmpty= vide de la liste
    return listHastags.isEmpty? const Center(
      child: Text(' No Hastags'),
        
    ):ListView.builder(
      itemCount: listHastags.length, 
      itemBuilder: (context, index) {
        // Pour gérer la suppression par swiping (effet)
        return Dismissible(
          key: Key(index.toString()),
          onDismissed: (direction) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(' votre element a été $index supprimé'),
              ),
            );
          },
          background: Container(
            color: Colors.red,
          ),
          child: Card(
            child: ListTile(
              title: Text(listHastags[index]['name']),
            ),
          ),
        );
      },
    );
  }
}
