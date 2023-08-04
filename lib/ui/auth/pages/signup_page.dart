import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:najot_shop/utils/app_colors.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../utils/app_images.dart';
import '../widgets/global_button.dart';
import '../widgets/global_login_with_screen.dart';
import '../widgets/global_text_fields.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({
    super.key,
    required this.onChanged,
  });

  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(25.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30.h),
            Image.asset(
              AppImages.logoSingUp,
              width: 250,
            ),
            SizedBox(height: 30.h),
            GlobalTextField(
              hintText: "Username",
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              textAlign: TextAlign.start,
              controller: context.read<AuthProvider>().userNameController,
              title: 'Username',
              obscureText: false,
            ),
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
            SizedBox(height: 20.h),
            GlobalTextField(
              hintText: "Password",
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              textAlign: TextAlign.start,
              controller: context.read<AuthProvider>().passwordController,
              title: 'Password',
              obscureText: true,
            ),
            SizedBox(height: 20.h),
            GetLoginWithButton(
              text: "Login with Google",
              img: AppImages.google,
            ),
            SizedBox(height: 20.h),
            GlobalButton(
              text: "Sign up",
              onTap: () {
                context.read<AuthProvider>().signUpUser(context);
              },
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: AppColors.globalPassive,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                GestureDetector(
                  onTap: () {
                    onChanged.call();
                    context.read<AuthProvider>().loginButtonPressed();
                  },
                  child: Text(
                    "Log In",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
