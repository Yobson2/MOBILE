import 'package:flutter/material.dart';
import 'package:flutter_notabene/components/add_comm_sms.dart';
import 'package:flutter_notabene/main.dart';
import '../models/categories_model.dart';

class CategoriesModal extends StatelessWidget {

  const CategoriesModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16.0),
      
          child:Column(
            children: [
              const Text("Sélectionnez une catégorie",
            style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
          
          ) ,
           const SizedBox(height: 16),
           Expanded(
              child:  GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 6.0,
        ),
        itemCount: CategoriesData.categories.length,
        itemBuilder: (BuildContext context, int index) {
          final category = CategoriesData.categories[index];
          return GestureDetector(
            onTap: () {
              mainSession.setCategorie(category.title);
             
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const CommentaireComponent()),
              );
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: category.color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    category.icon,
                    color: Colors.white,
                    size: 38.0,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category.title,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  
                ],
              ),
            ),
          );
        },
      ),
              ),
             GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 30,
              ),
            ),
          )

            ],)
          
        
      );
  }
}
