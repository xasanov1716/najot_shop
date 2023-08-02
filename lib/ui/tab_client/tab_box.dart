import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:najot_shop/providers/tab_provider.dart';
import 'package:najot_shop/utils/app_colors.dart';
import 'package:provider/provider.dart';

class TabBoxClient extends StatefulWidget {
  const TabBoxClient({super.key});

  @override
  State<TabBoxClient> createState() => _TabBoxClientState();
}

class _TabBoxClientState extends State<TabBoxClient> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TabProvider>(context,listen: true);
    return Scaffold(
      body:IndexedStack(index: provider.activeIndex,children:provider.screens,) ,
      bottomNavigationBar: CurvedNavigationBar(
        index: provider.activeIndex,
        color: AppColors.globalActive,
        backgroundColor: AppColors.white,
        items: [
          Icon(Icons.shopping_cart,color: AppColors.white),
          Icon(Icons.shopping_basket,color: AppColors.white),
          Icon(Icons.favorite,color: AppColors.white),
          Icon(Icons.account_circle,color: AppColors.white),
        ],
        onTap: (index){
          provider.checkIndex(index);
        },
      ),
    );
  }
}
