import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserRegistrationSection extends StatelessWidget {

  //Insert with my api
  Future<void> registerUser() async {
    final apiUrl = Uri.parse("http://localhost:8082/v1/registerUsers");  

    final userData = {
      "nom_utilisateur": "Nom de l'utilisateur",
      "adresse_email": "exemple@email.com",
      "mot_de_passe": "mot_de_passe"
    }; 

    final response = await http.post(
      apiUrl,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(userData),
    );

    if (response.statusCode == 201) {
      print("Utilisateur enregistré avec succès!");
    } else {
      print("Échec de l'enregistrement de l'utilisateur.");
      print("Code d'erreur: ${response.statusCode}");
      print("Message d'erreur: ${response.body}");
    }
  }

  void test(){
    print("object: bonjour de l'utilisateur");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 1,),
            const Text(
              "BIENVENUE !",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 10,),
            const Text(
              "Inscrivez-vous en tant qu'utilisateur basique.",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              width: 260,
              child: const TextField(
                decoration: InputDecoration(
                  suffixIcon: Icon(FontAwesomeIcons.user, size: 17,),
                  labelText: "Nom",
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: 260,
              child: const TextField(
                decoration: InputDecoration(
                  suffixIcon: Icon(FontAwesomeIcons.envelope, size: 17,),
                  labelText: "Email",
                ),
              ),
            ),
            Container(
              width: 260,
              child: const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  suffixIcon: Icon(FontAwesomeIcons.eyeSlash, size: 17,),
                  labelText: "Mot de passe",
                ),
              ),
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: registerUser,
              child: Container(
                width: 260,
                height: 50,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFFFFFFF), Color(0xFF0000FF)]
                  )
                ),
                child: const Text(
                  "S'inscrire",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
