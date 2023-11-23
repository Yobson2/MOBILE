import 'package:flutter/material.dart';
import 'package:flutter_notabene/views/views_Connect/editProfit.dart';

class NoteUserWidget extends StatefulWidget {
  final String? token;

  const NoteUserWidget({this.token, Key? key}) : super(key: key);

  @override
  State<NoteUserWidget> createState() => NoteUserWidgetState();
}

class NoteUserWidgetState extends State<NoteUserWidget> {
  late int id;
  String name = 'John Doe';
  String email = 'john.doe@example.com';
  String residence = 'Yopougon';
  String imageUrl =
      "https://images.unsplash.com/photo-1695653420505-19343dd89ac1?auto=format&fit=crop&q=80&w=1470&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    // Ajoutez ici la logique pour changer la photo
                    print('Changer la photo');
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    elevation: 5,
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(imageUrl),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      // Ajoutez ici la logique pour changer la photo
                      print('Changer la photo');
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
            buildListTile('Pseudo', name, Icons.person),
            buildListTile('Email', email, Icons.email),
            buildListTile('Lieu de residence', residence, Icons.location_city),
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
