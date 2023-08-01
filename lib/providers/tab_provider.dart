import 'package:flutter/material.dart';
import 'package:najot_shop/ui/tab_client/categories/category_screen.dart';
import 'package:najot_shop/ui/tab_client/profile/profile_screen.dart';
import '../ui/tab_admin/favorites/favorites_screen.dart';
import '../ui/tab_client/product/products_screen.dart';

class TabProvider with ChangeNotifier {
  List<Widget> screens = [
    const ProductScreenClient(),
    const CategoryScreen(),
    const FavoritesScreen(),
    const ProfileScreen(),
  ];

  int activeIndex = 0;

  void checkIndex(int index) {
    activeIndex = index;
    notifyListeners();
  }
}
