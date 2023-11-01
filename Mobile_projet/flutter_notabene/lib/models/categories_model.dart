import 'package:flutter/material.dart';

class Category {
  final IconData icon;
  final Color color;
  final String title;
  final int idCategory;

  Category({
    required this.icon,
    required this.color,
    required this.title,
    required this.idCategory,
  });
}

class CategoriesData {
  static final List<Category> categories = [
    Category(
      icon: Icons.security,
      color: Color(0xFF1E3C72),
      title: "Banque",
      idCategory: 1,
    ),
    Category(
      icon: Icons.read_more,
      color: Color(0xFFD32F2F),
      title: "Restaurant",
      idCategory: 2,
    ),

    Category(
      icon: Icons.hotel_class,
      color: Color(0xFF757575),
      title: "Hotel",
      idCategory: 3,
    ),
    Category(
      icon: Icons.shopping_basket,
      color: Color(0xFFF57C00),
      title: "Supermarché",
      idCategory: 4,
    ),
    Category(
      icon: Icons.diversity_2,
      color: Color(0xFF4CAF50),
      title: "Divers",
      idCategory: 6,
    ),
     Category(
      icon: Icons.local_pharmacy,
      color: Color(0xFF1E3C72),
      title: "Pharmacie",
      idCategory: 7,
    ),
     Category(
      icon: Icons.book,
      color:  Color(0xFFD32F2F),
      title: "Librairie",
      idCategory: 8,
    ),
     Category(
      icon: Icons.face,
      color: Color(0xFF757575),
      title: "Salon",
      idCategory: 9,
    ),
     
     Category(
      icon: Icons.museum,
      color: Color(0xFFF57C00),
      title: "Musée",
      idCategory: 10,
    ),
    Category(
      icon: Icons.local_gas_station,
      color: Color(0xFF4CAF50),
      title: "Station",
      idCategory: 11,
    ),
     Category(
      icon: Icons.local_pizza,
      color: Color(0xFF1E3C72),
      title: "Boulangerie",
      idCategory: 12,
    ),
     Category(
      icon: Icons.school,
      color: Color(0xFFD32F2F),
      title: "Université",
      idCategory: 13,
    ),
     Category(
      icon: Icons.local_hospital,
      color: Color(0xFF757575),
      title: "Hopital",
      idCategory: 14,
    ),
     Category(
      icon: Icons.shopping_cart,
      color: Color(0xFF4CAF50),
      title: "Marché",
      idCategory: 15,
    ),
    Category(
      icon: Icons.local_movies,
      color: Color(0xFF1E3C72),
      title: "Cinéma",
      idCategory: 15,
    )
  ];
}
