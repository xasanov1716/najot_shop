import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
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
      bottomNavigationBar: CurvedNavigationBar(
        index: provider.activeIndex,
        color: Colors.deepPurple,
        backgroundColor: Colors.white,
        items: const [
          Icon(Icons.shopping_cart,color: Colors.white),
          Icon(Icons.category,color: Colors.white),
          Icon(Icons.account_circle,color: Colors.white),
        ],
        onTap: (index){
          provider.checkIndex(index);
        },
      ),
    );
  }
}
