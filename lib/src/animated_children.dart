import 'package:flutter/material.dart';
import 'speed_dial_child.dart';

class AnimatedChildren extends StatelessWidget {
  final Animation<double> animation;
  final List<SpeedDialChild> children;
  final Future Function() close;
  final bool invokeAfterClosing;

  const AnimatedChildren({
    Key? key,
    required this.animation,
    required this.children,
    required this.close,
    required this.invokeAfterClosing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) => Column(
        children: List.generate(children.length, (i) => i).map((i) {
          final speedDialChild = children[i];
          final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Interval(((children.length - 1 - i) / children.length), 1,
                  curve: Curves.easeInOutCubic));

          onPressed() async {
            invokeAfterClosing ? await close() : close();
            speedDialChild.onPressed?.call();
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: onPressed,
              child: Row(
                children: [
                  Opacity(
                    opacity: curvedAnimation.value,
                    child: Center(child: speedDialChild.label),
                  ),
                  SizedBox(width: 16),
                  ScaleTransition(
                    scale: curvedAnimation,
                    child: Container(
                      width: 56,
                      alignment: Alignment.center,
                      child: FloatingActionButton(
                        onPressed: onPressed,
                        child: speedDialChild.child,
                        foregroundColor: speedDialChild.foregroundColor,
                        backgroundColor: speedDialChild.backgroundColor,
                        mini: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
      ),
    );
  }
}
