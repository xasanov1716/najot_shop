import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 100,
      child: Shimmer.fromColors(
        baseColor: Colors.deepPurpleAccent,
        highlightColor: Colors.white,
        child: const Center(
          child: Text(
            'Loading...',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight:
              FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}