import 'package:flutter/material.dart';
import 'package:flutter_notabene/views/views_Connect/insertEntrepise.dart';
import 'package:flutter_notabene/views/views_Connect/notification_connect.dart';
import 'package:flutter_notabene/views/views_Connect/profit_connect.dart';

import 'home_notconnect.dart';

class ParamsView extends StatelessWidget {
  const ParamsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:Container(
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
                MaterialPageRoute(builder: (context) => const NotifUserWidget()),
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
                MaterialPageRoute(builder: (context) => const  InsertCompagnyWidget()),
              );
              },
            ),
             const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Options avancées'),
              onTap: () {
              
                print("object");
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Quitter'),
              onTap: () {
                 Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotConnectedUserWidget()),
              );
              },
            ),
          ],
        ),
      )
    );
     
  }
}
