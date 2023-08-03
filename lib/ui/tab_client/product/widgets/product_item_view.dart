import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:najot_shop/ui/auth/widgets/global_button.dart';
import 'package:najot_shop/ui/tab_client/product/product_datail_screen.dart';
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
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProductInfo(),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.r),
                    child: Hero(
                      tag: productModel.productId,
                      child: CachedNetworkImage(
                        imageUrl: productModel.productImages[0],
                        height: 150.h,
                        width: 150.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    color: Colors.white,
                    child: GestureDetector(
                      onTap: () {},
                      child: const Icon(Icons.favorite),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              productModel.productName,
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.globalActive,
              ),
            ),
            Text(
              "${productModel.currency} ${productModel.price}",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GlobalButton(
                text: "Add basket",
                onTap: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
