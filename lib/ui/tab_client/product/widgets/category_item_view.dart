import 'package:flutter/material.dart';

import '../../../../data/models/category_model.dart';


class CategoryItemView extends StatelessWidget {
  const CategoryItemView({super.key, required this.categoryModel, required this.onTap, required this.selectedId});

  final CategoryModel categoryModel;
  final VoidCallback onTap;
  final String selectedId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: selectedId ==
              categoryModel.categoryId
              ? Colors.deepPurpleAccent
              : Colors.deepPurple,
        ),
        height: 50,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Text(
            categoryModel.categoryName,
            style: const TextStyle(
              color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}
