import 'package:UpDown/core/di/dependancy_injection.dart';
import 'package:UpDown/core/theme/app_icons.dart';
import 'package:UpDown/core/theme/app_insets.dart';
import 'package:UpDown/core/theme/app_radius.dart';
import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/features/issues/presentation/manager/issues_cubit/issues_cubit.dart';
import 'package:UpDown/features/buildings/presentation/cubits/buildings_cubit/buildings_cubit.dart';
import 'package:UpDown/features/elevators/presentation/manager/elevators_cubit/elevators_cubit.dart';
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
          BlocProvider(create: (context) => getIt.get<BuildingsCubit>()),
          BlocProvider(create: (context) => getIt.get<ElevatorsCubit>()),
          BlocProvider(create: (context) => getIt.get<IssuesCubit>()),
        ],
        child: Scaffold(
          body: navigationShell,
          bottomNavigationBar: Visibility(
            visible: MediaQuery.of(context).viewInsets.bottom == 0,
            child: BottomNavigationBar(
              onTap: (value) {
                navigationShell.goBranch(value);
              },
              currentIndex: navigationShell.currentIndex,
              backgroundColor: AppTheme.tabBar,
              selectedItemColor: AppTheme.primary,
              unselectedItemColor: AppTheme.tabBarItem,
              items: [
                BottomNavigationBarItem(
                    activeIcon: CustomActiveNavBarItem(icon: AppIcons.homeIcon),
                    icon: AppIcons.homeIcon,
                    label: 'الرئيسية'),
                BottomNavigationBarItem(
                    activeIcon: CustomActiveNavBarItem(icon: AppIcons.addIcon),
                    icon: AppIcons.addIcon,
                    label: 'إنشاء عطل'),
                BottomNavigationBarItem(
                    activeIcon: CustomActiveNavBarItem(icon: AppIcons.userIcon),
                    icon: AppIcons.userIcon,
                    label: 'الحساب'),
              ],
            ),
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
      padding: AppInsets.v2,
      width: 60,
      decoration: BoxDecoration(
        color: AppTheme.primary.withValues(alpha: .2),
        borderRadius: AppRadius.borderRadius18,
      ),
      child: icon,
    );
  }
}
