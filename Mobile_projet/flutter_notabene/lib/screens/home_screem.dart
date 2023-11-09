import 'package:flutter/material.dart';
import '../main.dart';
import '../views/home_notconnect.dart';
import '../views/views_Connect/home_connect.dart'; 

class HomeScreen extends StatelessWidget {
  
  const HomeScreen({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      body: ConnectedUserWidget(token: "",)
    );
  }
}