import 'package:UpDown/core/utils/pallete.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BackButtonNavigation extends StatelessWidget {
  const BackButtonNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pop(),
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: Pallete.lightPrimary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(21),
        ),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 20,
          color: Pallete.lightText,
        ),
      ),
    );
  }
}
