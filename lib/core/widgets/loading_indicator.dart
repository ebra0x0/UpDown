import 'package:UpDown/core/utils/pallete.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:flutter/material.dart';

class DataLoadingIndicator extends StatelessWidget {
  const DataLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: Styles.borderRadius8,
          color: Pallete.secondary.withValues(alpha: 0.1),
        ),
      ),
    );
  }
}
