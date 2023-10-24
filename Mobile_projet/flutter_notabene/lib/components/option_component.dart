import 'package:flutter/material.dart';
import 'package:flutter_notabene/components/add_comm_sms.dart';
import '../models/categories_model.dart';

class CategoriesModal extends StatelessWidget {
  final Function(String)? onCategorySelected;

  CategoriesModal({this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 400,
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
      
      
        
        child: 
           GridView.builder(
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
              // if (onCategorySelected != null) {
              //   onCategorySelected!(category.title);
              //   Navigator.of(context).pop();
              //   // print('onCategorySelected');
              // }
               print('onCategorySelected ${category.title}');
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => CommentaireComponent(cartegieItem:category.title)),
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
                    style: TextStyle(
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
        
      );
  }
}
