import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:najot_shop/utils/app_colors.dart';

class GlobalTextField extends StatefulWidget {
  const GlobalTextField({
    Key? key,
    required this.hintText,
    required this.keyboardType,
    required this.textInputAction,
    required this.textAlign,
    this.obscureText = false,
    required this.controller,
    required this.title,
    this.maxLine = 1,
  }) : super(key: key);

  final String title;
  final String hintText;
  final int maxLine;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextAlign textAlign;
  final bool obscureText;
  final TextEditingController controller;

  @override
  State<GlobalTextField> createState() => _GlobalTextFieldState();
}

class _GlobalTextFieldState extends State<GlobalTextField> {
  bool isTap = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 5.h),
        TextField(
          maxLines: widget.maxLine,
          controller: widget.controller,
          obscureText:
              widget.hintText == "Password" ? isTap : widget.obscureText,
          cursorColor: Colors.deepPurpleAccent,
          keyboardType: widget.keyboardType,
          style: Theme.of(context).textTheme.titleMedium,
          decoration: InputDecoration(
            prefixIcon: widget.hintText == "Email"
                ? const Icon(Icons.email)
                : widget.hintText == "Password"
                    ? const Icon(Icons.key)
                    : widget.hintText == "Username"
                        ? const Icon(Icons.person)
                        : null,
            suffixIcon: widget.hintText == "Password"
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isTap = !isTap;
                      });
                    },
                    icon: isTap
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  )
                : null,
            hintText: widget.hintText,
            hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.passiveText,
                ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.r),
              borderSide:
                  BorderSide(width: 0.8.w, color: AppColors.globalPassive),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.r),
              borderSide:
                  BorderSide(width: 0.8.w, color: AppColors.deleteColor),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.r),
              borderSide:
                  BorderSide(width: 0.8.w, color: AppColors.globalPassive),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.r),
              borderSide: BorderSide(width: 0.8.w, color: AppColors.deleteColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.r),
              borderSide: BorderSide(width: 1.w, color: AppColors.globalPassive),
            ),
          ),
        )
      ],
    );
  }
}
