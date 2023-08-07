import 'package:flutter/material.dart';
import 'package:najot_shop/data/models/order_model.dart';
import 'package:najot_shop/ui/tab_client/categories/basket_client_screen.dart';
import 'package:najot_shop/ui/tab_client/profile/profile_client_screen.dart';
import '../ui/tab_admin/favorites/favorites_screen.dart';
import '../ui/tab_client/product/products_client_screen.dart';

class TabProvider with ChangeNotifier {
  List<Widget> screens = [
    const ProductScreenClient(),
    const OrdersScreen(),
    const FavoritesScreen(),
    const ProfileScreenClient(),
  ];

  int activeIndex = 0;

  void checkIndex(int index) {
    activeIndex = index;
    notifyListeners();
  }
}
