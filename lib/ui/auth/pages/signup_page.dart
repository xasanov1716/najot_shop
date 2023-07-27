import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';
import '../../../utils/app_images.dart';
import '../widgets/global_button.dart';
import '../widgets/global_login_with_screen.dart';
import '../widgets/global_text_fields.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key, required this.onChanged});

  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(25.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            GlobalTextField(
              hintText: "Username",
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              textAlign: TextAlign.start,
              controller: context.read<AuthProvider>().userNameController,
              title: 'Username',
              isPassword: false,
            ),
            const SizedBox(
              height: 24,
            ),
            GlobalTextField(
              hintText: "Email",
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              textAlign: TextAlign.start,
              controller: context.read<AuthProvider>().emailController,
              title: 'Email',
              isPassword: false,
            ),
            const SizedBox(height: 24),
            GlobalTextField(
              hintText: "Password",
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              textAlign: TextAlign.start,
              controller: context.read<AuthProvider>().passwordController,
              title: 'Password',
              isPassword: true,
            ),
            const SizedBox(height: 70),
            GetLoginWithButton(
                text: "Login with Google", img: AppImages.google),
            const SizedBox(height: 20),
            GetLoginWithButton(
                text: "Login with Apple", img: AppImages.apple),
            const SizedBox(height: 20),
            GlobalButton(
                text: "Sign up",
                onTap: () {
                  context.read<AuthProvider>().signUpUser(context);
                }),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Colors.deepPurpleAccent,
                      fontWeight: FontWeight.w400),
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
