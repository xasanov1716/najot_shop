import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../utils/app_colors.dart';

class GlobalButton extends StatefulWidget {
  const GlobalButton({
    super.key,
    required this.text,
    this.username = false,
    this.password = false,
    required this.onTap,
    this.confirmPassword = true,
    this.isSignUp = false,
  });

  final String text;
  final bool username;
  final bool password;
  final bool isSignUp;
  final bool confirmPassword;
  final VoidCallback onTap;

  @override
  State<GlobalButton> createState() => _GlobalButtonState();
}

class _GlobalButtonState extends State<GlobalButton> {
  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: widget.onTap,
      child: Container(
        height: 48.h,
        width: 327.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(
            width: 1.w,
            color: AppColors.globalActive,
          ),
          color: AppColors.globalActive,
        ),
        child: Center(
          child: Text(
            widget.text,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ),
    );
  }
}
