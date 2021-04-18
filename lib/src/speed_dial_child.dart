import 'package:flutter/material.dart';

class SpeedDialChild extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final Color? backgroundColor, foregroundColor;

  const SpeedDialChild(
      {Key? key,
      this.onPressed,
      this.child,
      this.backgroundColor,
      this.foregroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: child,
      mini: true,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
    );
  }
}
