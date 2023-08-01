import 'package:flutter/material.dart';
import 'package:najot_shop/ui/tab_admin/product/subscreen/add_product.dart';


class ProductScreenAdmin extends StatefulWidget {
  const ProductScreenAdmin({Key? key}) : super(key: key);

  @override
  State<ProductScreenAdmin> createState() => _ProductScreenAdminState();
}

class _ProductScreenAdminState extends State<ProductScreenAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Admin'),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductAddScreen()));
          }, icon: Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Expanded(child: ListView(
            children: [

            ],
          ))
        ],
      ),
    );
  }
}
