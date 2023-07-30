import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadData extends StatelessWidget {
  const LoadData({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0,
      height: 100.0,
      child: Shimmer.fromColors(
        baseColor: Colors.deepPurpleAccent,
        highlightColor: Colors.white,
        child: const Center(
          child: Text(
            'Loading...',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight:
              FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}