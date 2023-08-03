import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../data/models/products_data_model.dart';
import '../../../providers/product_provider.dart';
import '../../tab_admin/widget/global_shimmer.dart';

class ProductInfo extends StatefulWidget {
  const ProductInfo({super.key});

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  String selectedCategoryId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<List<ProductModel>>(
        stream:
            context.read<ProductsProvider>().getProducts(selectedCategoryId),
        builder:
            (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.isNotEmpty
                ? ListView(
                    children: [
                      ...List.generate(
                        snapshot.data!.length,
                        (index) {
                          ProductModel productModel = snapshot.data![index];
                          return Container(
                            child: Hero(
                              tag: productModel.productId,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ZoomTapAnimation(
                                  onTap: () {},
                                  child: CachedNetworkImage(
                                    imageUrl: productModel.productImages[0],
                                    height: 150.h,
                                    width: 50.w,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  )
                : const Center(child: Text("Product Empty!"));
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          return const Center(child: Loading());
        },
      ),
    );
  }
}
