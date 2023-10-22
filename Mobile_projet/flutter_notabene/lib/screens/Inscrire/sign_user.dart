import 'package:flutter/material.dart';
import 'package:flutter_notabene/models/user_model.dart';
import 'package:flutter_notabene/services/api_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserRegistrationSection extends StatelessWidget {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> registerUser() async {

   User userData = User( nom_utilisateur: _nameController.text, adresse_email:_emailController.text, mot_de_passe: _passwordController.text);
  try {
    await ApiManager().postData("registerUsers",  userData.toMap(),"creation terminée", "Error d'envoi");
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    print("objective data $userData");
  } catch (e) {
    print("erreur message $e");
  }
 
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
            const SizedBox(height: 10,),
            const Text(
              "Inscrivez-vous en tant qu'utilisateur basique.",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10,),
            SizedBox(
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
            SizedBox(
              width: 260,
              child: TextField(
                controller: _passwordController, 
                obscureText: true,
                decoration: const InputDecoration(
                  suffixIcon: Icon(FontAwesomeIcons.eyeSlash, size: 17,),
                  labelText: "Mot de passe",
                ),
              ),
            ),
            const SizedBox(height: 20,),
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
