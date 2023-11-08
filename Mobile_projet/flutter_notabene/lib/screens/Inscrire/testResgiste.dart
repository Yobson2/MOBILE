import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_notabene/screens/Inscrire/testConnexion.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../../models/user_model.dart';
import '../../services/api_service.dart';
import '../login_screen.dart';

class SignForm extends StatefulWidget {
  const SignForm({super.key});

  @override
  State<SignForm> createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  bool hide = true;
  String password = "";
  String email = "";
  bool isLoading = false;
  bool isTwoFactorEnabled = false;
  bool acceptTerms = true;

 bool isEmailValid = true;
 bool isPasswordValid = true;
   final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  

  final RegExp emailRegex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    caseSensitive: false,
    multiLine: false,
);

final RegExp passwordRegex = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
    caseSensitive: false,
    multiLine: false,
);


 

      Future<void> registerUser() async {

      User userData = User( nom_utilisateur: _nameController.text, adresse_email:_emailController.text, mot_de_passe: _passwordController.text);
      try {
        _validateEmail();
        _validatePassword();
        await ApiManager().postData("registerUsers",  userData.toMap(),"creation terminée", "Error d'envoi");
        _nameController.clear();
        _emailController.clear();
        _passwordController.clear();
      } catch (e) {
        print("erreur message $e");
      }
    
    }

    void _validateEmail() {
  if (!emailRegex.hasMatch(_emailController.text)) {
    setState(() {
      isEmailValid = false;
    });
    throw Exception("Invalid email");
  } else {
    setState(() {
      isEmailValid = true;
    });
  }
}

void _validatePassword() {
  if (!passwordRegex.hasMatch(_passwordController.text)) {
    setState(() {
      isPasswordValid = false;
    });
    throw Exception("Invalid password");
  } else {
    setState(() {
      isPasswordValid = true;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: SizedBox(
        
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('NOTABENE',
                        style: GoogleFonts.lilitaOne(
                            color: Colors.white, fontSize: 30)),
                    const SizedBox(height: 10),
                    Text("Bienvenue",
                        style: GoogleFonts.caveat(
                            color: Colors.white, fontSize: 30)),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextField(
                        controller: _nameController,
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        cursorColor: Colors.grey,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(FontAwesomeIcons.user, size: 17),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 2,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          labelText: 'Pseudo',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          floatingLabelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                         controller: _emailController, 
                        onChanged: (value) {
                          setState(() {
                            email = value;
                             isEmailValid = true;
                          });
                        },
                        cursorColor: Colors.grey,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(FontAwesomeIcons.envelope, size: 17),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 2,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          floatingLabelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                      ),
                       if (!isEmailValid)
                          Container(
                            margin:EdgeInsets.only(left: 190),
                            child: const Text(
                              "Format d'e-mail invalide",
                              style: TextStyle(color: Colors.red,fontSize: 10),
                            ),
                          ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _passwordController, 
                        onChanged: (value) {
                          setState(() {
                            password = value;
                            isPasswordValid = true;
                          });
                        },
                        cursorColor: Colors.grey,
                        obscureText: hide,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: Colors.grey,
                            size: 17,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              hide
                                  ? Icons.visibility_off_outlined
                                  : Icons.remove_red_eye_outlined,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                hide = !hide;
                              });
                            },
                          ),
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 2,
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          labelText: 'Mot de passe',
                          labelStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                          floatingLabelStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                      ),
                      if (!isPasswordValid)
                          Container(
                            margin:EdgeInsets.only(left: 100),
                            child: const Text(
                              "Le mot de passe doit comporter au moins 8 caractères, incluant au moins une lettre et un chiffre.",
                              style: TextStyle(color: Colors.red,fontSize: 10),
                            ),
                          ),
                      const SizedBox(height: 20),
                     ElevatedButton(
                              onPressed: () {
                                registerUser();
                                print("Welcome");
                              },
                              style: ButtonStyle(
                                minimumSize:
                                    MaterialStateProperty.all(const Size(double.infinity, 50)),
                                backgroundColor:
                                    MaterialStateProperty.all(Theme.of(context).primaryColor),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    side: BorderSide(color: Colors.white, width: 2),
                                  ),
                                ),
                                elevation: MaterialStateProperty.all(10),
                              ),
                              child: Text(
                                "S'inscrire",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Vous avez déjà un compte ?"),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginForm()),
                              );
                            },
                            child: const Text(
                              "Connexion",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
