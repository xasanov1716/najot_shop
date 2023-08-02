import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:najot_shop/utils/app_colors.dart';
import 'package:najot_shop/utils/app_images.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../data/models/category_model.dart';
import '../../../providers/category_provider.dart';
import '../../tab_admin/widget/global_shimmer.dart';

class CategoryScreenClient extends StatefulWidget {
  const CategoryScreenClient({super.key});

  @override
  State<CategoryScreenClient> createState() => _CategoryScreenClientState();
}

List<CategoryModel>? categoryModels;
String isError = "";
bool isLoading = false;

class _CategoryScreenClientState extends State<CategoryScreenClient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      body: StreamBuilder<List<CategoryModel>>(
        stream: context.read<CategoryProvider>().getCategories(),
        builder: (BuildContext context,
            AsyncSnapshot<List<CategoryModel>> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.isNotEmpty
                ? ListView(
                    children: List.generate(
                      snapshot.data!.length,
                      (index) {
                        CategoryModel categoryModel = snapshot.data![index];
                        return ZoomTapAnimation(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.all(10.sp),
                            padding: EdgeInsets.all(5.sp),
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              color: AppColors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.passiveText.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(13.r),
                                  child: categoryModel.imageUrl.isNotEmpty
                                      ? Image(
                                          image: FileImage(
                                            File(categoryModel.imageUrl),
                                          ),
                                        )
                                      : Image.asset(
                                          AppImages.logo,
                                          width: 120.w,
                                        ),
                                ),
                                const Spacer(),
                                Text(
                                  categoryModel.categoryName,
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Center(
                    child: Text(
                      "Empty!",
                      style: TextStyle(
                        color: AppColors.black.withOpacity(0.2),
                        fontSize: 24.sp,
                      ),
                    ),
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
    );
  }
}