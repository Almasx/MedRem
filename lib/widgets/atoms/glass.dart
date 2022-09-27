import 'dart:ui';
import 'package:flutter/material.dart';

class Glass extends StatelessWidget {
  const Glass(
      {Key? key, required this.sigma, required this.child, this.borderRadius})
      : super(key: key);
  final double sigma;
  final Widget child;
  final BorderRadius? borderRadius;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: borderRadius!,
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
            child: child));
  }
}
