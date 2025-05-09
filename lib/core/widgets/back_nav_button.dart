import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BackButtonNavigation extends StatelessWidget {
  const BackButtonNavigation({
    super.key,
    this.route,
  });

  final String? route;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => context.pop(),
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 22,
        ));
  }
}
