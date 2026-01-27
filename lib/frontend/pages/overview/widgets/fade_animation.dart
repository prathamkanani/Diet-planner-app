import 'package:flutter/material.dart';

class FadingAnimation extends StatefulWidget {
  final Duration duration;

  final Widget child;

  final Duration delay;

  final bool? needSliding;

  const FadingAnimation({
    super.key,
    this.duration = const Duration(milliseconds: 1000),
    required this.child,
    required this.delay,
    this.needSliding = true,
  });

  @override
  State<FadingAnimation> createState() => _FadingAnimationState();
}

class _FadingAnimationState extends State<FadingAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<Offset> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: widget.duration);

    animation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

    Future.delayed(widget.delay).then((_) {
      controller.forward();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: controller,
      child: widget.needSliding!
          ? SlideTransition(position: animation, child: widget.child)
          : widget.child,
    );
  }
}
