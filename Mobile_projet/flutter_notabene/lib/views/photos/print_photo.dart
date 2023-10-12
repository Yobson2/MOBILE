import 'package:flutter/material.dart';

import '../../components/add_comm_sms.dart';


class PhotoDetailPage extends StatelessWidget {
  final String id;
  final String imageUrl;

  PhotoDetailPage({required this.id, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo'),
      ),
      body: SingleChildScrollView(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.network(imageUrl),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
               Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CommentaireComponent(imageUrl: imageUrl),
              ),
            );
            },
            child: const Text('Envoi'),
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            onPressed: () {
            },
            child: const Text('Supprimer'),
          ),
        ],
      ),
    ],
  ),
),

    );
  }
}
