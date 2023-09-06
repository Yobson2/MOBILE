import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/connectEtat.dart';
import '../views/home_notconnect.dart';
import '../views/views_Connect/home_connect.dart'; 

class HomeScreen extends StatelessWidget {
  
  const HomeScreen({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Récupérez la référence au UserProvider ici
    final userProvider = Provider.of<UserProvider>(context);
    final isLoggedIn = userProvider.userId != null;

    return Scaffold(
      appBar: AppBar(),
      body: isLoggedIn
          ? const ConnectedUserWidget(token: "",)
          : const NotConnectedUserWidget(),
    );
  }
}
