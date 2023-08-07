import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:najot_shop/ui/tab_client/product/widgets/category_item_view.dart';
import 'package:najot_shop/ui/tab_client/product/widgets/product_item_view.dart';
import 'package:provider/provider.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/products_data_model.dart';
import '../../../providers/category_provider.dart';
import '../../../providers/product_provider.dart';
import '../widget/global_shimmer.dart';

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
        title: const Text("Products"),
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
                        height: 50.h,
                        width: MediaQuery.of(context).size.width,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            CategoryItemView(
                              categoryModel: CategoryModel(
                                categoryId: "",
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
                    : const Center(child: Text(""));
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              return const SizedBox();
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
                        child: GridView(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                          ),
                          children: [
                            ...List.generate(
                              snapshot.data!.length,
                              (index) {
                                ProductModel productModel =
                                    snapshot.data![index];
                                return ProductItemView(
                                  index: index,
                                  productModel: productModel,
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(height: 240),
                          Center(child: Text("Product Empty!")),
                          SizedBox(height: 100),
                        ],
                      );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              return const Center(child: Loading());
            },
          ),
        ],
      ),
    );
  }
}
