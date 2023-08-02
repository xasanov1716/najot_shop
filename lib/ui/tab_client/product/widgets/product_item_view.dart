import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:najot_shop/utils/app_colors.dart';
import '../../../../data/models/products_data_model.dart';

class ProductItemView extends StatelessWidget {
  const ProductItemView({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: GridView(
            primary: false,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10.h,
              childAspectRatio: 0.7 ,
              crossAxisSpacing: 10.w,
            ),
            children: List.generate(2, (index) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: AppColors.globalPassive,
              ),
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.r),
                    child: Image.file(
                      File(productModel.productImages[0]),
                      fit: BoxFit.fitWidth,
                      height: 100.h,
                      width: 140.w,
                    ),
                  ),
                  Text(productModel.productName),
                ],
              ),
            )),
          ),
        ));
  }
}
