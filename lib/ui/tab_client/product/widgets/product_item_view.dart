import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../data/models/products_data_model.dart';

class ProductItemView extends StatelessWidget {
  const ProductItemView({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.deepPurpleAccent,
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.file(
              File(productModel.productImages[0]),
              fit: BoxFit.fitWidth,
              height: 100,
              width: 140,
            ),
          ),
          Text(productModel.productName),
        ],
      ),
    );
  }
}
