import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:flutter_notabene/services/api_service.dart';
import 'package:flutter_notabene/views/carte_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../components/option2_component.dart';
import '../../main.dart';

class CompanyRegistrationSection extends StatefulWidget {
  @override
  _CompanyRegistrationSectionState createState() =>
      _CompanyRegistrationSectionState();
}

class _CompanyRegistrationSectionState
    extends State<CompanyRegistrationSection> {
  String selectedOption = '';
  String selectedCategory = '';
  File? _image;
  final TextEditingController textFieldController = TextEditingController();
  final TextEditingController addressFieldController = TextEditingController();
  final TextEditingController emailFieldController = TextEditingController();
  final TextEditingController phoneFieldController = TextEditingController();
    int? userId;
    List<dynamic> resultat=[];


@override
  void initState() {
    super.initState();
    final id = mainSession.userId;
      setState(() {
        this.userId = id;
      }); 
    }
  Future<void> _getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        _image = File(image.path);
      }
    });
  }
    
Future<void> EnregistrerCompagny(userId) async {
   if (
              textFieldController.text.isEmpty || addressFieldController.text.isEmpty 
             ) {
          //   // Show a SnackBar with a message
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(
          //       content: Text("Veuillez remplir tous les champs y compris le champ falcultatif s'il s'agit d'une entreprise."),
          //       duration: Duration(seconds: 2),
          //     ),
          //   );
          //   return; 
          print('mon test ok');
           }

  
  var url = '${ApiManager().baseUrl}/insertEntreprise/$userId';
    

 
  try {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['nom_entreprise'] = textFieldController.text;
    request.fields['adresse_entreprise'] = addressFieldController.text;
    request.fields['longitude_'] =  resultat[3].toString();
    request.fields['latitude_'] = resultat[2].toString();
    request.fields['categorie'] =  selectedOption.toString(); 

    if (_image != null) {
      var multipartFile = await http.MultipartFile.fromPath('image', _image!.path);
      request.files.add(multipartFile);
    }
  
    var response = await request.send();

    if (response.statusCode == 200) {
      Flushbar(
        title: 'Succès',
        message: 'Inscription d\'entreprise réussie',
        duration: Duration(seconds: 3),
      )..show(context);
      
      setState(() {
        textFieldController.clear();
       addressFieldController.clear();
        selectedOption = '';
         _image= null;
         resultat=[];
      });

    }
  } catch (e) {
    print("Erreur lors de l'envoi des données: $e");
  }
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
              "Remplissez les informations de votre entreprise ",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            
            SizedBox(height: 15),

            TextField(
              controller: addressFieldController,
              decoration: InputDecoration(
                labelText: "Adresse de l'entreprise",
                prefixIcon: Icon(
                  Icons.place,
                  size: 17,
                ),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(12),
                suffixIcon: ElevatedButton(
                  onPressed: () async {
                     resultat = await Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const MapSample(testPrint:false)),
                                  );

                           setState(() {
                                  addressFieldController.text=resultat[1].toString();
                                });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child:  Text(
                    "Selectionner",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

             TextField(
              controller: textFieldController,
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

      SizedBox(height: 10),
           if (selectedOption!="")
          Text(
            "Catégorie sélectionnée : $selectedOption",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
           SizedBox(height: 10),
           ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CategoriesModal2(
                    onCategorySelected: (selectedCategory) {
                      setState(() {
                        selectedOption = selectedCategory;
                      });
                    },
                  );
                },
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.blue, 
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), 
              ),
            ),
            child: const Text(
              "Associer une catégorie",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
         

            SizedBox(height: 30),

            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                 EnregistrerCompagny(userId);

                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  primary: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
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
