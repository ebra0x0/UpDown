import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({super.key, required this.title, this.textSize = 20});

  final String title;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Text(title,
          style: TextStyle(fontSize: textSize, fontWeight: FontWeight.bold)),
    );
  }
}
