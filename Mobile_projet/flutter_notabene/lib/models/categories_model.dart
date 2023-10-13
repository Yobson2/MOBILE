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
      title: "BANQUE",
      idCategory: 1,
    ),
    Category(
      icon: Icons.read_more,
      color: Color(0xFFD32F2F),
      title: "RESTAURANT",
      idCategory: 2,
    ),

    Category(
      icon: Icons.hotel_class,
      color: Color(0xFF757575),
      title: "HOTEL",
      idCategory: 3,
    ),
    Category(
      icon: Icons.shopping_basket,
      color: Color(0xFFF57C00),
      title: "SUPERMARCHE",
      idCategory: 4,
    ),
    Category(
      icon: Icons.diversity_2,
      color: Color(0xFF4CAF50),
      title: "DIVERS",
      idCategory: 5,
    ),
  ];
}
