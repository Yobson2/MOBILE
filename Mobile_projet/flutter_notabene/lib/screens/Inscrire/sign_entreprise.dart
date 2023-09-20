
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class CompanyRegistrationSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const SizedBox(height: 1,),
                       const Text("BIENVENUE !"
                       ,style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),),
                        const SizedBox(height: 10,),
                      const Text("Inscrivez-vous en tant qu'entreprise."
                       ,style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),),
                        const SizedBox(height: 10,),
                        const SizedBox(
                         width: 260,
                         child: TextField(
                          decoration: InputDecoration(
                            suffixIcon: Icon(FontAwesomeIcons.user, size: 17,),
                            labelText: "Nom de l'entreprise",
                          ),
                         ),
                        ),
                        const SizedBox(height: 10,),
                        Container(
                         width: 260,
                         child: const TextField(
                          decoration: InputDecoration(
                            suffixIcon: Icon(FontAwesomeIcons.envelope, size: 17,),
                            labelText: "Adresse e-mail",
                          ),
                         ),
                        ),
                        Container(
                         width: 260,
                         child: const TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            suffixIcon: Icon(FontAwesomeIcons.phone, size: 17,),
                            labelText: "Numéro de téléphone",
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
                          SizedBox(height: 23,),
                          GestureDetector(
                            child: Container(
                              width: 260,
                              height: 50,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(40)),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFFFFFFFF),
                                    Color(0xFF0000FF)
                                  ]
                                  
                                  )
                              ),
                              child: const Text("S'inscrire",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                              ),),
                            ),
                          ),
        ],
      ),
    );
  }
}
