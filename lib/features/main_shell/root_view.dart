import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/manager/active_issues_cubit/active_issues_cubit.dart';
import 'package:UpDown/core/utils/service_locator.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/features/buildings/data/repo/buildings_repo_imp.dart';
import 'package:UpDown/features/elevators/data/repo/elevator_repo_imp.dart';
import 'package:UpDown/features/buildings/presentation/manager/buildings_cubit/buildings_cubit.dart';
import 'package:UpDown/features/elevators/presentation/manager/elevators_cubit/elevators_cubit.dart';
import 'package:UpDown/features/issues/data/repo/issues_repo_imp.dart';
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
              create: (context) =>
                  ActiveIssuesCubit(gitIt.get<IssuesRepoImp>())),
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
                        AppTheme.tabBar.withValues(alpha: .6),
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
                    child: Visibility(
                      visible: MediaQuery.of(context).viewInsets.bottom == 0,
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
                              activeIcon:
                                  CustomActiveNavBarItem(icon: Styles.homeIcon),
                              icon: Styles.homeIcon,
                              label: 'الرئيسية'),
                          BottomNavigationBarItem(
                              activeIcon:
                                  CustomActiveNavBarItem(icon: Styles.addIcon),
                              icon: Styles.addIcon,
                              label: 'إنشاء عطل'),
                          BottomNavigationBarItem(
                              activeIcon:
                                  CustomActiveNavBarItem(icon: Styles.userIcon),
                              icon: Styles.userIcon,
                              label: 'الحساب'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class CustomActiveNavBarItem extends StatelessWidget {
  const CustomActiveNavBarItem({super.key, required this.icon});
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2),
      width: 60,
      decoration: BoxDecoration(
        color: AppTheme.primary.withValues(alpha: .2),
        borderRadius: Styles.borderRadius18,
      ),
      child: icon,
    );
  }
}
