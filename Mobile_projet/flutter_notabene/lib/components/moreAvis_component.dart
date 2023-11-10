import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_notabene/components/add_comm_sms.dart';
import 'package:flutter_notabene/main.dart';
import 'package:flutter_notabene/services/api_service.dart';
import '../models/categories_model.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../views/carte_view.dart';

class AvisModal extends StatefulWidget {
  final String? userName;
  final String? usercontenu;
  final String? entrepriseName;
  final String? heure;
  final String? date;
  final int? nbre_etoiles;
  final int? idPhoto;
  final int? idLoc;

  AvisModal({
    Key? key,
    this.userName,
    this.usercontenu,
    this.entrepriseName,
    this.date,
    this.nbre_etoiles,
    this.idPhoto,
    this.idLoc,
    this.heure,
  }) : super(key: key);

  @override
  AvisModalState createState() => AvisModalState();
}

class AvisModalState extends State<AvisModal> {
 List<dynamic> mesDonnees = [];
 List<dynamic> mesDonneesLoc = [];
 late double logitude = 0.0;
 late double latitude = 0.0;
 bool printBtn = true;


List<dynamic> mes =  [
        "image_1699272031168_Screenshot_20231105-230746_LinkedIn.jpg",
        "image_1699538601942_FB_IMG_1699482790112.jpg",
        "images_1698867078268_FB_IMG_1698850505798.jpg",
        "images_1698920687807_CAP9022900798735588594.jpg"
    ];
  @override
  void initState() {
   
    super.initState();
     printBtn = true;
    getPhotoData();
    getPhotoDataLocalisation();
  }


  Future<void> getPhotoData() async {
    try {
      final reponse= await ApiManager().fetchData("getAllPhoto/${widget.idPhoto}", "message of photo", "messageError");
     
      final res=reponse['allPhotos'];
      setState(() {
         mesDonnees = List<dynamic>.from(res);
      });
    } catch (e) {
       print("Erreur : Les photos n'ont pas été recuperer $e");
    }
  }
  Future<void> getPhotoDataLocalisation() async {
    try {
      final reponse= await ApiManager().fetchData("getAllLocalisation/${widget.idLoc}", "message of photo", "messageError");
     
      final res=reponse['AllLocalisations'];
     
      setState(() {
        logitude=res["longitude"];
        latitude=res["latitude"];
      });
    } catch (e) {
       print("Erreur : Les photos n'ont pas été recuperer $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    print("mes données $mes");
     print("mes données 2 $mesDonnees");
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),
              SizedBox(width: 16),
               Text(
                "Vue détaillée ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://plus.unsplash.com/premium_photo-1664870883044-0d82e3d63d99?auto=format&fit=crop&q=80&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=1470'),
                      radius: 30, 
                    ),
                    SizedBox(width: 10),
                    Text(
                      "${widget.userName} ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18, 
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  "${widget.usercontenu}",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.date_range),
                    Text("${widget.date}"),
                    Icon(Icons.access_time),
                    Text("${ widget.heure}"),
                    Icon(Icons.star,color: Colors.yellow,),
                    Text("${widget.nbre_etoiles}"),
                  ],
                ),
                SizedBox(height: 16),
               
               Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 if (widget.entrepriseName!="null") 
                  Icon(Icons.business),
                if (widget.entrepriseName!="null") 
                Text(
                  "${widget.entrepriseName}",
                  style: TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

      
                SizedBox(height: 16),
                CarouselSlider(
                  items: mes.map((donnees) {
                    return Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Card(
                        color: Colors.grey[200],
                        child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child:Image.network(
                          "http://192.168.1.8:8082/images/${donnees}",
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            print("Error loading image: $error");
                            return Center(child: Text("Erreur lors du chargement de l'image"));
                          },
                        ),

                      ) ,)
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 300,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    enableInfiniteScroll: true,
                    pauseAutoPlayOnTouch: true,
                  ),
                ),

              ],
            ),
          ),
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
    
           GestureDetector(
            
                onTap: () {
                  setState(() {
                    printBtn = false;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MapSample(longLoc:logitude,latLoc:latitude,testPrint: printBtn)),
                  );
                },
                child: const Column(
                  children: [
                    Icon(Icons.map, size: 30), 
                    Text(
                      "Explorer",
                      style: TextStyle(fontSize: 12), 
                    ),
                  ],
                ),
              ),

          GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => SecondPage()),
                  // );
                },
                child: Column(
                  children: [
                    Icon(Icons.shape_line, size: 30), 
                    Text(
                      "Partager",
                      style: TextStyle(fontSize: 12), 
                    ),
                  ],
                ),
              ),
        ],


      )

        ],
      ),
    );
  }
}

 




