import 'package:flutter/material.dart';

import '../../ui/tab_admin/widget/product_shimmer.dart';


void showLoading({required BuildContext context}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0.5),
        child: const LoadData()
      );
    },
  );
}

void hideLoading({required BuildContext? dialogContext}) async {
  if (dialogContext != null) Navigator.pop(dialogContext);
}
