import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/service_locator.dart';
import 'package:UpDown/core/utils/styles.dart';
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
  const RootView({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  BuildingsCubit(gitIt.get<BuildingsRepoImp>())),
          BlocProvider(
              create: (context) =>
                  ElevatorsCubit(gitIt.get<ElevatorRepoImp>())),
          BlocProvider(
              create: (context) => IssuesCubit(gitIt.get<IssuesRepoImp>())),
        ],
        child: Scaffold(
          body: Stack(
            children: [
              navigationShell,
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.tabBar.withValues(alpha: 0),
                        AppTheme.tabBar,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      splashFactory: NoSplash.splashFactory,
                    ),
                    child: BottomNavigationBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      currentIndex: navigationShell.currentIndex,
                      onTap: (index) => navigationShell.goBranch(index),
                      selectedItemColor: AppTheme.primary,
                      unselectedItemColor:
                          AppTheme.tabBarItem.withValues(alpha: 0.7),
                      items: [
                        BottomNavigationBarItem(
                            icon: Styles.homeIcon, label: 'الرئيسية'),
                        BottomNavigationBarItem(
                            icon: Styles.addIcon, label: 'إنشاء عطل'),
                        BottomNavigationBarItem(
                            icon: Styles.userIcon, label: 'الحساب'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
