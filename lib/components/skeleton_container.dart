import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class SkeletonContainer extends StatelessWidget {
  final double width;
  final double height;

  const SkeletonContainer._({
    Key? key,
    this.width = double.infinity,
    this.height = double.infinity,
  }) : super(key: key);

  const SkeletonContainer.square({
    Key? key,
    required double width,
    required double height,
  }) : this._(width: width, height: height, key: key);

  @override
  Widget build(BuildContext context) => SkeletonAnimation(
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(color: Colors.grey[300]),
        ),
      );
}
