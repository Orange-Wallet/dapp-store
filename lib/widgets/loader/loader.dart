import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatelessWidget {
  final double size;
  final Color color;

  const Loader({
    super.key,
    required this.size,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    return SpinKitFoldingCube(
      size: size,
      color: color,
    );
  }
}
