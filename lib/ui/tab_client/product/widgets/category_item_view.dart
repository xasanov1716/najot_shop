import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:najot_shop/utils/app_colors.dart';
import '../../../../data/models/category_model.dart';

class CategoryItemView extends StatelessWidget {
  const CategoryItemView({
    super.key,
    required this.categoryModel,
    required this.onTap,
    required this.selectedId,
  });

  final CategoryModel categoryModel;
  final VoidCallback onTap;
  final String selectedId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: selectedId == categoryModel.categoryId
              ? AppColors.globalPassive
              : AppColors.globalActive,
        ),
        height: 50.h,
        margin: EdgeInsets.all(5.sp),
        padding: EdgeInsets.all(10.sp),
        child: Center(
          child: Text(
            categoryModel.categoryName,
            style: TextStyle(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
