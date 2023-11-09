import 'package:flutter/material.dart';

import '../screens/login_screen.dart';

class MessageConnexion extends StatelessWidget {
  const MessageConnexion({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error,
              color: Colors.white,
              size: 50, // Increased icon size for emphasis
            ),
            const SizedBox(height: 20),
            Text(
              "Vous n'êtes pas connecté !",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18, 
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
           
            const SizedBox(height: 30), 
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white, 
                onPrimary: Colors.blue, 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginForm()),
                );
              },
              child: const Text("Se connecter"),
            ),
          ],
        ),
      ),
    );
  }
}
