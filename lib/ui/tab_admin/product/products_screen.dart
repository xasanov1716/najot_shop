import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:najot_shop/ui/tab_admin/product/subscreen/add_product.dart';
import 'package:najot_shop/ui/tab_client/widget/global_shimmer.dart';
import 'package:provider/provider.dart';
import '../../../data/models/products_data_model.dart';
import '../../../providers/product_provider.dart';
import '../../../utils/app_colors.dart';
import '../../tab_client/product/product_datail_screen.dart';

class ProductScreenAdmin extends StatefulWidget {
  const ProductScreenAdmin({super.key});

  @override
  State<ProductScreenAdmin> createState() => _ProductScreenAdminState();
}

class _ProductScreenAdminState extends State<ProductScreenAdmin> {
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
        stream: context.read<ProductsProvider>().getProductsBbyCategory(),
        builder:
            (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.isNotEmpty
                ? GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                    ),
                    children: List.generate(
                      snapshot.data!.length,
                      (index) {
                        ProductModel productModel = snapshot.data![index];
                        return Container(
                          margin: EdgeInsets.all(10.sp),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              color: AppColors.white,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      AppColors.globalPassive.withOpacity(0.5),
                                  spreadRadius: 3.r,
                                  offset: const Offset(0, 5),
                                  blurRadius: 10.r,
                                )
                              ]),
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetailScreen(
                                        productModel: productModel,
                                        index: index,
                                      ),
                                    ),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: CachedNetworkImage(
                                    height: 110.h,
                                    width: 160.h,
                                    fit: BoxFit.cover,
                                    imageUrl: productModel.productImages.first,
                                    placeholder: (context, url) =>
                                        const Loading(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                              ),
                              Text(
                                productModel.productName,
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  color: AppColors.globalActive,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    productModel.description,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      color: AppColors.globalPassive,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "Price: ${productModel.price} ${productModel.currency}",
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      color: AppColors.globalPassive,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "Count: ${productModel.count}",
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      color: AppColors.globalPassive,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          backgroundColor: Colors.white,
                                          content: Padding(
                                            padding: EdgeInsets.only(top: 10.h),
                                            child: Text(
                                              "Delete Product ?",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 24.sp,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          actions: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: AppColors.globalPassive
                                                      .withOpacity(0.3),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              child: CupertinoDialogAction(
                                                onPressed: () {
                                                  context
                                                      .read<ProductsProvider>()
                                                      .deleteProduct(
                                                        context: context,
                                                        productId: productModel
                                                            .productId,
                                                      );
                                                  Navigator.of(context).pop();
                                                },
                                                isDefaultAction: true,
                                                child: const Text("ok"),
                                              ),
                                            ),
                                            SizedBox(height: 10.h),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: AppColors.globalPassive
                                                      .withOpacity(0.3),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              child: CupertinoDialogAction(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                isDefaultAction: true,
                                                child: const Text("cancel"),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return ProductAddScreen(
                                              productModel: productModel,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: AppColors.globalPassive,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  )
                : Center(
                    child: Text(
                    "Product Empty!",
                    style: TextStyle(
                        fontSize: 32.spMin,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ));
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
