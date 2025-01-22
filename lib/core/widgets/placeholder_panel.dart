import 'package:UpDown/core/utils/styles.dart';
import 'package:flutter/material.dart';

class PlaceholderPanel extends StatelessWidget {
  const PlaceholderPanel({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: Styles.textStyle20,
      ),
    );
  }
}
