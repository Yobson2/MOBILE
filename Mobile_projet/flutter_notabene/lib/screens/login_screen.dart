import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_notabene/screens/Sign_screen.dart';
import 'package:flutter_notabene/screens/home_screem.dart';
import 'package:flutter_notabene/views/views_Connect/home_connect.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late SharedPreferences prefs;

   

  @override
    void initState() {
      super.initState();
      initSharedPref();
    }

     void initSharedPref() async {
        prefs= await SharedPreferences.getInstance() ;
     }



Future<void> loginUser() async {
  try {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      return;
    }

    final userLogin = {
      "adresse_email": _emailController.text,
      "mot_de_passe": _passwordController.text,
    };

    final url = Uri.parse("http://192.168.1.5:8082/apiNotabene/v1/loginUsers");

    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(userLogin),
    );

    if (response.statusCode == 200) {
      _emailController.clear();
      _passwordController.clear();
      var jsonResponse = jsonDecode(response.body);
      var myToken = jsonResponse['token'];
      print('myToken: ' + myToken);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ConnectedUserWidget(token: myToken)),
      );
    } else {
      print("Erreur loginUser: ${response.statusCode}");
    }
  } catch (e) {
    print("Erreur lors de la requête : $e");
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFFFFFF), Color(0xFF0000FF)],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100,),
              const SizedBox(height: 20,),
              Container(
                alignment: Alignment.center,
                height: 480,
                width: 320,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15,),
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
                      "Veuillez vous connecter à votre compte",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Container(
                      width: 250,
                      child: TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(FontAwesomeIcons.envelope, size: 17,),
                          labelText: "Email",
                        ),
                      ),
                    ),
                    Container(
                      width: 250,
                      child: TextField(
                        obscureText: true,
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(FontAwesomeIcons.eyeSlash, size: 17,),
                          labelText: "Mot de passe",
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 40, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Mot de passe oublié ?",
                            style: TextStyle(
                              color: Colors.black, 
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    GestureDetector(
                      onTap:loginUser,
                      child: Container(
                        width: 250,
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
                          "Se connecter",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Nouveau sur Notabene ?"),
                        GestureDetector(
                          onTap: () {
                             
                             Navigator.push(
                               context,
                                    MaterialPageRoute(builder: (context) => RegistrationPage()),
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
            ],
          ),
        ),
      ),
    );
  }
  
 
}

