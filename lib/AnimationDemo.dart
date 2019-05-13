import 'package:flutter/material.dart';
class AnimationDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'animation',
      home: Scaffold(
        appBar: AppBar(title: Text('animation'),),
        body: AnimWidget(),
      ),
    );
  }
}
// 动画是有状态的
class AnimWidget extends StatefulWidget {
  @override
  State createState() {
    return _AnimWidgetState();
  }
}

class _AnimWidgetState extends State<AnimWidget>
    with SingleTickerProviderStateMixin {

  var controller;
  CurvedAnimation curve;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 5000),
    );
    curve = CurvedAnimation( // 非线性效果动画
        parent: controller,
        curve: Curves.easeInOut);
    controller.forward(); // 执行动画
  }

  @override
  Widget build(BuildContext context) {
    var scaled = ScaleTransition( // 缩放效果
      child: FlutterLogo(size: 200.0),
      scale: curve,
    );
    return FadeTransition( // 淡出效果
      child: scaled, // 组合不同的动画
      opacity: curve,
    );
  }
}