import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import '../services/connectEtat.dart';

class CarteGloblale extends StatefulWidget {
  const CarteGloblale({Key? key}) : super(key: key);

  @override
  _CarteGloblaleState createState() => _CarteGloblaleState();
}

class _CarteGloblaleState extends State<CarteGloblale> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.getUserIdFromStorage(); 

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final userId = userProvider.userId;

    return Center(
      child: isLoading
          ? CircularProgressIndicator() 
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Carte Globale'),
                Text('ID de l\'utilisateur : $userId'),
              ],
            ), 
    );
  }
}
