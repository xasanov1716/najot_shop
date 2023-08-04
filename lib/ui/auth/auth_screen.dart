import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:najot_shop/ui/auth/pages/login_page.dart';
import 'package:najot_shop/ui/auth/pages/signup_page.dart';
import 'package:najot_shop/utils/app_colors.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLoginPage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          isLoginPage
              ? LoginPage(
                  onChanged: () {
                    setState(() {
                      isLoginPage = false;
                    });
                  },
                )
              : SignUpScreen(
                  onChanged: () {
                    setState(() {
                      isLoginPage = true;
                    });
                  },
                ),
          Visibility(
            visible: context.watch<AuthProvider>().isLoading,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: LinearProgressIndicator(
                color: AppColors.globalPassive,
                backgroundColor: AppColors.globalActive.withOpacity(0.3),
                minHeight: 10.h,
              ),
            ),
          )
        ],
      ),
    );
  }
}