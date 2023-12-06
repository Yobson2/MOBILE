import 'package:flutter/material.dart';
import 'package:flutter_notabene/main.dart';
import 'package:flutter_notabene/services/api_service.dart';

import '../../components/moreAvis_component.dart';
import '../items/details_items.dart';

class MyComment extends StatefulWidget {
  @override
  _MyCommentState createState() => _MyCommentState();
}

class _MyCommentState extends State<MyComment> {
  List<dynamic> myItemsData = [];
 

  @override
  void initState() {
    super.initState();
   getDataAvis();
  }

 Future<void> getDataAvis() async {
  try {
    final reponse = await ApiManager().fetchData("getAllCommentaire", "message", "messageError");
    if (reponse != null && reponse.containsKey('data')) {
      final res = reponse['data'];
      
      setState(() {
        myItemsData = List<dynamic>.from(res);
       


      });
    } else {
      print("Erreur: Réponse de l'API invalide");
    }
  } catch (e) {
    print("Erreur : Les avis récents n'ont pas été récupérés $e");
  }
}


  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Évaluations récentes',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                if (myItemsData.isEmpty || index >= myItemsData.length) {
                return const Center();
              }
                final avis = myItemsData[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      avis["photo_user"]!=null ?
                       CircleAvatar(
                        backgroundImage: NetworkImage("${ApiManager().baseUrlImage}/imageUser/${avis["photo_user"]}"),
                        radius: 30,
                      ): const CircleAvatar(
                        backgroundImage: NetworkImage("https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?w=740&t=st=1701674933~exp=1701675533~hmac=f0fa4c7c1274f6531895813218723638b6356b1f413ab8a0d1bf30381e07624b"),
                        radius: 30,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                              width: 120,
                              child:Text(
                             '${avis["nom_utilisateur"]} ',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                              ),
                                const Spacer(flex: 15,),
            InkWell(
              onTap: () {
                final userName= avis['nom_utilisateur'];
                 final userPhoto= avis['photo_user'];
                final usercontenu= avis['contenu_commentaire'];
                final entrepriseName = avis['entreprise'] != null ? avis['entreprise']['nom_entreprise'] : 'null';
                final idLoc= avis['entreprise'] != null ? avis['entreprise']['id_Localisation']:  avis['id_localisation'];
                final heure=avis['heure'];
                final date=avis['date_commentaire'];
                final nbre_etoiles=avis['nombre_etoiles'];
              
              
                  showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return  AvisModal(userName:userName,usercontenu:usercontenu,entrepriseName:entrepriseName,heure:heure,date:date,nbre_etoiles:nbre_etoiles, idPhoto:avis['id_photo'],idLoc: idLoc,userPhoto:userPhoto);
                  },
                );  
                          },
                          child: const Column(
                            children: [
                              Icon(Icons.more_horiz, color: Colors.grey,),
                            ]),
                        ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Text(
                              "${avis["contenu_commentaire"] }",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 5),
                             Row(
                              children: [
                                for (int i = 0; i < (avis['nombre_etoiles'] ?? 0); i++)
                                    Icon(Icons.star, color: Colors.yellow, size: 12),
                              ],
                            ),
                            Row(
                              children: [

                                Spacer(),
                                 Row(
              
                                children: [
                                  Text(
                                    "${avis['heure']}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                  avis['date_commentaire'] ,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),     
                                ],
                              ),
                                            ],
                            ),
                          ],
                        ),
                        
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
