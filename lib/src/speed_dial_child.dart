import 'package:flutter/material.dart';

class SpeedDialChild {
  final VoidCallback? onPressed;
  final Widget? child, label;
  final Color? backgroundColor, foregroundColor;

  SpeedDialChild(
      {this.onPressed,
      this.child,
      this.label,
      this.backgroundColor,
      this.foregroundColor});
}