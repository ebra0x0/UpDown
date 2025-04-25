import 'package:UpDown/core/utils/app_router.dart';
import 'package:UpDown/core/utils/service_locator.dart';
import 'package:UpDown/features/buildings/data/repo/buildings_repo_imp.dart';
import 'package:UpDown/features/elevators/data/repo/elevator_repo_imp.dart';
import 'package:UpDown/features/buildings/presentation/manager/buildings_cubit/buildings_cubit.dart';
import 'package:UpDown/features/elevators/presentation/manager/elevators_cubit/elevators_cubit.dart';
import 'package:UpDown/features/issues/data/repo/issues_repo_imp.dart';
import 'package:UpDown/features/issues/presentation/manager/issues_cubit/issues_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RootView extends StatelessWidget {
  final Widget child;
  const RootView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => BuildingsCubit(gitIt.get<BuildingsRepoImp>())),
        BlocProvider(
            create: (context) => ElevatorsCubit(gitIt.get<ElevatorRepoImp>())),
        BlocProvider(
            create: (context) => IssuesCubit(gitIt.get<IssuesRepoImp>())),
      ],
      child: Scaffold(
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
            BottomNavigationBarItem(
                icon: Icon(Icons.report), label: 'عطل جديد'),
          ],
        ),
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
