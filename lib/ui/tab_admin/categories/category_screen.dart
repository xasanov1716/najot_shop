import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:najot_shop/ui/tab_admin/categories/update_category.dart';
import 'package:najot_shop/ui/tab_client/widget/global_shimmer.dart';
import 'package:najot_shop/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../data/models/category_model.dart';
import '../../../providers/category_provider.dart';
import 'add_category.dart';

class CategoryScreenAdmin extends StatefulWidget {
  const CategoryScreenAdmin({super.key});

  @override
  State<CategoryScreenAdmin> createState() => _CategoryScreenAdminState();
}

List<CategoryModel>? categoryModels;
String isError = "";
bool isLoading = false;

class _CategoryScreenAdminState extends State<CategoryScreenAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddPage(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          )
        ],
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
                          child: Slidable(
                            endActionPane: ActionPane(
                              motion: const StretchMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    context
                                        .read<CategoryProvider>()
                                        .deleteCategory(
                                            context: context,
                                            categoryId:
                                                categoryModel.categoryId);
                                    Navigator.pop(context);
                                  },
                                  borderRadius: BorderRadius.circular(15),
                                  backgroundColor: Colors.red,
                                  icon: Icons.delete,
                                  spacing: 10,
                                ),
                                const SizedBox(width: 15),
                                SlidableAction(
                                  onPressed: (context) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const UpdatePage()));
                                  },
                                  borderRadius: BorderRadius.circular(15),
                                  backgroundColor: Colors.green,
                                  icon: Icons.edit,
                                  spacing: 10,
                                ),
                                const SizedBox(width: 14),
                              ],
                            ),
                            child: Container(
                              margin: EdgeInsets.all(10.sp),
                              padding: EdgeInsets.all(5.sp),
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.r),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.globalPassive
                                        .withOpacity(0.7),
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
                                        ? Image.network(
                                            categoryModel.imageUrl,
                                            height: 100,
                                            width: 110,
                                            fit: BoxFit.cover,
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
          return const Center(child: Loading());
        },
      ),
    );
  }
}
