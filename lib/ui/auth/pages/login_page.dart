import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../utils/app_images.dart';
import '../widgets/global_button.dart';
import '../widgets/global_login_with_screen.dart';
import '../widgets/global_text_fields.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key, required this.onChanged});

  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(25.sp),
          child: Column(
            children: [
              Image.asset("assets/images/login_logo.png", width: 250),
              const SizedBox(height: 20),
              GlobalTextField(
                hintText: "Email",
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.start,
                controller: context.read<AuthProvider>().emailController,
                title: 'Email',
                obscureText: false,
              ),
              const SizedBox(height: 24),
              GlobalTextField(
                hintText: "Password",
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.start,
                controller: context.read<AuthProvider>().passwordController,
                title: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 70),
              GetLoginWithButton(
                  text: "Login with Google", img: AppImages.google),
              const SizedBox(height: 20),
              GlobalButton(
                text: "Log In",
                onTap: () {
                  context.read<AuthProvider>().logIn(context);
                },
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don’t have an account?",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Colors.deepPurpleAccent,
                        fontWeight: FontWeight.w400),
                  ),
                  GestureDetector(
                    onTap: () {
                      onChanged.call();
                      context.read<AuthProvider>().signUpButtonPressed();
                    },
                    child: Text(
                      "Sing Up",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(fontWeight: FontWeight.w500),
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
