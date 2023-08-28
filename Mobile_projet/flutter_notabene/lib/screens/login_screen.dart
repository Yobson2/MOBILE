import 'package:flutter/material.dart';
import 'package:flutter_notabene/screens/Sign_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:font_awesome/font_awesome.dart';
Color googleBlueColor = Color(0xFF4285F4);

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
                const SizedBox(height: 100,),
                // Image.asset("assets/images/logot.png", width: 80, height: 80),
                // const SizedBox(height: 15,),
                // const Text("Notabene",
                // style: TextStyle(
                //   color: Colors.white,
                //   fontSize: 20,
                //   fontWeight: FontWeight.bold
                // ),),
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
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,  
                    children: [
                      const SizedBox(height: 15,),
                       const Text("BIENVENUE !"
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Nouveau sur Notabene ?"),
                                     GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => RegistrationPage()),
                                  );
                                },
                                child: Text(
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