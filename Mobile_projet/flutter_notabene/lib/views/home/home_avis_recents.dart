import 'package:flutter/material.dart';



class MyComment extends StatelessWidget {
  final List<Map<String, dynamic>> avisRecents = [
 
    {
      "name": 'John',
      "surname": 'Doe',
      "photoUrl": 'https://images.unsplash.com/photo-1692116716561-953cc9a868b6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1374&q=80',
      "time": '12/12/2021',
      "starCount": 4,
      "comment": 'Great experience! Highly recommended.',
    },
    {
      "name": 'John',
      "surname": 'Doe',
      "photoUrl": '',
       "time": '12/12/2021',
      "starCount": 4,
      "comment": 'Great experience! Highly recommended.',
    },
    {
      "name": 'John',
      "surname": 'Doe',
      "photoUrl": '',
       "time": '12/12/2021',
      "starCount": 4,
      "comment": 'Great experience! Highly recommended.',
    },
    {
      "name": 'John',
      "surname": 'Doe',
      "photoUrl": '',
        "time": '12/12/2021',
      "starCount": 4,
      "comment": 'Great experience! Highly recommended.',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Évaluations récentes',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Expanded( // Wrap the ListView.builder with Expanded
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: avisRecents.length,
              itemBuilder: (context, index) {
                final avis = avisRecents[index];
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
                              '${avis["name"]} ${avis["surname"]}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              avis["comment"],
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
                                  '${avis["starCount"]} etoiles',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  avis["time"],
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
