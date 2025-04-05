import 'package:flutter/material.dart';

class BubbleStatus extends StatelessWidget {
  const BubbleStatus({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withValues(alpha: 0.2),
        ),
        child: Icon(
          Icons.circle,
          color: color,
          size: 12,
        ));
  }
}
