
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:najot_shop/ui/tab_admin/product/subscreen/add_product.dart';
import 'package:provider/provider.dart';

import '../../../data/models/products_data_model.dart';
import '../../../providers/product_provider.dart';

class ProductScreenAdmin extends StatefulWidget {
  const ProductScreenAdmin({super.key});

  @override
  State<ProductScreenAdmin> createState() => _ProductScreenAdminState();
}

class _ProductScreenAdminState extends State<ProductScreenAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products Admin"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ProductAddScreen();
                  },
                ),
              );
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: StreamBuilder<List<ProductModel>>(
          stream: context.read<ProductsProvider>().getProductsBbyCategory(),
          builder:
              (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!.isNotEmpty
                  ? GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.5,
                  crossAxisSpacing: 10,mainAxisSpacing: 10,
                ),
                children: List.generate(
                  snapshot.data!.length,
                      (index) {
                    ProductModel productModel = snapshot.data![index];
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.w,vertical: 15.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: Colors.blue.withOpacity(0.8)
                      ),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: CachedNetworkImage(
                            height: 50.h,
                            width: 50.h,
                            imageUrl: productModel.productImages.first,
                            placeholder: (context, url) => const CupertinoActivityIndicator(),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                        ),
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              backgroundColor: Colors.white,
                              content:const Padding(
                                padding:  EdgeInsets.only(top: 10),
                                child: Text(
                                  "Delete Product",
                                  style:
                                  TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
                                ),
                              ),
                              actions: [
                                CupertinoDialogAction(
                                  onPressed: () {
                                    context.read<ProductsProvider>().deleteProduct(
                                      context: context,
                                      productId: productModel.productId,
                                    );
                                    Navigator.of(context).pop();
                                  },
                                  isDefaultAction: true,
                                  child: const Text("ok"),
                                ),
                                CupertinoDialogAction(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  isDefaultAction: true,
                                  child: const Text("cancel"),
                                ),

                              ],
                            ),
                          );
                        },
                        title: Text(productModel.productName,style: TextStyle(fontSize: 24.spMin,color: Colors.white,fontWeight: FontWeight.w700),),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(productModel.description,style: TextStyle(fontSize: 18.spMin,color: Colors.white,fontWeight: FontWeight.w500),),
                            Text("Price: ${productModel.price} ${productModel.currency}",style: TextStyle(fontSize: 18.spMin,color: Colors.white,fontWeight: FontWeight.w500),),
                            Text("Count: ${productModel.count}",style: TextStyle(fontSize: 18.spMin,color: Colors.white,fontWeight: FontWeight.w500),),
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return  ProductAddScreen(
                                    productModel: productModel,
                                  );
                                },
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit,color: Colors.white,),
                        ),
                      ),
                    );
                  },
                ),
              )
                  :  Center(child: Text("Product Empty!",style: TextStyle(fontSize: 32.spMin,color: Colors.white,fontWeight: FontWeight.w700),));
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}