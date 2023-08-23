import 'package:flutter/material.dart';


class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool _isUserSection = true;

  void _toggleSection() {
    setState(() {
      _isUserSection = !_isUserSection;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inscription"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _toggleSection(),
                  child: Text("Utilisateur Simple"),
                  style: ElevatedButton.styleFrom(
                    primary: _isUserSection? const Color.fromARGB(255, 34, 38, 41) : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => _toggleSection(),
                  child: Text("Entreprise"),
                  style: ElevatedButton.styleFrom(
                  primary: _isUserSection ? Colors.blue : Colors.black,
                ),
                  ),
              ],
            ),
            SizedBox(height: 20),
            _isUserSection ? UserRegistrationSection() : CompanyRegistrationSection(),
          ],
        ),
      ),
    );
  }
}

class UserRegistrationSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: "Nom"),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Adresse e-mail"),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Mot de passe"),
            obscureText: true,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Logique d'inscription pour l'utilisateur simple
            },
            child: Text("S'inscrire"),
          ),
        ],
      ),
    );
  }
}

class CompanyRegistrationSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: "Nom de l'entreprise"),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Adresse e-mail de l'entreprise"),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Mot de passe"),
            obscureText: true,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Numéro de téléphone"),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Logique d'inscription pour l'entreprise
            },
            child: Text("S'inscrire"),
          ),
        ],
      ),
    );
  }
}
