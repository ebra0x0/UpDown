import 'package:UpDown/core/utils/pallete.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.child, this.padding = 16.0});

  final Widget child;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: Styles.borderRadius8),
      color: Pallete.lightCard,
      shadowColor: Color(0xFFE0E0E0),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Center(child: child),
      ),
    );
  }
}
