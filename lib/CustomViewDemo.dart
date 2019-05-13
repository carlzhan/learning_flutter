import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomViewDemo extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CustomViewDemoState();
  }

}

class _CustomViewDemoState extends State<CustomViewDemo>
    with SingleTickerProviderStateMixin {

  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 2000))
      ..repeat()
      ..addListener(() {
        setState(() {

        });
      })
    ;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: _controller,
      builder: (context, child) {
        return Container(
          child: CustomPaint(
              painter: DemoPainter(
                Tween(begin: math.pi * 1.5, end: math.pi * 3.5)
                    .chain(CurveTween(curve: Interval(0.5, 1.0)))
                    .evaluate(_controller),
                math.sin(
                    Tween(begin: 0.0, end: math.pi).evaluate(_controller)) *
                    math.pi,)),
          height: 200.0,
          width: 200.0,
          color: Colors.deepOrange,
          padding: EdgeInsets.all(30.0),
        );
      },
    );
  }
}

class DemoPainter extends CustomPainter {
  final double _arcStart;
  final double _arcSweep;

  DemoPainter(this._arcStart, this._arcSweep);

  @override
  void paint(Canvas canvas, Size size) {
    double side = math.min(size.width, size.height);
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
        Offset.zero & Size(side, side), _arcStart, _arcSweep, false, paint);
  }

  @override
  bool shouldRepaint(DemoPainter other) {
    return _arcStart != other._arcStart || _arcSweep != other._arcSweep;
  }
}