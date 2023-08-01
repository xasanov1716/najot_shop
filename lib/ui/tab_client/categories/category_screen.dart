import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../data/models/category_model.dart';
import '../../../providers/category_provider.dart';
import '../../tab_admin/widget/product_shimmer.dart';
import 'add_category.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

List<CategoryModel>? categoryModels;
String isError = "";
bool isLoading = false;

class _CategoryScreenState extends State<CategoryScreen> {
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
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
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
                                  borderRadius: BorderRadius.circular(13),
                                  child: categoryModel.imageUrl.isNotEmpty
                                      ? Image(
                                    image: FileImage(
                                      File(categoryModel.imageUrl),
                                    ),
                                  )
                                      : Image.asset("assets/images/logo.png",
                                      width: 120.w),
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
                        color: Colors.black.withOpacity(0.2),
                        fontSize: 24,
                      ),
                    ),
                  );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          return const Center(child: LoadData());
        },
      ),
    );
  }
}