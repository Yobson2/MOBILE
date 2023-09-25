import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../services/connectEtat.dart';
import '../views/home_notconnect.dart';
import '../views/views_Connect/home_connect.dart'; 

class HomeScreen extends StatelessWidget {
  
  const HomeScreen({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = mainSession.userId!= 0;

    return Scaffold(
      appBar: AppBar(),
      body: isLoggedIn
          ? const ConnectedUserWidget(token: "",)
          : const NotConnectedUserWidget(),
    );
  }
}