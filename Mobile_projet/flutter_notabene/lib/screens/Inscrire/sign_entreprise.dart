import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CompanyRegistrationSection extends StatefulWidget {
  @override
  _CompanyRegistrationSectionState createState() =>
      _CompanyRegistrationSectionState();
}

class _CompanyRegistrationSectionState
    extends State<CompanyRegistrationSection> {
  String selectedOption = 'Dynamic Option 1';
  List<String> dynamicOptions = ['Dynamic Option 1', 'Dynamic Option 2', 'Dynamic Option 3'];

  File? _image;

  Future<void> _getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        _image = File(image.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Remplissez les informations de votre entreprise",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),

            TextField(
              decoration: InputDecoration(
                labelText: "Nom de l'entreprise",
                prefixIcon: Icon(
                  Icons.business,
                  size: 17,
                ),
                border: OutlineInputBorder(), 
                contentPadding: EdgeInsets.all(12), 
              ),
            ),
            SizedBox(height: 15),

            TextField(
              decoration: InputDecoration(
                labelText: "Adresse de l'entreprise",
                prefixIcon: Icon(
                  Icons.place,
                  size: 17,
                ),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(12),
                suffixIcon: ElevatedButton(
                  onPressed: () {
                    print("mon test ");
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Selectionner",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            const TextField(
              decoration: InputDecoration(
                labelText: "Adresse e-mail",
                prefixIcon: Icon(
                  FontAwesomeIcons.envelope,
                  size: 17,
                ),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(12),
              ),
            ),
            SizedBox(height: 15),

            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Numéro de téléphone",
                prefixIcon: Icon(
                  FontAwesomeIcons.phone,
                  size: 17,
                ),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(12),
              ),
            ),

            SizedBox(height: 15),

            InkWell(
              onTap: _getImage,
              child: _image == null
                  ? Container(
                      width: 150,
                      height: 150,
                      color: Colors.grey[300],
                      child: Icon(Icons.camera_alt, size: 50, color: Colors.grey[600]),
                    )
                  : Image.file(_image!, width: 150, height: 150, fit: BoxFit.cover),
            ),

            DropdownButton<String>(
              value: selectedOption,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.blue),
              underline: Container(
                height: 2,
                color: Colors.grey,
              ),
              onChanged: (newValue) {
                setState(() {
                  selectedOption = newValue!;
                });
              },
              items: dynamicOptions.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

            SizedBox(height: 30),

            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  // Ajoutez ici le code pour gérer le bouton "S'inscrire"
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  primary: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "S'inscrire",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
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
