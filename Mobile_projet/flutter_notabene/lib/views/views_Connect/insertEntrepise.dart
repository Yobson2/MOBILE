import 'package:flutter/material.dart';

class InsertCompagnyWidget extends StatefulWidget {
  final String? token;
  const InsertCompagnyWidget({this.token, Key? key}) : super(key: key);

  @override
  State<InsertCompagnyWidget> createState() => InsertCompagnyWidgetState();
}

class InsertCompagnyWidgetState extends State<InsertCompagnyWidget> {
  int _currentIndex = 0;
  int _reponseCount = 5;

  Widget _buildMenu(int index) {
    switch (index) {
      case 0:
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              'Create a new compagny',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        );
      case 1:
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              'Dans cette section, vous trouverez les réponses fournies par les entreprises en réponse aux commentaires des utilisateurs.',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          'Entreprises',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: _buildMenu(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.create),
            label: 'Enregistrer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Listes',
          ),
        ],
      ),
    );
  }
}
