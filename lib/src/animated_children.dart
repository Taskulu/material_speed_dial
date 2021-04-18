import 'package:flutter/material.dart';
import 'speed_dial_child.dart';

class AnimatedChildren extends StatelessWidget {
  final Animation<double> animation;
  final List<SpeedDialChild> children;
  final List<Widget> labels;

  const AnimatedChildren(
      {Key? key,
      required this.animation,
      required this.children,
      required this.labels})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) => Column(
        children: List.generate(children.length, (i) => i)
            .map((i) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Opacity(
                        opacity: CurvedAnimation(
                                parent: animation,
                                curve: Interval(
                                    ((labels.length - 1 - i) / labels.length),
                                    1,
                                    curve: Curves.easeInOutCubic))
                            .value,
                        child: Center(child: labels[i]),
                      ),
                      SizedBox(width: 16),
                      ScaleTransition(
                        scale: CurvedAnimation(
                            parent: animation,
                            curve: Interval(
                                ((children.length - 1 - i) / children.length),
                                1,
                                curve: Curves.easeInOutCubic)),
                        child: SizedBox(width: 56, child: Center(child: children[i])),
                      ),
                    ],
                  ),
                ))
            .toList(),
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
      ),
    );
  }
}
