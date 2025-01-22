import 'package:UpDown/core/utils/styles.dart';
import 'package:flutter/material.dart';

class BuildingsGridViewError extends StatelessWidget {
  const BuildingsGridViewError({
    super.key,
    required this.errorMsg,
  });

  final String errorMsg;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorMsg,
        style: Styles.textStyle20,
      ),
    );
  }
}
