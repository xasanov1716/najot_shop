import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:najot_shop/ui/auth/widgets/global_button.dart';
import 'package:najot_shop/ui/tab_client/product/product_datail_screen.dart';
import 'package:najot_shop/utils/app_colors.dart';
import '../../../../data/models/products_data_model.dart';

class ProductItemView extends StatelessWidget {
  const ProductItemView(
      {super.key, required this.productModel, required this.index});

  final ProductModel productModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Container(
        margin: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.globalPassive,
                spreadRadius: 2.r,
                offset: const Offset(0, 0),
                blurRadius: 10.r,
              )
            ]),
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(
                              productModel: productModel, index: index),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.r),
                      child: Hero(
                        tag: productModel.productId,
                        child: CachedNetworkImage(
                          imageUrl: productModel.productImages[0],
                          height: 130.h,
                          width: 150.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      decoration:BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5.r),
                          topLeft: Radius.circular(11.r),
                          bottomRight: Radius.circular(11.r),
                        ),
                        color: AppColors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.favorite_border,
                            color: AppColors.globalPassive,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Text(
                  productModel.productName,
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.globalActive,
                  ),
                ),
              ),
              Text(
                "${productModel.price} ${productModel.currency}",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
              ),
              Text(
                "Count: ${productModel.count}",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.globalPassive,
                ),
              ),
              Text(
                productModel.createdAt.substring(0,11),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.passiveText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
