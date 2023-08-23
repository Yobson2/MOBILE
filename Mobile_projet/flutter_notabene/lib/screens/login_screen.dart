import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:font_awesome/font_awesome.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                colors: [
                  Color(0xFFFFFFFF),
                  Color(0xFF0000FF)
                ]
                
                )
             ),
             child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                SizedBox(height: 80,),
                Image.asset("assets/images/logot.png", width: 80, height: 80),
                SizedBox(height: 15,),
                Text("Notabene",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 20,),
                Container(
                  alignment: Alignment.center,
                  height: 480,
                  width: 320,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,  
                    children: [
                      SizedBox(height: 15,),
                       const Text("Bonjour"
                       ,style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),),
                        SizedBox(height: 10,),
                      const Text("Veuillez vous connecter à votre compte"
                       ,style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),),
                        SizedBox(height: 10,),
                        Container(
                         width: 250,
                         child: const TextField(
                          decoration: InputDecoration(
                            suffixIcon: Icon(FontAwesomeIcons.envelope, size: 17,),
                            labelText: "Email",
                          ),
                         ),
                        ),
                        Container(
                         width: 250,
                         child: const TextField(
                          obscureText: true,
                          decoration: InputDecoration(
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
                              Text("Mot de passe oublié ?"
                              ,style: TextStyle(
                                 color: Colors.blue,
                                 fontSize: 10,
                                 fontWeight: FontWeight.bold
                               ),),
                             ],
                          ),
                          
                          ),
                          SizedBox(height: 20,),
                          GestureDetector(
                            child: Container(
                              width: 250,
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
                              child: const Text("Se connecter",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                              ),),
                            ),
                          ),
                          SizedBox(height: 10,),
                          const Text("Ou avec",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                          ),),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 200,
                                height: 20,
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
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                  Icon(FontAwesomeIcons.google,
                                   size: 18,
                                   color: Colors.grey,
                                  ),
                                  SizedBox(width: 10,),
                                  Text("Facebook",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                                ),),
                                ],)
                              )
                            ],
                          ),
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