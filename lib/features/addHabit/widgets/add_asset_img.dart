import 'package:flutter/material.dart';
import 'package:flutter_habit_tracker/core/constants/my_size.dart';

class AddAssetImg extends StatelessWidget {
  final double height;
  final String src;
  final double opacity;
  const AddAssetImg({
    super.key,
    required this.src,
    this.height = 150,
    this.opacity = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Image.asset(
        src,
        height: MySizes.imageCarouselHeight,
        fit: BoxFit.contain,
      ),
    );
  }
}
