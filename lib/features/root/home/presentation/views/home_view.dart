import 'package:UpDown/features/root/home/presentation/views/widgets/home_widgets/home_view_body.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'أنت تدير',
          style: TextStyle(
            color: Color.fromARGB(221, 34, 34, 34),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const HomeViewBody(),
    );
  }
}
