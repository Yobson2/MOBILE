import 'package:flutter/material.dart';
import 'package:flutter_notabene/services/api_service.dart';

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
                final avis = myItemsData[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                             '${avis["nom_utilisateur"] ?? "Unknown User"}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
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
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 18,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  ' etoiles',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "avis",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
