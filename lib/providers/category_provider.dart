import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:najot_shop/data/models/category_model.dart';
import '../data/firebase/category_service.dart';
import '../data/models/universal_data.dart';
import '../data/upload_service.dart';
import '../utils/ui_utils/loading_dialog.dart';

class CategoryProvider with ChangeNotifier {
  CategoryProvider({required this.categoryService});

  final CategoryService categoryService;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String categoryUrl = "";

  Future<void> addCategory({
    required BuildContext context,
    required CategoryModel categoryModel,
  }) async {
    showLoading(context: context);
    UniversalData universalData =
        await categoryService.addCategory(categoryModel: categoryModel);
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showMessage(context, universalData.data as String);
      }
    } else {
      if (context.mounted) {
        showMessage(context, universalData.error);
      }
    }
  }

  Future<void> updateCategory({
    required BuildContext context,
    required CategoryModel categoryModel,
    required String image,
  }) async {

    if (categoryModel.categoryName.isNotEmpty) {
      showLoading(context: context);
      UniversalData universalData = await categoryService.updateCategory(
          categoryModel: CategoryModel(
        categoryId: categoryModel.categoryId,
        categoryName: nameController.text,
        imageUrl: image,

        createdAt: categoryModel.createdAt,
      ));
      if (context.mounted) {
        hideLoading(dialogContext: context);
      }
      if (universalData.error.isEmpty) {
        if (context.mounted) {
          showMessage(context, universalData.data as String);
          Navigator.pop(context);
        }
      } else {
        if (context.mounted) {
          showMessage(context, universalData.error);
        }
      }
    }
  }

  Future<void> deleteCategory({
    required BuildContext context,
    required String categoryId,
  }) async {
    showLoading(context: context);
    UniversalData universalData =
        await categoryService.deleteCategory(categoryId: categoryId);
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showMessage(context, universalData.data as String);
      }
    } else {
      if (context.mounted) {
        showMessage(context, universalData.error);
      }
    }
  }

  Stream<List<CategoryModel>> getCategories() =>
      FirebaseFirestore.instance.collection("categories").snapshots().map(
            (event1) => event1.docs
                .map(
                  (doc) => CategoryModel.fromJson(
                    doc.data(),
                  ),
                )
                .toList(),
          );

  showMessage(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
        backgroundColor: Colors.deepPurpleAccent,
        action: SnackBarAction(
          label: "Ok",
          onPressed: () {},
        ),
      ),
    );
    notifyListeners();
  }

  Future<void> uploadCategoryImage(
    BuildContext context,
    XFile xFile,
  ) async {
    showLoading(context: context);
    UniversalData data = await FileUploader.imageUploader(xFile);
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (data.error.isEmpty) {
      categoryUrl = data.data as String;
      notifyListeners();
    } else {
      if (context.mounted) {
        showMessage(context, data.error);
      }
    }
  }

  clearTexts() {
    descriptionController.clear();
    nameController.clear();
  }
}
