import 'package:flutter/material.dart';
import 'package:najot_shop/providers/tab_provider.dart';
import 'package:najot_shop/providers/tab_provider_admin.dart';
import 'package:provider/provider.dart';

class TabBoxAdmin extends StatefulWidget {
  const TabBoxAdmin({super.key});

  @override
  State<TabBoxAdmin> createState() => _TabBoxAdminState();
}

class _TabBoxAdminState extends State<TabBoxAdmin> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TabAdminProvider>(context,listen: true);
    return Scaffold(
      body:IndexedStack(index: provider.activeIndex,children:provider.screens,) ,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: provider.activeIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Product"),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        onTap: (index){
          provider.checkIndex(index);
        },
      ),
    );
  }
}
