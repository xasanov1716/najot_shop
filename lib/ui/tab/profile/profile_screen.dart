import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:najot_shop/ui/auth/widgets/global_button.dart';
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
          backgroundColor: Colors.deepPurpleAccent,
          title: const Text("Profile"),
          actions: [
            IconButton(
                onPressed: () {
                  context.read<AuthProvider>().logOut(context);
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: ListView(
                children: [
                  CircleAvatar(
                    radius: 40,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60.0),
                      child: Image.network(
                        user?.photoURL ?? "",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      user?.email ?? "Empty",
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                  ),
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
                      user?.phoneNumber ?? "Not found!",
                      style: const TextStyle(
                        fontSize: 20,
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
                    isPassword: false,
                  ),
                  // TextButton(
                  //   onPressed: () {
                  //     context
                  //         .read<ProfileProvider>()
                  //         .updateUserDisplayName(context);
                  //     context.read<ProfileProvider>().updateEmail(context);
                  //   },
                  //   child: const Text("Update name"),
                  // ),
                  GlobalTextField(
                    hintText: "Email",
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    textAlign: TextAlign.start,
                    controller: context.read<ProfileProvider>().emailController,
                    title: '',
                    isPassword: false,
                  ),
                  // TextButton(
                  //   onPressed: () {
                  //     context.read<ProfileProvider>().updateEmail(context);
                  //   },
                  //   child: const Text("Update email"),
                  // )
                  SizedBox(height: 24),
                  GlobalButton(text: "Update", onTap: (){context
                      .read<ProfileProvider>()
                      .updateUserDisplayName(context);
                  context.read<ProfileProvider>().updateEmail(context);})
                  // TextButton(
                  //   onPressed: () {
                  //
                  //   },
                  //   child: const Text("Update"),
                  // ),
                ],
              ),
            ),
            Visibility(
              visible: context.watch<ProfileProvider>().isLoading,
              child: const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ));
  }
}
