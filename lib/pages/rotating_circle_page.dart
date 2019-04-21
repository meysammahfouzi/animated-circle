import 'package:flutter/material.dart';
import 'dart:math' as math;

class RotatingCirclePage extends StatefulWidget {
  @override
  _RotatingCirclePageState createState() => _RotatingCirclePageState();
}

class _RotatingCirclePageState extends State<RotatingCirclePage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(
        seconds: 2,
      ),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    );
    animationController.addStatusListener(animationStatusListener);
    animationController.forward();
  }


  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  void animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      animationController.reverse();
    } else if (status == AnimationStatus.dismissed) {
      animationController.forward();
    }
  }

  Widget _buildCircle(radius) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
        color: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rotating Circle"),
      ),
      body: AnimatedBuilder(
        child: Align(
          alignment: Alignment(0, -0.1),
          child: _buildCircle(30.0),
        ),
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          return Transform.rotate(
            child: child,
            angle: math.pi * 2 * animation.value,
            origin: Offset(0, 30),
          );
        },
      ),
    );
  }
}
