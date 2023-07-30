import 'package:flutter/material.dart';
import 'package:najot_shop/ui/tab/product/products_screen.dart';
import '../ui/tab/categories/category_screen.dart';
import '../ui/tab/profile/profile_screen.dart';

class TabProvider with ChangeNotifier {
  List<Widget> screens = [
    const ProductsScreen(),
    const CategoryScreen(),
    const ProfileScreen(),
  ];

  int activeIndex = 0;

  void checkIndex(int index) {
    activeIndex = index;
    notifyListeners();
  }
}
