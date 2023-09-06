import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserRegistrationSection extends StatelessWidget {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> registerUser() async {
  final userData = {
    "nom_utilisateur": _nameController.text,
    "adresse_email": _emailController.text,
    "mot_de_passe": _passwordController.text,
  };

  final url = Uri.parse("http://192.168.1.13:8082/apiNotabene/v1/registerUsers");

  var response = await http.post(
    url,
    headers: <String, String>{
      "Content-Type": "application/json; charset=utf-8",
    },
    body: jsonEncode(userData),
  );


  if (response.statusCode == 201) {
    // Réinitialiser les contrôleurs de texte et le formulaire
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();

    print("creation terminée");
  }
  print(userData);
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
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10,),
            const Text(
              "Inscrivez-vous en tant qu'utilisateur basique.",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              width: 260,
              child: TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  suffixIcon: Icon(FontAwesomeIcons.user, size: 17,),
                  labelText: "Nom",
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: 260,
              child: TextField(
                controller: _emailController, 
                decoration: const InputDecoration(
                  suffixIcon: Icon(FontAwesomeIcons.envelope, size: 17,),
                  labelText: "Email",
                ),
              ),
            ),
            Container(
              width: 260,
              child: TextField(
                controller: _passwordController, 
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
                    colors: [Color(0xFFFFFFFF), Color(0xFF0000FF)],
                  ),
                ),
                child: const Text(
                  "S'inscrire",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
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
