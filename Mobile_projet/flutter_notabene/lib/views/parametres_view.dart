import 'package:flutter/material.dart';
import 'package:flutter_notabene/views/views_Connect/home_connect.dart';
import 'package:flutter_notabene/views/views_Connect/insertEntrepise.dart';
import 'package:flutter_notabene/views/views_Connect/notification_connect.dart';
import 'package:flutter_notabene/views/views_Connect/profit_connect.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';
import '../screens/login_screen.dart';
import '../services/api_service.dart';

class ParamsView extends StatefulWidget {
  final bool? testConnexion;
  const ParamsView({Key? key,this.testConnexion}) : super(key: key);

  @override
  _ParamsViewState createState() => _ParamsViewState();
}

class _ParamsViewState extends State<ParamsView> {
  String selectedPhoto = ''; 
  int? userId;
  Map<String, dynamic> userData = {};
  bool isLoading = true;
   String imageUrl = "https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?w=740&t=st=1701674933~exp=1701675533~hmac=f0fa4c7c1274f6531895813218723638b6356b1f413ab8a0d1bf30381e07624b";

   @override
  void initState() {
    super.initState();
      // getInfosUserOk(mainSession.userId);
     
    }


 
 void _showExitConfirmationDialog(BuildContext context) {
  
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        title: const Text(
          "Déconnexion",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          "Êtes-vous sûr de vouloir vous déconnecter ?",
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.red, 
            ),
            child: const Text(
              "Annuler",
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop(); 
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.green, 
            ),
            child: const Text(
              "Quitter",
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            onPressed: () {
              mainSession.userId=0;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ConnectedUserWidget(),
                ),
              );
            },
          ),
        ],
      );
    },
  );
}


Future<void> getInfosUserOk(int? id) async {
  try {
    final myData = await ApiManager().fetchData("userById/$id","données récupérées","Erreur de récupération des données");
    final res = myData['users'];

    print(" mes données du paramtres $res");
    setState(() {
      userData = myData['users'];
      isLoading = false;
    });
  } catch (e) {
    isLoading = false;
    print("Erreur lors de la récupération des données utilisateur : $e");
  }
}


  @override
  Widget build(BuildContext context) {
     final isLoggedIn = mainSession.userId!= 0;

    return Scaffold(
       appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0), 
          child: AppBar(
             automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0), 
                bottomRight: Radius.circular(10.0),
              ),
            ),
            title:   Row(
          children: [
            Text(
                'NOTA',
                style: GoogleFonts.lilitaOne(
                   color: Colors.black,
                    fontSize: 17
                    )
              ),
              Text(
                'BENE',
                 style: GoogleFonts.lilitaOne(
                   color: Colors.yellow,
                    fontSize: 17
                    )
              ),
          ],
        ),
        actions: [
          isLoggedIn && imageUrl.isNotEmpty 
                ? Container(
                    padding: const EdgeInsets.all(2),
                    width: 50,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black12,
                        width: 2.0,
                      ),
                    ),
                    child: ClipOval(
                      child: Image(
                        image: NetworkImage(
                          imageUrl,
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginForm()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      width: 50,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.blue,
                      ),
                      child: Icon(
                        Icons.person_outline,
                        color: Colors.black,
                      ),
                    ),
                  )
          ],
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
      
      child: Container(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              width: 400,
              padding: EdgeInsets.all(20),
              child: Text(
                'Paramètres ',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 20.0),
            ListTile(
               contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              leading: const Icon(Icons.person_outline),
              title: const Text('Profil'),
              
              onTap: ()  {
                
                if(mainSession.userId!=0){
                   Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NoteUserWidget()),
                );
                
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Vous n'êtes pas connecté !"),
                    duration: Duration(seconds: 1),
                    backgroundColor: Colors.blue,
                  ),
                );
                return;
                }
                
              },
            ),
            const Divider(),
            ListTile(
               contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              leading: const Icon(Icons.notification_add),
              title: const Text('Notification'),
              onTap: () {
                if(mainSession.userId!=0){
                   Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotifUserWidget(),
                  ),
                );
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Vous n'êtes pas connecté !"),
                    duration: Duration(seconds: 1),
                    backgroundColor: Colors.blue,
                  ),
                );
                return;
                }
                
              },
            ),
            const Divider(),
            ListTile(
               contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              leading: const Icon(Icons.create),
              title: const Text('Mes Entreprises'),
              onTap: () {
                if(mainSession.userId!=0){
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InsertCompagnyWidget(),
                    ),
                  );
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Vous n'êtes pas connecté !"),
                    duration: Duration(seconds: 1),
                    backgroundColor: Colors.blue,
                  ),
                );
                return;
                }
                
              },
            ),
            const Divider(),
            ListTile(
               contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Quitter'),
              onTap: () {
                if(mainSession.userId!=0){
                 _showExitConfirmationDialog(context);
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Vous n'êtes pas connecté !"),
                    duration: Duration(seconds: 1),
                    backgroundColor: Colors.blue,
                  ),
                );
                return;
                }
                
              },
            ),
          ],
        ),
      ),
    ),
    );
  }
}
