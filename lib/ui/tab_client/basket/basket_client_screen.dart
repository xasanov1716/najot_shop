import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:najot_shop/ui/tab_client/widget/global_shimmer.dart';
import 'package:najot_shop/utils/app_colors.dart';
import 'package:provider/provider.dart';
import '../../../data/models/order_model.dart';
import '../../../providers/order_provider.dart';
import 'basket_datail_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Basket"),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.70,
                child: StreamBuilder<List<OrderModel>>(
                  stream: context
                      .read<OrderProvider>()
                      .listenOrdersList(FirebaseAuth.instance.currentUser!.uid),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<OrderModel>> snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data!.isNotEmpty
                          ? ListView(
                              children: List.generate(
                                snapshot.data!.length,
                                (index) {
                                  OrderModel orderModel = snapshot.data![index];
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.h, horizontal: 5.w),
                                    margin: EdgeInsets.symmetric(
                                        vertical: 10.h, horizontal: 15.w),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16.r),
                                        color: AppColors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            offset: const Offset(0, 5),
                                            color: AppColors.globalPassive
                                                .withOpacity(0.5),
                                            blurRadius: 5,
                                            spreadRadius: 3,
                                          )
                                        ]),
                                    child: ListTile(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  OrderDetailScreen(
                                                orderModel: orderModel,
                                              ),
                                            ),
                                          );
                                        },
                                        title: Text(
                                          orderModel.productName,
                                          style: TextStyle(
                                              fontSize: 24.spMin,
                                              color: AppColors.darkColor,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        subtitle: Text(
                                          "Count: ${orderModel.count} Total: ${orderModel.totalPrice} USD",
                                          style: TextStyle(
                                            fontSize: 18.spMin,
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        trailing: IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                backgroundColor: Colors.white,
                                                content: const Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 10),
                                                  child: Text(
                                                    "Delete Order",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                actions: [
                                                  CupertinoDialogAction(
                                                    onPressed: () {
                                                      context
                                                          .read<OrderProvider>()
                                                          .deleteOrder(
                                                            context: context,
                                                            orderId: orderModel
                                                                .orderId,
                                                          );
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    isDefaultAction: true,
                                                    child: const Text("ok"),
                                                  ),
                                                  CupertinoDialogAction(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    isDefaultAction: true,
                                                    child: const Text("cancel"),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        )),
                                  );
                                },
                              ),
                            )
                          : Center(
                              child: Text(
                              "Empty!",
                              style: TextStyle(
                                  fontSize: 32.spMin,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ));
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }
                    return const Center(child: Loading());
                  },
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
              margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
              height: 53.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: AppColors.globalActive,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Jami: ",
                    style: TextStyle(
                        fontSize: 24.spMin,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    Provider.of<OrderProvider>(context,listen: true)
                        .getOrdersPrice()
                        .toString(),
                    style: TextStyle(
                        fontSize: 24.spMin,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
