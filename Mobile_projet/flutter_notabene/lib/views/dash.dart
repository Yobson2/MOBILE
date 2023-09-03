import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart'; 

class Dash extends StatefulWidget {
  final String token;
  const Dash({required this.token, Key? key}) : super(key: key);

  @override
  State<Dash> createState() => _DashState();
}

class _DashState extends State<Dash> {
  late String email;

  @override
  void initState() {
    super.initState();
    try {
      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

      // Extrayez l'adresse e-mail du token (vérifiez le nom de la clé dans votre token)
      email = jwtDecodedToken['adresse_email'];

      // Maintenant, vous avez l'adresse e-mail de l'utilisateur dans la variable 'email'
    } catch (e) {
      // Gérez l'erreur de décodage du token ici
      print('Erreur lors du décodage du token : $e');
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
          ],
        ),
      ),
    );
  }
}
