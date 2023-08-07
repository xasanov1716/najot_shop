import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:najot_shop/ui/auth/widgets/global_button.dart';
import 'package:najot_shop/ui/tab_client/widget/global_shimmer.dart';
import 'package:najot_shop/utils/app_colors.dart';
import 'package:najot_shop/utils/app_images.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/profile_provider.dart';
import '../../auth/widgets/global_text_fields.dart';

class ProfileScreenAdmin extends StatefulWidget {
  const ProfileScreenAdmin({super.key});

  @override
  State<ProfileScreenAdmin> createState() => _ProfileScreenAdminState();
}

class _ProfileScreenAdminState extends State<ProfileScreenAdmin> {
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
                          backgroundColor: AppColors.globalPassive,
                        ),
                        child: Text(
                          "Close",
                          style: TextStyle(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          context.read<AuthProvider>().logOut(context);
                          Navigator.pop(context);
                          context
                              .read<ProfileProvider>()
                              .nameController
                              .clear();
                          context
                              .read<ProfileProvider>()
                              .emailController
                              .clear();
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: AppColors.deleteColor),
                        child: Text(
                          "Log out",
                          style: TextStyle(
                            color: AppColors.white,
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
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: ListView(
              children: [
                CircleAvatar(
                  radius: 45.r,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60.r),
                    child: user!.photoURL == ""
                        ? CachedNetworkImage(
                            imageUrl: "${user.photoURL}",
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            AppImages.logo,
                            width: 80.w,
                            height: 80.h,
                          ),
                  ),
                ),
                SizedBox(height: 10.h),
                Center(
                  child: Text(
                    user.displayName ?? "Not found!",
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: AppColors.globalActive,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    user.email ?? "Empty",
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: AppColors.passiveText,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    user.phoneNumber ?? "Not found!",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.passiveText,
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
                SizedBox(height: 70.h),
                GlobalButton(
                  text: "Update",
                  onTap: () {
                    context
                        .read<ProfileProvider>()
                        .updateUserDisplayName(context);
                  },
                )
              ],
            ),
          ),
          Visibility(
            visible: context.watch<ProfileProvider>().isLoading,
            child: const Align(
              alignment: Alignment.bottomCenter,
              child: Loading(),
            ),
          ),
        ],
      ),
    );
  }
}
