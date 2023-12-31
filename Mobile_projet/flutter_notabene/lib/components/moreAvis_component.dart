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
  final String? userPhoto;

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
    this.userPhoto
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
 bool isLoading = true;


List<dynamic> mes =  [
        "images_1699622503290_Screenshot_20231109-144408.jpg",
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
        isLoading = false;
      });
    } catch (e) {
       print("Erreur : Les photos n'ont pas été recuperer $e");
    }
  }
  @override
  Widget build(BuildContext context) {
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
                    widget.userPhoto!=null ?
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          "${ApiManager().baseUrlImage}/imageUser/${widget.userPhoto}"),
                      radius: 30, 
                    ):const CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?w=740&t=st=1701674933~exp=1701675533~hmac=f0fa4c7c1274f6531895813218723638b6356b1f413ab8a0d1bf30381e07624b"),
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
                 isLoading 
                ? Center(child: CircularProgressIndicator())
                :
                CarouselSlider(
                  items: mesDonnees.map((donnees) {
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
                          "${ApiManager().baseUrlImage}/images/$donnees",
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
                    MaterialPageRoute(builder: (context) => MapSample(longLoc:logitude,latLoc:latitude,testPrint: printBtn,testPrint2:false, nomBoite:widget.entrepriseName)),
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

 




