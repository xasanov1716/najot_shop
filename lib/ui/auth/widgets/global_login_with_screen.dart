import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:najot_shop/providers/auth_provider.dart';
import 'package:najot_shop/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class GetLoginWithButton extends StatelessWidget {
  const GetLoginWithButton({
    super.key,
    required this.text,
    required this.img,
  });

  final String text;
  final String img;

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: () {
        context.read<AuthProvider>().singInWithGoogle(context);
      },
      child: Container(
        width: 327.w,
        height: 48.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(width: 1.w, color: AppColors.globalActive),
          color: AppColors.globalPassive.withOpacity(0.9),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              img,
              width: 25.w,
              height: 25.h,
              color: AppColors.white,
            ),
            SizedBox(width: 10.w),
            Text(
              text,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColors.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}