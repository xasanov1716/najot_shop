
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:najot_shop/ui/tab_admin/product/subscreen/add_product.dart';
import 'package:provider/provider.dart';

import '../../../data/models/products_data_model.dart';
import '../../../providers/product_provider.dart';

class ProductScreenAdmin extends StatefulWidget {
  const ProductScreenAdmin({super.key});

  @override
  State<ProductScreenAdmin> createState() => _ProductScreenAdminState();
}

class _ProductScreenAdminState extends State<ProductScreenAdmin> {
  String categoryId ="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products Admin"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ProductAddScreen();
                  },
                ),
              );
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: StreamBuilder<List<ProductModel>>(
        stream: context.read<ProductsProvider>().getProducts(categoryId),
        builder:
            (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.isNotEmpty
                ? ListView(
              children: List.generate(
                snapshot.data!.length,
                    (index) {
                  ProductModel productModel = snapshot.data![index];
                  return ListTile(
                    leading: Image.network(productModel.productImages[0]),
                    onLongPress: () {
                      context.read<ProductsProvider>().deleteProduct(
                        context: context,
                        productId: productModel.productId,
                      );
                    },
                    title: Text(productModel.productName),
                    subtitle: Text(productModel.description),
                    // trailing: IconButton(
                    //   onPressed: () {},
                    //   icon: const Icon(Icons.edit),
                    // ),
                  );
                },
              ),
            )
                : const Center(child: Text("Product Empty!"));
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}