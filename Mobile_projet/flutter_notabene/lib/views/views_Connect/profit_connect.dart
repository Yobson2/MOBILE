import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:flutter_notabene/main.dart';
import 'package:flutter_notabene/views/views_Connect/editProfit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../../services/api_service.dart';

class NoteUserWidget extends StatefulWidget {
  final String? token;

  const NoteUserWidget({this.token, Key? key}) : super(key: key);

  @override
  State<NoteUserWidget> createState() => NoteUserWidgetState();
}

class NoteUserWidgetState extends State<NoteUserWidget> {
  late int id;
  File? _image;
  bool isLoading = true;
  int? userId;
   Map<String, dynamic> userData = {};
  String name = 'John Doe';
  String email = 'john.doe@example.com';
  String residence = 'Aucun';
  File? imageUrlProfil ;
  String imageUrl =
      "https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?w=740&t=st=1701674933~exp=1701675533~hmac=f0fa4c7c1274f6531895813218723638b6356b1f413ab8a0d1bf30381e07624b";
  
  List<String> selectedImageUrls = [];
  @override
  void initState() {
    super.initState();
    final id = mainSession.userId;
      setState(() {
        this.userId = id;
      }); 

      getInfosUser(userId);
     
    }


   Future<void> _getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        _image = File(image.path);
      }
    });
  }

  Future<void> getInfosUser(int? id) async {
    try {
      final myData = await ApiManager().fetchData("userById/$id","données récupérées","Erreur de récupération des données");
      setState(() {
          userData = myData['users']; 
           isLoading = false;
        });
    } catch (e) {
       isLoading = false;
       print("Erreur lors de la récupération des données utilisateur : $e");
    }
  }


Future<void> saveInfosUser(int? id) async {
 
 if ( _image == null ) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Veuillez remplir au moins un champs!!"),
                duration: Duration(seconds: 2),
              ),
            );
            return; 
           }
            var url = '${ApiManager().baseUrl}/user/$userId';

         try {
               var request = http.MultipartRequest('PUT', Uri.parse(url));
            if (_image != null) {
            var multipartFile = await http.MultipartFile.fromPath('image', _image!.path);
            request.files.add(multipartFile);
         }
  
        var response = await request.send();
        if (response.statusCode == 200) {
          Flushbar(
            title: 'Succès',
            message: 'Mise à jour  réussie',
            duration: Duration(seconds: 3),
          )..show(context);
          };
          setState(() {
            // mainSession.setPhoto(userData["photo_user"]);
            imageUrlProfil=userData["photo_user"];
          });
         } catch (e) {
            print("Erreur lors de l'envoi des données: $e");
         }           
}
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
          title: const Text(
            'Mon Profil',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child:isLoading 
                  ? Center(child: CircularProgressIndicator())
                  : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                  
                    print('Changer la photo');
                  },
                  child: _image!=null 
                   ? Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    elevation: 5,
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: FileImage(_image!),
                    ),
                  ):userData["photo_user"] != null && userData["photo_user"].isNotEmpty
                      ? Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          elevation: 5,
                          child: CircleAvatar(
                            radius: 70,
                            backgroundImage: NetworkImage("${ApiManager().baseUrlImage}/imageUser/${userData["photo_user"]}"),
                          ),
                        )
                      : Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          elevation: 5,
                          child: CircleAvatar(
                            radius: 70,
                            backgroundImage: NetworkImage(imageUrl),
                          ),
                        )
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      // Ajoutez ici la logique pour changer la photo
                      _getImage();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            buildListTile('Pseudo', userData["nom_utilisateur"], Icons.person),
            buildListTile('Email',userData["adresse_email"] , Icons.email),
            buildListTile('Lieu de residence', residence, Icons.location_city),
      SizedBox(height: 220),
            Padding(
  padding: const EdgeInsets.all(10.0),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            saveInfosUser(userId);
             setState(() {
          //  mainSession.setPhoto(userData["photo_user"]);
          imageUrlProfil= _image ;
          });
          },
          icon: const Icon(Icons.check, color: Colors.white),
          label: const Text(''),
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0), // Ajustez les paddings
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0), 
            ),
          ),
        ),
        const SizedBox(width: 80.0), 
        ElevatedButton.icon(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.close, color: Colors.white),
          label: const Text(''),
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0), 
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0), 
            ),
          ),
        ),
      ],
    ),
  ),
)

          ],
        ),
      ),
    );
  }

  ListTile buildListTile(String title, String value, IconData icon) {
    return ListTile(
      title: Row(
        children: [
          Icon(
            icon,
            color: Colors.blue,
          ),
          SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              _showEditDialog(title, value, icon);
            },
            child: Icon(
              Icons.edit,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showEditDialog(String title, String value, IconData icon) async {
    String editedValue = value;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(icon, color: Colors.blue),
              SizedBox(width: 10),
              Text('$title'),
            ],
          ),
          content: TextField(
            controller: TextEditingController(text: value),
            onChanged: (newValue) {
              editedValue = newValue;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              labelText: 'Nouvelle valeur',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                // Mettez en œuvre la logique de sauvegarde ici
                print('Nouvelle valeur pour $title : $editedValue');
                Navigator.of(context).pop();
                // Vous pouvez appeler une fonction de sauvegarde ici
              },
              child: Text('Enregistrer'),
            ),
          ],
        );
      },
    );
  }
}
