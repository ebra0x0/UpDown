import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/widgets/bottom_nav_bar.dart';
import 'widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الرئيسية',
          style: TextStyle(
            color: Color.fromARGB(221, 34, 34, 34),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const HomeViewBody(),
      bottomNavigationBar: BottomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).push(AppRouter.kcreateReportView);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
