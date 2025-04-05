import 'package:flutter/material.dart';

class TextError extends StatelessWidget {
  const TextError({super.key, required this.errorMessage});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(errorMessage),
    );
  }
}
