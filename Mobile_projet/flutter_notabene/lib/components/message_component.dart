import 'package:flutter/material.dart';

class SuccessModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0), 
      ),
      title: const Row(
        children: <Widget>[
          Icon(
            Icons.check_circle,
            color: Colors.green,
          ),
          SizedBox(width: 8.0),
          Text(
            'Succès',
            style: TextStyle(
              color: Colors.green,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      content: const Text(
        'Votre avis a été transmis avec succès.',
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
