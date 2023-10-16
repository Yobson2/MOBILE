import 'package:flutter/material.dart';
class CategoriesModal extends StatelessWidget {
  final List<String> categories;
  final Function(String)? onCategorySelected;

  CategoriesModal({required this.categories, this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              if (onCategorySelected != null) {
                onCategorySelected!(categories[index]);
                Navigator.of(context).pop(); // Fermez le modal après la sélection
              }
            },
            child: Container(
              color: Colors.blue,
              child: Center(
                child: Text(
                  categories[index],
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
