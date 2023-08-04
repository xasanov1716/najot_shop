import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:najot_shop/utils/app_colors.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../utils/app_images.dart';
import '../widgets/global_button.dart';
import '../widgets/global_login_with_screen.dart';
import '../widgets/global_text_fields.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    super.key,
    required this.onChanged,
  });

  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(25.sp),
          child: Column(
            children: [
              Image.asset(AppImages.logoLogin, width: 250.w),
              SizedBox(height: 20.h),
              GlobalTextField(
                hintText: "Email",
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.start,
                controller: context.read<AuthProvider>().emailController,
                title: 'Email',
                obscureText: false,
              ),
              SizedBox(height: 24.h),
              GlobalTextField(
                hintText: "Password",
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.start,
                controller: context.read<AuthProvider>().passwordController,
                title: 'Password',
                obscureText: true,
              ),
              SizedBox(height: 70.h),
              GetLoginWithButton(
                text: "Login with Google",
                img: AppImages.google,
              ),
              SizedBox(height: 20.h),
              GlobalButton(
                text: "Log In",
                onTap: () {
                  context.read<AuthProvider>().logIn(context);
                },
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don’t have an account?",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: AppColors.globalPassive,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  GestureDetector(
                    onTap: () {
                      onChanged.call();
                      context.read<AuthProvider>().signUpButtonPressed();
                    },
                    child: Text(
                      "Sing Up",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
