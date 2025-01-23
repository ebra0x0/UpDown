import 'package:UpDown/features/home/presentation/manager/buildings_cubit/cubit/buildings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/widgets/bottom_nav_bar.dart';
import 'widgets/home_widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BuildingsCubit>(
      create: (context) => BuildingsCubit()..getBuildings(),
      child: Scaffold(
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
        bottomNavigationBar: BottomNavBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            GoRouter.of(context).push(AppRouter.kcreateReportView);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
