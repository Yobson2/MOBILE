import 'package:flutter_application_1/models/category_model.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> categories = []; // Use the [] syntax for creating lists

  CategoryModel categoryModel = CategoryModel(); // Initialize the category model

  //1
  categoryModel.categorieName = "Business";
  categoryModel.imageUrl =
      "https://images.unsplash.com/photo-1664575600796-ffa828c5cb6e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80";

  categories.add(categoryModel); // Add the category model to the list

  // You can add more categories using the same approach

  return categories;
}
