import 'package:flutter/material.dart';
import 'package:najot_shop/ui/tab_client/categories/category_client_screen.dart';
import 'package:najot_shop/ui/tab_client/order/order_screen.dart';
import 'package:najot_shop/ui/tab_client/profile/profile_client_screen.dart';
import '../ui/tab_admin/favorites/favorites_screen.dart';
import '../ui/tab_client/product/products_client_screen.dart';

class TabProvider with ChangeNotifier {
  List<Widget> screens = [
    const ProductScreenClient(),
    const CategoryScreenClient(),
    const OrdersScreen(),
    const ProfileScreenClient(),
  ];

  int activeIndex = 0;

  void checkIndex(int index) {
    activeIndex = index;
    notifyListeners();
  }
}
