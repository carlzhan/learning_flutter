import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class AnimationViewDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AnimationState();
  }

}

class _AnimationState extends State<AnimationViewDemo>
    with SingleTickerProviderStateMixin {

  static const padding = 16.0;

  AnimationController controller;
  Animation<double> left;
  Animation<Color> color;
  
  @override
  void initState() {
    super.initState();
    Future(_initState); //  相当于android中postDelay
  }

  void _initState() {
    controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 2000));

    // 通过MediaQuery获取屏幕宽度
    final mediaQueryData = MediaQuery.of(context);
    final displayWidth = mediaQueryData.size.width;
    debugPrint('width = $displayWidth');
    left =
    Tween(begin: padding, end: displayWidth - padding).animate(controller)
      ..addListener(() {
        setState(() {

        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
    
    color = ColorTween(begin: Colors.red,end: Colors.blue).animate(controller);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final unit = 24.0;
    final marginLeft = left == null ? padding : left.value;

    final unitizedLeft = (marginLeft - padding) / unit;
    final unitizedTop = math.sin(unitizedLeft);

    final marginTop = (unitizedTop + 1) * unit + padding;

    final color = this.color == null ? Colors.red : this.color.value;

    return Container(
      margin: EdgeInsets.only(left: marginLeft, top: marginTop),
      child: Container(
        decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(7.5),

        ),
        width: 15.0,
        height: 15.0,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}