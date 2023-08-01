import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:najot_shop/ui/auth/widgets/global_button.dart';
import 'package:najot_shop/ui/auth/widgets/global_text_fields.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../data/models/category_model.dart';
import '../../../providers/category_provider.dart';
import '../../tab_admin/categories/category_screen.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({Key? key}) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      return e;
    }
  }

  Future pickCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      return e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Category"),
        leading: IconButton(
          onPressed: () {
            context.read<CategoryProvider>().nameController.clear();
            context.read<CategoryProvider>().descriptionController.clear();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ZoomTapAnimation(
                    onTap: (){
                      pickImage();
                    },
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.deepPurpleAccent.withOpacity(0.4),
                      ),
                      child: const Icon(Icons.image,size: 30),
                    ),
                  ),
                  ZoomTapAnimation(
                    onTap: (){
                      pickCamera();
                    },
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.deepPurpleAccent.withOpacity(0.4),
                      ),
                      child: const Icon(Icons.camera_alt,size: 30),
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
              const SizedBox(height: 12),
              GlobalTextField(
                hintText: 'Enter description',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.start,
                controller:
                context.read<CategoryProvider>().descriptionController,
                title: 'Enter description',
              ),
              const SizedBox(height: 32),
              GlobalButton(text: "Update", onTap: (){
                if (context
                    .read<CategoryProvider>()
                    .descriptionController
                    .text
                    .isNotEmpty &&
                    context
                        .read<CategoryProvider>()
                        .nameController
                        .text
                        .isNotEmpty) {
                  context.read<CategoryProvider>().updateCategory(
                    context: context,
                    categoryModel: CategoryModel(
                      categoryId: "2",
                      categoryName: context
                          .read<CategoryProvider>()
                          .nameController
                          .text,
                      description: context
                          .read<CategoryProvider>()
                          .descriptionController
                          .text,
                      imageUrl: image?.path ?? "",
                      createdAt: DateTime.now().toString(),
                    ),
                  );
                  Navigator.pushReplacement(context,
                      CupertinoPageRoute(builder: (context) => const CategoryScreenAdmin()));
                }
                context.read<CategoryProvider>().nameController.clear();
                context.read<CategoryProvider>().descriptionController.clear();
              })
            ],
          ),
        ),
      ),
    );
  }
}
