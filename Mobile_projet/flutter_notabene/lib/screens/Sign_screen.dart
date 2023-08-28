import 'package:flutter/material.dart';
import 'package:flutter_notabene/screens/login_screen.dart';

import 'Inscrire/sign_entreprise.dart';
import 'Inscrire/sign_user.dart';


class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool _isUserSection = true;

  void _toggleSection(bool isUserSection) {
    setState(() {
      _isUserSection = isUserSection;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
   
        child: Column(
          children: [
            SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _toggleSection(true),
                  child: Icon(Icons.person),
                  style: ElevatedButton.styleFrom(
                    primary: _isUserSection ? const Color.fromARGB(255, 34, 38, 41) : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => _toggleSection(false),
                  child: Icon(Icons.business),
                  style: ElevatedButton.styleFrom(
                    primary: !_isUserSection ? Colors.blue : Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            _isUserSection ? UserRegistrationSection() : CompanyRegistrationSection(),
            SizedBox(height: 1,),
            Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text("Vous avez déjà un compte ?"),
                   GestureDetector(
                      onTap: () {
                           Navigator.push(
                               context,
                                    MaterialPageRoute(builder: (context) => LoginScreen()),
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
                  )
          ],
        ),
      ) );
  }
}
