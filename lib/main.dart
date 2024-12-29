import 'package:UpDown/core/utils/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const UpDown());
}

class UpDown extends StatelessWidget {
  const UpDown({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
