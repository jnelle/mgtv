import 'package:flutter/material.dart';
import 'package:mgtv/ui/components/shimmer/skeleton.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({
    Key? key,
    required this.height,
  }) : super(key: key);
  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: const Shimmer(
        gradient: LinearGradient(
          colors: <Color>[
            Color(0xFFEBEBF4),
            Color(0xFFF4F4F4),
            Color(0xFFEBEBF4),
          ],
          stops: <double>[
            0.1,
            0.3,
            0.4,
          ],
          begin: Alignment(-1.0, -0.3),
          end: Alignment(1.0, 0.3),
          tileMode: TileMode.clamp,
        ),
        child: Skeleton(
          height: 300,
        ),
      ),
    );
  }
}
