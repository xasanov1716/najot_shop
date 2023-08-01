import 'package:flutter/material.dart';
import 'package:najot_shop/ui/tab_admin/product/products_screen.dart';

import '../ui/tab_admin/categories/category_screen.dart';
import '../ui/tab_admin/favorites/favorites_screen.dart';
import '../ui/tab_admin/profile/profile_screen.dart';
import '../ui/tab_client/product/products_screen.dart';

class TabAdminProvider with ChangeNotifier {
  List<Widget> screens = [
    const ProductScreenAdmin(),
    const CategoryScreenAdmin(),
    const FavoritesScreen(),
    const ProfileScreenAdmin(),
  ];

  int activeIndex = 0;

  void checkIndex(int index) {
    activeIndex = index;
    notifyListeners();
  }
}
