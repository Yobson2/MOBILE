import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MyDetailsItems extends StatelessWidget {
  const MyDetailsItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
      child: Column(
        children: [
          DetailsHeader(),
          MyChangeInfos(),
          Infos1Description(),
          infos1Avis(),
          SizedBox(height: 20), 
        ],
      ),
    ),
    );

  }
}

class DetailsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 13.3 / 9,
              viewportFraction: 1,
              autoPlayAnimationDuration: Duration(milliseconds: 1000),
            ),
            items: [
              Image.asset('assets/images/pict2.jpg'),
              Image.asset('assets/images/pict2.jpg'),
              Image.asset('assets/images/pict2.jpg'),
            ],
          ),
          SizedBox(height: 18),
          Text(
            "Hotel 3 stars",
            style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Icon(Icons.star, color: Colors.yellow, size: 20),
              Icon(Icons.star, color: Colors.yellow, size: 20),
              Icon(Icons.star, color: Colors.yellow, size: 20),
              Icon(Icons.star, color: Colors.yellow, size: 20),
              Icon(Icons.star, color: Colors.yellow, size: 20),
              SizedBox(width: 10),
              Text(
                "(100) Avis",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
          
           
        ],
      ),
    );
  }
}


class MyChangeInfos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top:0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  labelColor: Colors.black,
                  tabs: [
                    Tab(text: "À savoir"),
                    Tab(text: "Carte",),
                  ],
                ),
                SizedBox(
                  height: 200,
                  child: MyTables(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class MyTables extends StatelessWidget {
  const MyTables({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        height: 300,
        color: Colors.amber,
        child: TabBarView(
          children: <Widget>[
            Center(
              child: Infos1Blocs(),
            ),
            Center(
              child: Infos2(),
            ),
          ],
        ),
      ),
    );
  }
}




//-------------------------MES INFORMATIONS---------------------------------------

class Infos2 extends StatelessWidget {
  const Infos2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.amber,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Ma carte")
            ]),])
    );
  }
}



//////Infos 1-------------------------------

class Infos1Blocs extends StatelessWidget {
  const Infos1Blocs({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
       children: [
        Infos1(),
       ],
    );
  }
}



class Infos1 extends StatelessWidget {
  const Infos1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         const Text(
            "Horaires",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 18),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.red, size: 20),
                    SizedBox(width: 6),
                    Text(
                      "Cocody, Abidjan",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 18),
          Container(
            // color: Colors.amber,
            margin: EdgeInsets.only(left: 10), 
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.open_in_new, color: Colors.yellow, size: 20),
                    SizedBox(width: 6),
                    Text(
                      "Ouvert à 20:00",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  
                  children: [
                    Icon(Icons.close_fullscreen, color: Colors.blue, size: 20),
                    SizedBox(width: 6),
                    Text(
                      "Fermé à 20:00",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Infos1Description extends StatelessWidget {
  const Infos1Description({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle("Description"),
          SizedBox(height: 10),
          _buildDescription(
            "Bienvenue sur notre plateforme d'informations. Cette section contient des détails essentiels que vous devez connaître pour naviguer au mieux dans notre application. Prenez le temps de lire ces informations attentivement afin de profiter pleinement de toutes les fonctionnalités que nous offrons.",
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildDescription(String description) {
    return Text(
      description,
      style: TextStyle(
        fontSize: 16,
      ),
    );
  }
}




class infos1Avis extends StatelessWidget {
  const infos1Avis({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      height: 200,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Notes  et avis',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Notes et avis validés par des utilisateurs ayant bénéficié du même service.',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10,top: 10.0),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AvisListes(),
                //  AvisListes(),
              ],
            ),
          ),
        ])
    );
  }
}

class AvisListes extends StatelessWidget {
  const AvisListes({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        const CircleAvatar(
          // backgroundImage: NetworkImage(avis["photoUrl"]),
          radius: 30,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "name surname",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "commentufbhuguhfuhbuhguhubhguhbuhguhuhuuubvhfuhughufhguhufhughurhfguhufhguhu",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Row(
            children: [
              Icon(Icons.star, color: Colors.yellow, size: 20),
              Icon(Icons.star, color: Colors.yellow, size: 20),
              Icon(Icons.star, color: Colors.yellow, size: 20),
              Icon(Icons.star, color: Colors.yellow, size: 20),
              Icon(Icons.star, color: Colors.yellow, size: 20),
            ],
          ),
                  SizedBox(width: 5),
                  Spacer(),
                  Text(
                    "time",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "date",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
