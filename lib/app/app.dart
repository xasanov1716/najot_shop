import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:najot_shop/providers/auth_provider.dart';
import 'package:najot_shop/ui/tab_admin/tab_box.dart';
import 'package:najot_shop/ui/tab_client/tab_box.dart';
import 'package:najot_shop/utils/constants.dart';
import 'package:provider/provider.dart';

import '../ui/auth/auth_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: context.read<AuthProvider>().listenAuthState(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          } else if (snapshot.data == null) {
            return const AuthScreen();
          } else {
            return snapshot.data!.email == adminEmail
                ? const TabBoxAdmin()
                : const TabBoxClient();
          }
        },
      ),
    );
  }
}
