import 'package:UpDown/core/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: Styles.borderRadius8,
        boxShadow: [Styles.boxShadow],
      ),
      child: child,
    );
  }
}
