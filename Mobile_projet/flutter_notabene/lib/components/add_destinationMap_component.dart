import 'package:flutter/material.dart';

class AddDestinationMapComponent extends StatelessWidget {
  const AddDestinationMapComponent({super.key});

  //methode pour le modale

  void _modal(BuildContext context){
    
    showModalBottomSheet(
      context: context,
      builder: (context)=> Padding(
        padding: const EdgeInsets.all(8.0),
        child:Wrap(
        children: <Widget>[
          Padding(padding: const EdgeInsets.all(8.0),
           child: Text(
            "Create a new hastags",
            style: Theme.of(context).textTheme.headlineSmall),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter a new hastag",
                ),
                
              ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: ()=> Navigator.pop(context), //Quitter à chaque clique
                     child: Text("cancel".toUpperCase())
                     ), 
                     TextButton(
                    onPressed: ()=> Navigator.pop(context),
                     child: Text("Add".toUpperCase())
                     ),   
                ],
              ),
          ),
        ],
      ),
      
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.note_add),
        onPressed: () {
         _modal(context);
        },
       
      );
  }
}