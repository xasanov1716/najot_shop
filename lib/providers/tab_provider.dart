import 'package:flutter/material.dart';
import 'package:najot_shop/ui/tab/categories/categories_screen.dart';

import '../ui/tab/product/product_screen.dart';
import '../ui/tab/profile/profile_screen.dart';

class TabProvider with ChangeNotifier{


  List<Widget> screens = [const HomeScreen(), const Categories(),const ProfileScreen()];

  int activeIndex = 0;

  void checkIndex(int index) {
    activeIndex = index;
    notifyListeners();

  }
}