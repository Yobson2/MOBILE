import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  // final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('YOYO'),
            Text(
              'CRUD',
              style: TextStyle(
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        elevation: 0.0,
      ),
      body: FormUser(),
    );
  }
}

class FormUser extends StatelessWidget {

  late String etudiantNom,etudiantId,etudiantProgrammeId;
  late double etudiantGpa;

   getStudentName(String nom) {
    this.etudiantNom =nom;
    
   }
    void getEtudiantId(String id) {
      this.etudiantId =id;
    }
  
    void getStudentGpa(String gpa) {
      this.etudiantGpa =double.parse(gpa);
    }
  
   void getProgrammeId(String programmeId) {
    this.etudiantProgrammeId =programmeId;
   }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom:8.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: 'Nom',
                  fillColor: Colors.white,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                ),
                onChanged: (String nom){
                  getStudentName(nom);
                },
              ),
            ],
          ),
        ),
        Padding(
           padding: EdgeInsets.only(bottom:8.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: 'Etudiant ID',
                  fillColor: Colors.white,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                ),
                onChanged: (String id){
                  getEtudiantId(id);
                },
              ),
            ],
          ),
        ),
        Padding(
           padding: EdgeInsets.only(bottom:8.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: 'Programme ID',
                  fillColor: Colors.white,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                ),
                onChanged: (String programmeId){
                  getProgrammeId(programmeId);
                },
              ),
            ],
          ),
        ),
        Padding(
           padding: EdgeInsets.only(bottom:8.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  labelText: 'GPA',
                  fillColor: Colors.white,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                ),
                onChanged: (String gpa){
                  getStudentGpa(gpa);
                },
              ),
            ],
          ),
        ),
        
       BtnAction(),
      ],
      
    );
  }
}





class BtnAction extends StatelessWidget {
  // const BtnAction({super.key});

  get etudiantNom => null;
  
  get etudiantId => null;
  
  get etudiantGpa => null;
  
  get etudiantProgrammeId => null;
  

  void createData(String nom) async {
    print("Creating");
    DocumentReference documentReference = FirebaseFirestore.instance.collection("Etudiants").doc(); // Utilisation de .doc() pour générer un ID automatique
    Map<String, dynamic> data = {
      "Nom": etudiantNom,
      "EtudiantID": etudiantId,
      "cpa": etudiantGpa ,
      "ProgrammeID": etudiantProgrammeId,
      // Ajoutez d'autres champs ici
    };

      print(data);
    await documentReference.set(data);
  }

  void readData() {
    print("Reading");
  }

  void deleteData() {
    print("Deleting");
  }

  void updateData() {
    print("Updating");
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: () {
            createData("Nom de l'étudiant"); // Remplacez "Nom de l'étudiant" par le nom approprié
          },
          child: Text("Créer"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: () {
            readData();
          },
          child: Text("Lire"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.orange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: () {
            updateData();
          },
          child: Text("Mise à jour"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: () {
            deleteData();
          },
          child: Text("Supprimer"),
        ),
      ],
    );
  }
}

class CategoryTitle extends StatelessWidget {

 final imageUrl, categorieName;
 CategoryTitle({this.imageUrl, this.categorieName});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          // Image.network(imageUrl, width: 120,height: 60,)
        ],
      ),
    );
  }
}
