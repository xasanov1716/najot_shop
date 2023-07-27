import 'package:flutter/material.dart';
import 'package:najot_shop/ui/auth/pages/login_page.dart';
import 'package:najot_shop/ui/auth/pages/signup_page.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          isLoginPage ? "Login" : "Sign Up",
          style: const TextStyle(
            color: Colors.deepPurpleAccent,
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
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
              alignment: Alignment.topCenter,
              child: LinearProgressIndicator(color: Colors.deepPurpleAccent,backgroundColor: Colors.deepPurple.withOpacity(0.3),),
            ),
          )
        ],
      ),
    );
  }
}
