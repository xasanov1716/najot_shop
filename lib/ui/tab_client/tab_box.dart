import 'package:flutter/material.dart';
import 'package:najot_shop/providers/tab_provider.dart';
import 'package:provider/provider.dart';

class TabBox extends StatefulWidget {
  const TabBox({super.key});

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TabProvider>(context,listen: true);
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
