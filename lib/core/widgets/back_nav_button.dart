import 'package:flutter/material.dart';

class BackNavigationButton extends StatelessWidget {
  const BackNavigationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios)));
  }
}
