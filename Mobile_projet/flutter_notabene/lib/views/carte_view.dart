import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import '../services/connectEtat.dart';

class CarteGloblale extends StatelessWidget {
  const CarteGloblale({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Accédez à l'ID de l'utilisateur en utilisant Provider
    final userId = Provider.of<UserProvider>(context).userId;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Carte Globale'),
          Text('ID de l\'utilisat : $userId'),
          // Ajoutez d'autres éléments de votre carte ici
        ],
      ),
    );
  }
}
