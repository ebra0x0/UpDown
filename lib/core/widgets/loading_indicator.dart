import 'package:UpDown/core/utils/pallete.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: const CircularProgressIndicator(
      color: Pallete.backgroundDark,
    ));
  }
}
