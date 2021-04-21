import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'speed_dial_child.dart';
import 'animated_children.dart';
import 'animated_fab.dart';

class SpeedDial extends StatefulWidget {
  final Widget? child, expandedChild;
  final List<SpeedDialChild> children;
  final Color? backgroundColor,
      expandedBackgroundColor,
      foregroundColor,
      expandedForegroundColor,
      overlayColor;
  final Duration animationDuration;

  const SpeedDial({
    Key? key,
    this.child,
    this.expandedChild,
    this.children = const [],
    this.backgroundColor,
    this.expandedBackgroundColor,
    this.foregroundColor,
    this.expandedForegroundColor,
    this.animationDuration = const Duration(milliseconds: 300),
    this.overlayColor,
  }) : super(key: key);

  @override
  _SpeedDialState createState() => _SpeedDialState();
}

class _SpeedDialState extends State<SpeedDial>
    with SingleTickerProviderStateMixin {
  GlobalKey _key = GlobalKey();
  bool _isOpen = false;
  OverlayEntry? _overlayEntry;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: widget.animationDuration);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _overlayEntry?.remove();
    _overlayEntry?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _isOpen ? 0 : 1,
      child: FloatingActionButton(
        key: _key,
        onPressed: _open,
        child: widget.child,
        foregroundColor: widget.foregroundColor,
        backgroundColor: widget.backgroundColor,
      ),
    );
  }

  bool get isOpen => _isOpen;

  toggle() => _isOpen ? _close() : _open();

  _open() {
    if (_isOpen) {
      return;
    }
    setState(() {
      _isOpen = true;
    });
    _overlayEntry?.remove();
    _overlayEntry = _buildOverlay();
    Overlay.of(context, rootOverlay: true)?.insert(_overlayEntry!);
    _controller.animateTo(1);
  }

  _close() {
    if (!_isOpen) {
      return;
    }
    _controller.animateTo(0).whenComplete(() {
      _overlayEntry?.remove();
      _overlayEntry = null;
      setState(() {
        _isOpen = false;
      });
    });
  }

  OverlayEntry _buildOverlay() {
    RenderBox? box = _key.currentContext?.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero);

    final overlayBackgroundColorTween = ColorTween(
        begin: Colors.transparent,
        end: widget.overlayColor ?? Colors.black.withOpacity(0.5));
    final _animation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic);

    return OverlayEntry(
        builder: (context) => Material(
              type: MaterialType.transparency,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: _close,
                    child: AnimatedBuilder(
                      animation: _animation,
                      builder: (context, _) => Container(
                        color:
                            overlayBackgroundColorTween.lerp(_animation.value),
                      ),
                    ),
                  ),
                  Positioned(
                      top: position.dy,
                      left: position.dx,
                      child: AnimatedFAB(
                        animation: _animation,
                        expandedChild: widget.expandedChild,
                        backgroundColor: widget.backgroundColor,
                        child: widget.child,
                        expandedBackgroundColor: widget.expandedBackgroundColor,
                        foregroundColor: widget.foregroundColor,
                        expandedForegroundColor: widget.expandedForegroundColor,
                        onClosePressed: _close,
                      )),
                  Positioned(
                    top: 0,
                    bottom:
                        MediaQuery.of(context).size.height - position.dy + 4,
                    right: MediaQuery.of(context).size.width - position.dx - box.size.width,
                    child: AnimatedChildren(
                      animation: _controller,
                      children: widget.children,
                      close: _close,
                    ),
                  )
                ],
              ),
            ));
  }
}
