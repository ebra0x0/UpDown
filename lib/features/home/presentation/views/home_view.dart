import 'package:flutter/material.dart';

import '../../../../core/widgets/bottom_nav_bar.dart';
import 'widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
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
      ),
    );
  }
}
