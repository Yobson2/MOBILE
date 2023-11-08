import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_notabene/screens/Inscrire/testResgiste.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../../models/user_model.dart';
import '../../services/api_service.dart';
import '../../views/views_Connect/home_connect.dart';
import '../login_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool hide = true;
  String password = "";
  String email = "";
  bool isLoading = false;
  bool isTwoFactorEnabled = false;
  bool acceptTerms = true;

  bool isEmailValid = true;
  bool isPasswordValid = true;
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

  
Future<void> loginUser() async {
  try {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      return;
    }
     _validateEmail();
     _validatePassword();
    User userLogin= User(adresse_email:_emailController.text, mot_de_passe:_passwordController.text);
    var mytoken= await ApiManager().loginUserAndGetToken('loginUsers', userLogin.toMap());
     if(mytoken!=null){
       _emailController.clear();
       _passwordController.clear();
       Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ConnectedUserWidget(token: mytoken)),
      );
     }else{print("token not found");}
  } catch (e) {
    print("Erreur lors de la requête : $e");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false, 
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
                    Text("Veuillez vous connecter à votre compte",
                        style: GoogleFonts.caveat(
                            color: Colors.white, fontSize: 20)),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
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
                      const Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Mot de passe oublié ?",
                            style: TextStyle(
                              color: Colors.blue, 
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                      const SizedBox(height: 10),
                      isLoading
                          ? CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            )
                          : ElevatedButton(
                              onPressed: () {
                                loginUser();
                              
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
                                "Se connecter",
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
                        const Text("Nouveau sur Notabene ?"),
                        GestureDetector(
                          onTap: () {
                             
                             Navigator.pushReplacement(
                               context,
                                    MaterialPageRoute(builder: (context) => const SignForm()),
                                  );
                          },
                          child: const Text(
                            "S'enregistrer",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
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
