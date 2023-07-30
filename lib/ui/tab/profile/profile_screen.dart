import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:najot_shop/ui/auth/widgets/global_button.dart';
import 'package:najot_shop/ui/tab/product/widget/product_shimmer.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';
import '../../../providers/profile_provider.dart';
import '../../auth/widgets/global_text_fields.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    User? user = context.watch<ProfileProvider>().currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => AlertDialog(
                    title: const Text("Close your account ?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.deepPurpleAccent),
                        child: const Text(
                          "Close",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<AuthProvider>().logOut(context);
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.redAccent),
                        child: const Text(
                          "Log out",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ListView(
              children: [
                CircleAvatar(
                  radius: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60.0),
                    child: CachedNetworkImage(
                      imageUrl: user!.photoURL??"",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    user?.displayName ?? "Not found!",
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    user?.email ?? "Empty",
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    user?.phoneNumber ?? "Not found!",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ),
                GlobalTextField(
                  hintText: "Username",
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.start,
                  controller: context.read<ProfileProvider>().nameController,
                  title: '',
                  obscureText: false,
                ),
                GlobalTextField(
                  hintText: "Email",
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.start,
                  controller: context.read<ProfileProvider>().emailController,
                  title: '',
                  obscureText: false,
                ),
                const SizedBox(height: 70),
                GlobalButton(
                  text: "Update",
                  onTap: () {
                    context
                        .read<ProfileProvider>()
                        .updateUserDisplayName(context);
                    context.read<ProfileProvider>().updateEmail(context);
                  },
                )
              ],
            ),
          ),
          Visibility(
            visible: context.watch<ProfileProvider>().isLoading,
            child: const Align(
              alignment: Alignment.bottomCenter,
              child: LoadData(),
            ),
          ),
        ],
      ),
    );
  }
}