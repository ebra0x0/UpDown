import 'package:UpDown/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RootView extends StatelessWidget {
  final Widget child;
  const RootView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _getCurrentIndex(context),
        onTap: (index) {
          switch (index) {
            case 0:
              context.go(AppRouter.khomeView);
              break;
            case 1:
              context.go(AppRouter.kcreateIssueView);
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.report), label: 'عطل جديد'),
        ],
      ),
    );
  }

  int _getCurrentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith(AppRouter.khomeView)) return 0;
    if (location.startsWith(AppRouter.kcreateIssueView)) return 1;
    return 0;
  }
}
