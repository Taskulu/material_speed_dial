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
          final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Interval(((children.length - 1 - i) / children.length), 1,
                  curve: Curves.easeInOutCubic));
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Opacity(
                  opacity: curvedAnimation.value,
                  child: Center(child: children[i].label),
                ),
                SizedBox(width: 16),
                ScaleTransition(
                  scale: curvedAnimation,
                  child: SizedBox(
                      width: 56,
                      child: Center(
                          child: FloatingActionButton(
                        onPressed: () async {
                          invokeAfterClosing ? await close() : close();
                          children[i].onPressed?.call();
                        },
                        child: children[i].child,
                        foregroundColor: children[i].foregroundColor,
                        backgroundColor: children[i].backgroundColor,
                        mini: true,
                      ))),
                ),
              ],
            ),
          );
        }).toList(),
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
      ),
    );
  }
}
