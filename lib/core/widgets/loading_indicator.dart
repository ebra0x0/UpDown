import 'package:UpDown/core/utils/pallete.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator(
      {super.key, this.color = Pallete.lightPrimary, this.size = 24});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              color: color,
            )));
  }
}
