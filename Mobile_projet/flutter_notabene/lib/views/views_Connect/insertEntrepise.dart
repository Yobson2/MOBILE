import 'package:flutter/material.dart';

import '../../screens/Inscrire/sign_entreprise.dart';
import 'listesEnt.dart';

class InsertCompagnyWidget extends StatefulWidget {
  final String? token;
  const InsertCompagnyWidget({this.token, Key? key}) : super(key: key);

  @override
  State<InsertCompagnyWidget> createState() => InsertCompagnyWidgetState();
}

class InsertCompagnyWidgetState extends State<InsertCompagnyWidget> {
  int _currentIndex = 0; // Initialize with a valid index



  Widget _buildMenu(int index) {
    switch (index) {
      case 0:
        return  Padding(
          padding: EdgeInsets.all(8.0),
            child: CompanyRegistrationSection(),
          
        );
      case 1:
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: ListesInsertCompagnyWidget(),
          ),
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PreferredSize(
          preferredSize: Size.fromHeight(50.0), 
          child: AppBar(
            backgroundColor: Colors.black12,
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.0), 
                bottomRight: Radius.circular(30.0),
              ),
            ),
            title: const Text(
              'Entreprises',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
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
