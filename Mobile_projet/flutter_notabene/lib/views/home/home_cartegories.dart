import 'package:flutter/material.dart';
import '../../models/categories_model.dart';
import '../items/listes_sections.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({Key? key}) : super(key: key);

  void navigateToCategory(BuildContext context, int idCarte, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListesBlocItems(id: idCarte, title: title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                     
                    },
                    icon: const Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 25),
                itemCount: CategoriesData.categories.length,
                itemBuilder: (context, index) {
                 
                  final category = CategoriesData.categories[index];
                  return GestureDetector(
                    onTap: () {
                      navigateToCategory(context, category.idCategory, category.title);
                    },
                    
                    child: Column(
                      
                      children: [
                       
                        Hero(
                          tag: 'category_${category.idCategory}',
                           
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            margin: EdgeInsets.only(right: 6.0, left: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: category.color,
                            ),
                            child: Icon(
                              category.icon,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                       Flexible(
                        child:  Text(
                          category.title,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black.withOpacity(0.7),
                            fontWeight: FontWeight.bold,
                          ),
                        )
                        
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
