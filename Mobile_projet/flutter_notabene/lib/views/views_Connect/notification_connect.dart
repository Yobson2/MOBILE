import 'package:flutter/material.dart';

class NotifUserWidget extends StatefulWidget {
  final String? token;
  const NotifUserWidget({this.token, Key? key}) : super(key: key);

  @override
  State<NotifUserWidget> createState() => NotifUserWidgetState();
}

class NotifUserWidgetState extends State<NotifUserWidget> {
  int _currentIndex = 0;
  int _reponseCount = 5;

  Widget _buildMenu(int index) {
    switch (index) {
      case 0:
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              'Ici, vous pouvez trouver une liste complète de toutes les entreprises qui ont été commentées.',
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
          'Mes Notifications',
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
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Listes Avis',
          ),
           BottomNavigationBarItem(
            icon: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Icon(Icons.menu),
                Positioned(
                  right: 0,
                  top: 0,
                  child: _reponseCount > 0
                      ? CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.red,
                          child: Text(
                            _reponseCount.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        )
                      : Container(),
                ),
              ],
            ),
            label: 'Réponses',
          ),
        ],
      ),
    );
  }
}
