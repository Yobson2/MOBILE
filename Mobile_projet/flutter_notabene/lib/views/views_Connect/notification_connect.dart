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
        return Padding(
          padding: EdgeInsets.all(8.0),
             child:Text("texte 1"),
              
        );
      case 1:
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("texte 2"),
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
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
              'Mes Notifications',
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





class ListesNotif extends StatefulWidget {
  @override
  ListesNotifState createState() => ListesNotifState();
}

class ListesNotifState extends State<ListesNotif> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Ici, vous pouvez trouver une liste complète de toutes les entreprises qui ont été commentées.',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}

class ListesNotifReponse extends StatefulWidget {
  @override
  ListesNotifReponseState createState() => ListesNotifReponseState();
}

class ListesNotifReponseState extends State<ListesNotif> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Ici, les entreprises qui ont été commentées.',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
