import 'dart:async';

import 'package:flutter/cupertino.dart';

class SmoothRevealAnimation extends StatefulWidget {
  const SmoothRevealAnimation({
    required this.child,
    this.delay = 0,
    this.animationCurve = Curves.ease,
    this.animationDuration = 400,
    this.startOffset = const Offset(1.0, 0.0),
    Key? key,
  }) : super(key: key);

  final Widget child;
  final int delay;
  final Curve animationCurve;
  final int animationDuration;
  final Offset startOffset;

  @override
  State<StatefulWidget> createState() => _SmoothRevealAnimationState();
}

class _SmoothRevealAnimationState extends State<SmoothRevealAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animationOffset;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.animationDuration));
    final CurvedAnimation curve = CurvedAnimation(
        curve: widget.animationCurve, parent: _animationController);
    _animationOffset =
        Tween<Offset>(begin: widget.startOffset, end: Offset.zero)
            .animate(curve);

    Timer(Duration(milliseconds: widget.delay), () {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: SlideTransition(
        position: _animationOffset,
        child: widget.child,
      ),
      opacity: _animationController,
    );
  }
}
