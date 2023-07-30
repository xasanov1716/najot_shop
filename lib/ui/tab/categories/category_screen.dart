import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../data/models/categories_data_model.dart';
import '../../../data/models/universal_data.dart';
import '../../../providers/api_provider.dart';
import '../product/widget/product_shimmer.dart';
import 'category_product_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<CategoriesDataModel>? categoryModels;
  String isError = "";
  bool isLoading = false;

  _getCategoryData() async {
    setState(() {
      isLoading = true;
    });
    List<UniversalData> result =
        await Future.wait([ApiProvider.allCategories()]);

    if (result[0].error.isEmpty) {
      categoryModels = result.first.data as List<CategoriesDataModel>;
    } else {
      isError = result[0].error;
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _getCategoryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      body: isError.isEmpty
          ? isLoading
              ? const Center(child: LoadData())
              : Column(
                  children: [
                    SizedBox(height: 13.h),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: ListView.builder(
                          itemCount: categoryModels!.length,
                          itemBuilder: (context, index) {
                            final data = categoryModels![index];
                            return ZoomTapAnimation(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoryProductScreen(
                                      id: data.id,
                                      name: data.name,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.all(5.sp),
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
                                      borderRadius: BorderRadius.circular(30),
                                      child: CachedNetworkImage(
                                        imageUrl: data.imageUrl,
                                        width: 150,
                                        placeholder: (context, url) =>
                                            const LoadData(),
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      data.name,
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
                      ),
                    ),
                  ],
                )
          : Center(child: Text(isError)),
    );
  }
}
