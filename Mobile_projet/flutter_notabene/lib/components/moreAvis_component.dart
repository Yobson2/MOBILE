import 'package:flutter/material.dart';
import 'package:flutter_notabene/components/add_comm_sms.dart';
import 'package:flutter_notabene/main.dart';
import '../models/categories_model.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AvisModal extends StatelessWidget {
  final String? userName;
  final String? usercontenu;
   final String? entrepriseName;
    final String? heure;
    final String? date;
    final int? nbre_etoiles;
    final int? idPhoto;
    final int? idLoc;
  const AvisModal({super.key, this.userName,this.usercontenu,this.entrepriseName,this.date,this.nbre_etoiles,this.idPhoto,this.idLoc, this.heure});

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
              const Text(
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
                      radius: 30, // Ajuste la taille du cercle
                    ),
                    SizedBox(width: 10),
                    Text(
                      "${userName} ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18, // Ajuste la taille de la police
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  "${usercontenu}",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.date_range),
                    Text("${date}"),
                    Icon(Icons.access_time),
                    Text("${ heure}"),
                    Icon(Icons.star,color: Colors.yellow,),
                    Text("${nbre_etoiles}"),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.business),
                    Text(
                      "${entrepriseName}",
                      style: TextStyle(
                        fontSize: 18, 
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                CarouselSlider(
                  items: [
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1682686578601-e7851641d52c?auto=format&fit=crop&q=80&w=1470&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                     Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1698298836213-f721f3f40e0a?auto=format&fit=crop&q=80&w=1332&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    
                  ],
                  options: CarouselOptions(
                    height: 220,
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
          const Row(
  mainAxisAlignment: MainAxisAlignment.spaceAround,
  children: [
    Column(
      children: [
        Icon(Icons.map, size: 30), 
        Text(
          "Explorer",
          style: TextStyle(fontSize: 12), 
        ),
      ],
    ),
   
    Column(
      children: [
        Icon(Icons.shape_line, size: 30), 
        Text(
          "Partager",
          style: TextStyle(fontSize: 12), 
        ),
      ],
    ),
  ],
)

        ],
      ),
    );
  }
}


