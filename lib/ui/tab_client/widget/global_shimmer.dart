import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:najot_shop/utils/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 100,
      child: Shimmer.fromColors(
        baseColor: AppColors.globalActive,
        highlightColor: AppColors.white,
        child: Center(
          child: Text(
            'Loading...',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30.sp,
              fontWeight:
              FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}