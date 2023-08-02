//
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:najot_shop/ui/tab_admin/product/subscreen/add_product.dart';
// import 'package:provider/provider.dart';
//
// import '../../../data/models/products_data_model.dart';
// import '../../../providers/product_provider.dart';
//
// class ProductScreenClient extends StatefulWidget {
//   const ProductScreenClient({super.key});
//
//   @override
//   State<ProductScreenClient> createState() => _ProductScreenClientState();
// }
//
// class _ProductScreenClientState extends State<ProductScreenClient> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("All Products"),
//       ),
//       body: StreamBuilder<List<ProductModel>>(
//         stream: context.read<ProductsProvider>().getProducts(),
//         builder:
//             (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
//           if (snapshot.hasData) {
//             return snapshot.data!.isNotEmpty
//                 ? ListView(
//               children: List.generate(
//                 snapshot.data!.length,
//                     (index) {
//                   ProductModel productModel = snapshot.data![index];
//                   return ListTile(
//                     leading: Image.file(File(productModel.productImages[0])),
//                     onLongPress: () {
//                       context.read<ProductsProvider>().deleteProduct(
//                         context: context,
//                         productId: productModel.productId,
//                       );
//                     },
//                     title: Text(productModel.productName),
//                     subtitle: Text(productModel.description),
//                   );
//                 },
//               ),
//             )
//                 : const Center(child: Text("Products Empty!"));
//           }
//           if (snapshot.hasError) {
//             return Center(
//               child: Text(snapshot.error.toString()),
//             );
//           }
//           return const Center(child: CircularProgressIndicator());
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:najot_shop/ui/tab_client/product/widgets/category_item_view.dart';
import 'package:najot_shop/ui/tab_client/product/widgets/product_item_view.dart';
import 'package:provider/provider.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/products_data_model.dart';
import '../../../providers/category_provider.dart';
import '../../../providers/product_provider.dart';
import '../../tab_admin/widget/product_shimmer.dart';

class ProductScreenClient extends StatefulWidget {
  const ProductScreenClient({super.key});

  @override
  State<ProductScreenClient> createState() => _ProductScreenClientState();
}

class _ProductScreenClientState extends State<ProductScreenClient> {
  String selectedCategoryId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products Client"),
      ),
      body: Column(
        children: [
          StreamBuilder<List<CategoryModel>>(
            stream: context.read<CategoryProvider>().getCategories(),
            builder: (BuildContext context,
                AsyncSnapshot<List<CategoryModel>> snapshot) {
              if (snapshot.hasData) {
                return snapshot.data!.isNotEmpty
                    ? SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            CategoryItemView(
                              categoryModel: CategoryModel(
                                categoryId: "",
                                description: "",
                                categoryName: "All",
                                imageUrl: "",
                                createdAt: "",
                              ),
                              onTap: () {
                                setState(() {
                                  selectedCategoryId = "";
                                });
                              },
                              selectedId: selectedCategoryId,
                            ),
                            ...List.generate(
                              snapshot.data!.length,
                              (index) {
                                CategoryModel categoryModel =
                                    snapshot.data![index];
                                return CategoryItemView(
                                  categoryModel: categoryModel,
                                  onTap: () {
                                    setState(() {
                                      selectedCategoryId =
                                          categoryModel.categoryId;
                                    });
                                  },
                                  selectedId: selectedCategoryId,
                                );
                              },
                            )
                          ],
                        ),
                      )
                    : const Center(child: Text("Empty!"));
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              return const Center(child: LoadData());
            },
          ),
          StreamBuilder<List<ProductModel>>(
            stream: context
                .read<ProductsProvider>()
                .getProducts(selectedCategoryId),
            builder: (BuildContext context,
                AsyncSnapshot<List<ProductModel>> snapshot) {
              if (snapshot.hasData) {
                return snapshot.data!.isNotEmpty
                    ? Expanded(
                        child: ListView(
                          children: List.generate(
                            snapshot.data!.length,
                            (index) {
                              ProductModel productModel = snapshot.data![index];
                              return ProductItemView(
                                productModel: productModel,
                              );
                            },
                          ),
                        ),
                      )
                    : const Center(child: Text("Product Empty!"));
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              return const Center(child: LoadData());
            },
          ),
        ],
      ),
    );
  }
}
