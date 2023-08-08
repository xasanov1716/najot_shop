import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:najot_shop/utils/app_colors.dart';

import '../../../data/models/order_model.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key, required this.orderModel});

  final OrderModel orderModel;

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Info"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                physics: const ScrollPhysics(),
                children: [
                  Text(
                    widget.orderModel.productName,
                    style: TextStyle(
                      fontSize: 32.spMin,
                      color: AppColors.globalPassive,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Count: ${widget.orderModel.count}",
                    style: TextStyle(
                      fontSize: 22.spMin,
                      color: AppColors.globalPassive,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Total Price: ${widget.orderModel.totalPrice}",
                    style: TextStyle(
                        fontSize: 22.spMin,
                        color: AppColors.globalPassive,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Created: ${widget.orderModel.createdAt.substring(0, 10)}",
                    style: TextStyle(
                        fontSize: 22.spMin,
                        color: AppColors.globalPassive,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
