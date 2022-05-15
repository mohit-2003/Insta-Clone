import 'package:flutter/material.dart';

class LikeAnimator extends StatefulWidget {
  final Widget child;
  final bool isAnimating;
  final Duration duration;
  final VoidCallback? onEnd;
  final bool isSmallLike;
  const LikeAnimator(
      {Key? key,
      required this.child,
      required this.isAnimating,
      this.duration = const Duration(milliseconds: 200),
      this.onEnd,
      required this.isSmallLike})
      : super(key: key);

  @override
  State<LikeAnimator> createState() => _LikeAnimatorState();
}

class _LikeAnimatorState extends State<LikeAnimator>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> scaleAnimation;
  @override
  void initState() {
    animationController = new AnimationController(
        vsync: this,
        duration: new Duration(milliseconds: widget.duration.inMilliseconds));
    scaleAnimation =
        Tween<double>(begin: 1, end: 1.2).animate(animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LikeAnimator oldWidget) {
    if (widget.isAnimating != oldWidget.isAnimating) {
      startAnimation();
    }
    super.didUpdateWidget(oldWidget);
  }

  startAnimation() async {
    if (widget.isAnimating || widget.isSmallLike) {
      await animationController.forward();
      await animationController.reverse();
      await Future.delayed(new Duration(milliseconds: 200));

      if (widget.onEnd != null) {
        widget.onEnd!();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new ScaleTransition(
      scale: scaleAnimation,
      child: widget.child,
    );
  }
}
