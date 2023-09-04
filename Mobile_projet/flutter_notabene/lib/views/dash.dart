import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/connectEtat.dart';

class Dash extends StatefulWidget {
  final String token;

  const Dash({required this.token, Key? key}) : super(key: key);

  @override
  State<Dash> createState() => _DashState();
}

class _DashState extends State<Dash> {
  late String email;
  late String nom;
  Map<String, dynamic> userData = {}; // Utilisez une carte pour stocker les données de l'utilisateur

  @override
  void initState() {
    super.initState();
    try {
      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

      // Extrayez les valeurs du token
      email = jwtDecodedToken['adresse_email'];
      nom = jwtDecodedToken['adresse_email'];

      fetchUserData();
    } catch (e) {
      print('Erreur lors du décodage du token : $e');
    }
  }
 Future<void> fetchUserData() async {
    try {
      // Effectuez une requête HTTP pour récupérer les données de l'utilisateur en fonction de son email
      final response = await http.get(Uri.parse('http://192.168.1.101:8082/apiNotabene/v1/userByEmail/$email'));

      if (response.statusCode == 200) {
        userData = json.decode(response.body);

        // Mettez à jour l'interface utilisateur avec les données de l'utilisateur
        setState(() {});

        // Enregistrez l'ID de l'utilisateur dans le stockage local
        final prefs = await SharedPreferences.getInstance();
        prefs.setInt('user_id', userData['users']['id_utilisateur']);

        // Utilisez le Provider pour définir l'ID de l'utilisateur
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userData['users']['id_utilisateur']);

        print('Données de l\'utilisateur : $userData');
      } else {
        // Gérez les erreurs de requête HTTP
        print('Erreur lors de la récupération des données de l\'utilisateur. Code de réponse : ${response.statusCode}');
      }
    } catch (e) {
      // Gérez les erreurs de requête HTTP
      print('Erreur lors de la récupération des données de l\'utilisateur : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome dashboard"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Bienvenue,"),
            Text(email),
            // Affichez les données de l'utilisateur
            Text('Nom de l\'utilisateur : ${userData['users']['id_utilisateur']}'),
            // Ajoutez d'autres champs de données de l'utilisateur ici
          ],
        ),
      ),
    );
  }
}
