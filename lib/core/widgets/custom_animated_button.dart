import 'package:flutter/material.dart';

class CustomAnimatedButton extends StatefulWidget {
  const CustomAnimatedButton({super.key, required this.child});

  final Widget child;

  @override
  State<CustomAnimatedButton> createState() => _CustomAnimatedButtonState();
}

class _CustomAnimatedButtonState extends State<CustomAnimatedButton> {
  double _scale = 1;
  double _opacity = 1;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _scale,
      duration: Duration(milliseconds: 100),
      child: AnimatedOpacity(
        opacity: _opacity,
        duration: Duration(milliseconds: 100),
        child: GestureDetector(
          onTap: () {
            print("tap");
          },
          onTapDown: (d) {
            setState(() {
              _scale = .9;
              _opacity = .5;
            });
          },
          onTapUp: (d) {
            setState(() {
              _scale = 1;
              _opacity = 1;
            });
          },
          child: widget.child,
        ),
      ),
    );
  }
}
