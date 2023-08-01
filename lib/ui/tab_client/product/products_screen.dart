
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:najot_shop/ui/tab_admin/product/subscreen/add_product.dart';
import 'package:provider/provider.dart';

import '../../../data/models/products_data_model.dart';
import '../../../providers/product_provider.dart';

class ProductScreenClient extends StatefulWidget {
  const ProductScreenClient({super.key});

  @override
  State<ProductScreenClient> createState() => _ProductScreenClientState();
}

class _ProductScreenClientState extends State<ProductScreenClient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Products"),
      ),
      body: StreamBuilder<List<ProductModel>>(
        stream: context.read<ProductsProvider>().getProducts(),
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
                    leading: Image.file(File(productModel.productImages[0])),
                    onLongPress: () {
                      context.read<ProductsProvider>().deleteProduct(
                        context: context,
                        productId: productModel.productId,
                      );
                    },
                    title: Text(productModel.productName),
                    subtitle: Text(productModel.description),
                  );
                },
              ),
            )
                : const Center(child: Text("Products Empty!"));
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