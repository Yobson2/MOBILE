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
            CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage("https://images.unsplash.com/photo-1695653420505-19343dd89ac1?auto=format&fit=crop&q=80&w=1470&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"), 
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text(
                'Pseudo',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                name,
                style: TextStyle(fontSize: 16),
              ),
            ),
            ListTile(
              title: Text(
                'Email',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                email,
                style: TextStyle(fontSize: 16),
              ),
            ),
             ListTile(
              title: Text(
                'Lieu de residence',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Yopougon",
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditUserWidget()),
              );
              },
              child: Text('Modifier Profil'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
