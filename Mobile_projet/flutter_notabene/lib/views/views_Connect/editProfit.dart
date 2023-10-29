import 'package:flutter/material.dart';

class EditUserWidget extends StatefulWidget {
  final String? token;
  const EditUserWidget({this.token, Key? key}) : super(key: key);

  @override
  State<EditUserWidget> createState() => EditUserWidgetState();
}

class EditUserWidgetState extends State<EditUserWidget> {
  TextEditingController nameController = TextEditingController(text: 'John Doe');
  TextEditingController emailController = TextEditingController(text: 'john.doe@example.com');
  TextEditingController commonController = TextEditingController();

  // Variable pour stocker la photo récupérée
  String? selectedPhoto;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          'Modifier Profit',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
        padding: EdgeInsets.all(20),
        
        child: Column(
          children: [
            Container(
              width: 100, 
              height: 100, 
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.teal), 
                borderRadius: BorderRadius.circular(50), 
              ),
              child: selectedPhoto != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(selectedPhoto!), 
                    )
                  : Icon(Icons.person, size: 50, color: Colors.teal),
            ),

            ElevatedButton(
              onPressed: () {
                
                setState(() {
                  selectedPhoto = 'https://example.com/path-to-photo.jpg'; 
                });
              },
              child: Icon(Icons.add_a_photo), 
            ),

            SizedBox(height: 16),

            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Nom',
                border: OutlineInputBorder(),
                icon: Icon(Icons.person),
              ),
            ),

            SizedBox(height: 16),

            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                icon: Icon(Icons.email),
              ),
            ),

            SizedBox(height: 16),

            TextFormField(
              controller: commonController,
              decoration: InputDecoration(
                labelText: 'Champ Commun',
                border: OutlineInputBorder(),
                icon: Icon(Icons.info),
              ),
            ),

            SizedBox(height: 16),

          ElevatedButton(
            onPressed: () {
             
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.teal, 
              textStyle: TextStyle(color: Colors.white, fontSize: 18),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), 
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), 
              elevation: 5, 
            ),
            child: Text('Enregistrer'),
          ),

          ],
        ),
      ),
      ),
    );
  }
}
