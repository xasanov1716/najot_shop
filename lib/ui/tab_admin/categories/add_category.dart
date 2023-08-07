import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:najot_shop/ui/auth/widgets/global_button.dart';
import 'package:najot_shop/ui/auth/widgets/global_text_fields.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../data/models/category_model.dart';
import '../../../providers/category_provider.dart';
import 'category_screen.dart';

class AddPage extends StatefulWidget {
  const AddPage({
    Key? key,
  }) : super(key: key);


  @override
  State<AddPage> createState() => _AddPageState();
}
class _AddPageState extends State<AddPage> {
  ImagePicker picker = ImagePicker();
  File? image;

  Future<void> _getFromCamera() async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 512,
      maxWidth: 512,
    );

    if (xFile != null) {
      // ignore: use_build_context_synchronously
      await Provider.of<CategoryProvider>(context, listen: false)
          .uploadCategoryImage(context, xFile);
    }
  }

  Future<void> _getFromGallery() async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
    );
    if (xFile != null) {
      // ignore: use_build_context_synchronously
      await Provider.of<CategoryProvider>(context, listen: false)
          .uploadCategoryImage(context, xFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Category"),
        leading: IconButton(
          onPressed: () {
            context.read<CategoryProvider>().nameController.clear();
            context.read<CategoryProvider>().descriptionController.clear();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: StreamBuilder<List<CategoryModel>>(
        stream: context.read<CategoryProvider>().getCategories(),
        builder: (BuildContext context,
            AsyncSnapshot<List<CategoryModel>> snapshot) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ZoomTapAnimation(
                      onTap: () {
                        _getFromGallery();
                      },
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.deepPurpleAccent.withOpacity(0.4),
                        ),
                        child: const Icon(Icons.image, size: 30),
                      ),
                    ),
                    // ClipRRect(
                    //   borderRadius: BorderRadius.circular(13),
                    //   child: categoryModels?.first.imageUrl!=null
                    //       ? CachedNetworkImage(
                    //           imageUrl: categoryModels!.first.imageUrl,
                    //           height: 100.h,
                    //           width: 110.w,
                    //           fit: BoxFit.cover,
                    //         )
                    //       : Image.asset(
                    //           AppImages.logo,
                    //           width: 120.w,
                    //         ),
                    // ),
                    ZoomTapAnimation(
                      onTap: () {
                        _getFromCamera();
                      },
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.deepPurpleAccent.withOpacity(0.4),
                        ),
                        child: const Icon(Icons.camera_alt, size: 30),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                GlobalTextField(
                  hintText: 'Enter name',
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.start,
                  controller: context.read<CategoryProvider>().nameController,
                  title: 'Enter name',
                ),
                const SizedBox(height: 32),
                GlobalButton(
                    text: "Add",
                    onTap: () {
                      if (context
                          .read<CategoryProvider>()
                          .nameController
                          .text
                          .isNotEmpty) {
                        context.read<CategoryProvider>().addCategory(
                              context: context,
                              categoryModel: CategoryModel(
                                categoryId: "",
                                categoryName: context
                                    .read<CategoryProvider>()
                                    .nameController
                                    .text,
                                imageUrl: context
                                    .read<CategoryProvider>()
                                    .categoryUrl,
                                createdAt: DateTime.now().toString(),
                              ),
                            );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CategoryScreenAdmin(),
                          ),
                        );
                        Navigator.pop(context);
                      }
                      context.read<CategoryProvider>().nameController.clear();
                      context
                          .read<CategoryProvider>()
                          .descriptionController
                          .clear();
                    }),
              ],
            ),
          );
        },
      ),
    );
  }
}
