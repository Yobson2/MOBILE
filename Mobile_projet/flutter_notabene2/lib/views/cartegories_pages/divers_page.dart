
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class DiversPage extends StatelessWidget {
  const DiversPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.green,
        
        title: Text(
          "DIVERS",
          style: GoogleFonts.quicksand(
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        toolbarHeight: 80,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        decoration: BoxDecoration(
          // color: Color.fromARGB(255, 160, 152, 152),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
            // bottomLeft: Radius.circular(10.0),
            // bottomRight: Radius.circular(10.0),
          ),
        ),
        
        child: Padding(
          padding: const EdgeInsets.only(bottom: 0.0, top: 0.0, right: 10.0,left: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    MyItems(),
                    MyItems(),
                    MyItems(),
                    MyItems(),
                    MyItems(),
                    MyItems(),
                    MyItems(),
                    MyItems(),
                    MyItems(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class MyItems extends StatefulWidget {
  @override
  State<MyItems> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyItems> {
  @override
  Widget build(BuildContext context) {
    return Card(
       color: Colors.white,
      child: ListTile(
        leading: CircleAvatar(
          // backgroundImage: NetworkImage(''),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nom de l'endroit",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Icon(Icons.location_on, size: 14),
                SizedBox(width: 4),
                Text("Abidjan"),
              ],
            ),
          ],
        ),
        subtitle: Text("Informations sur l'endroit"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow, size: 12),
                    Icon(Icons.star, color: Colors.yellow, size: 12),
                    Icon(Icons.star, color: Colors.yellow, size: 12),
                    Icon(Icons.star, color: Colors.yellow, size: 12),
                    Icon(Icons.star, color: Colors.yellow, size: 12),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}




