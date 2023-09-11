// Importez les bibliothèques nécessaires
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import '../services/connectEtat.dart';
class CarteGloblale extends StatelessWidget {
  const CarteGloblale({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Accédez à UserProvider et récupérez l'ID à partir du stockage
    final userProvider = Provider.of<UserProvider>(context);
    userProvider.getUserIdFromStorage(); // Récupérez l'ID à partir du stockage

    // Maintenant vous pouvez accéder à l'ID
    final userId = userProvider.userId;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Carte Globale'),
          Text('ID de l\'utilisateur : $userId'),
          // Ajoutez d'autres éléments de votre carte ici
        ],
      ),
    );
  }
}
