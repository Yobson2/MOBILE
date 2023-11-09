import 'package:flutter/material.dart';
import 'package:flutter_notabene/views/views_Connect/home_connect.dart';
import 'package:flutter_notabene/views/views_Connect/insertEntrepise.dart';
import 'package:flutter_notabene/views/views_Connect/notification_connect.dart';
import 'package:flutter_notabene/views/views_Connect/profit_connect.dart';

import '../main.dart';
import 'home_notconnect.dart';

class ParamsView extends StatelessWidget {
  const ParamsView({super.key});

 void _showExitConfirmationDialog(BuildContext context) {
  
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        title: Text(
          "Déconnexion",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          "Êtes-vous sûr de vouloir vous déconnecter ?",
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.red, 
            ),
            child: Text(
              "Annuler",
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop(); 
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.green, // Utilisation d'une couleur pour mettre en avant le bouton "Quitter"
            ),
            child: Text(
              "Quitter",
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            onPressed: () {
              mainSession.userId=0;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ConnectedUserWidget(),
                ),
              );
            },
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Paramètres',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('Profil'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NoteUserWidget()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.notification_add),
              title: const Text('Notifications'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotifUserWidget(),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.create),
              title: const Text('Entreprise'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const InsertCompagnyWidget(),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Quitter'),
              onTap: () {
                _showExitConfirmationDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
