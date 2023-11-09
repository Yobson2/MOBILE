import 'package:flutter/material.dart';
import 'package:flutter_notabene/screens/login_screen.dart';

class CarouselItem extends StatelessWidget {
  final String title;
  final String description;
  final Color color;
  final IconData icon;

  CarouselItem({
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 350,
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0.0, 1.0),
            blurRadius: 6.0,
          ),
        ],
      ),
       child: SingleChildScrollView(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 60,
            color: Colors.white,
          ),
          SizedBox(height: 3),
          Text(
            title,
            style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.white),
            ),
          ),
          SizedBox(height: 2),
          ElevatedButton(
            onPressed: () {
             Navigator.push(
                             context,
                            MaterialPageRoute(builder: (context) => const LoginForm()),
                          );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'En savoir plus',
              style: TextStyle(color: color,fontSize: 10),
              
            ),
          ),
        ],
      ),
       ),
      
    );
  }
}
