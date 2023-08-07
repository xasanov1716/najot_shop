import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:najot_shop/utils/app_colors.dart';
import '../../../data/models/products_data_model.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen(
      {super.key, required this.productModel, required this.index});

  final ProductModel productModel;
  final int index;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Product",
          style: TextStyle(
            fontSize: 20.spMin,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              physics: const ScrollPhysics(),
              children: [
                SizedBox(height: 24.h),
                CarouselSlider(
                  items: List.generate(
                    widget.productModel.productImages.length,
                    (index) => ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: widget.productModel.productImages[index],
                          fit: BoxFit.cover,
                          height: 250,
                          width: 350,
                        ),
                      ),
                    ),
                  ),
                  options: CarouselOptions(
                    height: 200.h,
                    autoPlay: true,
                    aspectRatio: 3.0,
                    enlargeCenterPage: true,
                  ),
                ),
                SizedBox(height: 20.h),
                Center(
                  child: Text(
                    widget.productModel.productName,
                    style: TextStyle(
                      fontSize: 32.spMin,
                      color: AppColors.globalActive,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Text(
                    widget.productModel.description,
                    style: TextStyle(
                      fontSize: 22.spMin,
                      color: AppColors.globalPassive,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Text(
                    "Count: ${widget.productModel.count}",
                    style: TextStyle(
                      fontSize: 22.spMin,
                      color: AppColors.globalPassive,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Text(
                    "Price: ${widget.productModel.price} ${widget.productModel.currency}",
                    style: TextStyle(
                      fontSize: 22.spMin,
                      color: AppColors.globalPassive,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(24.sp),
                  child: Text(
                    "Total price: ${widget.productModel.price * count} ${widget.productModel.currency}",
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.globalPassive,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (count > 1) {
                          setState(() {
                            count--;
                            widget.productModel.count++;
                          });
                        }
                      },
                      child: const Icon(
                        Icons.remove,
                      ),
                    ),
                    Text(
                      count.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColors.globalPassive,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if ((count + 1) <= widget.productModel.count) {
                          setState(() {
                            count++;
                            widget.productModel.count--;
                          });
                        }
                      },
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
