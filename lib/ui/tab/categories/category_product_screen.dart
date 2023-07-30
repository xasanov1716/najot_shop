import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../data/models/products_data_model.dart';
import '../../../data/models/universal_data.dart';
import '../../../providers/api_provider.dart';
import '../product/widget/product_shimmer.dart';

class CategoryProductScreen extends StatefulWidget {
  const CategoryProductScreen({Key? key, required this.id, required this.name})
      : super(key: key);

  final int id;
  final String name;

  @override
  State<CategoryProductScreen> createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen> {
  List<ProductsDataModel>? productModels;
  String isError = "";
  bool isLoading = false;

  _getProductData() async {
    setState(() {
      isLoading = true;
    });
    List<UniversalData> result =
        await Future.wait([ApiProvider.productById(widget.id)]);

    if (result[0].error.isEmpty) {
      productModels = result.first.data as List<ProductsDataModel>;
    } else {
      isError = result[0].error;
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _getProductData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
        ),
        body: isError.isEmpty
            ? isLoading
                ? const Center(child: LoadData())
                : Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          itemCount: productModels!.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.65,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 0,
                          ),
                          itemBuilder: (context, index) {
                            return ZoomTapAnimation(
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        width: 1,
                                        color: Colors.black.withOpacity(0.4)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 7,
                                        spreadRadius: 1,
                                        offset: const Offset(3, 3),
                                      )
                                    ]),
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                productModels![index].imageUrl,
                                            placeholder: (context, url) =>
                                                const LoadData(),
                                            width: double.infinity,
                                            height: 120.h,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                productModels![index]
                                                        .isFavorite =
                                                    !productModels![index]
                                                        .isFavorite;
                                              });
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  productModels![index]
                                                          .isFavorite
                                                      ? Icons.favorite
                                                      : Icons.favorite_border,
                                                  color: Colors.red,
                                                  size: 25,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Text(
                                      productModels![index].name,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      "USD ${productModels![index].price.toString()}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.indigo,
                                      ),
                                    ),
                                    const Spacer(),
                                    ElevatedButton(
                                      onPressed: () {},
                                      child: const Center(
                                        child: Text(
                                          "Savatga qo'shish",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )
            : Text(isError));
  }
}