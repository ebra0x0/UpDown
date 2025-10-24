import 'package:UpDown/core/theme/app_icons.dart';
import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/enums/app_route.dart';
import 'package:UpDown/core/utils/extensions/icon_ext.dart';
import 'package:UpDown/features/auth/ui/cubit/auth_cubit.dart';
import 'package:UpDown/features/buildings/presentation/cubits/buildings_cubit/buildings_cubit.dart';
import 'package:UpDown/features/elevators/presentation/manager/elevators_cubit/elevators_cubit.dart';
import 'package:UpDown/features/issues/presentation/manager/issues_cubit/issues_cubit.dart';
import 'package:UpDown/features/home/presentation/widgets/home_view_body.dart';
import 'package:UpDown/features/maintenances/presentation/cubit/maintenance_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    context.read<BuildingsCubit>().emitStreamAll();
    context.read<ElevatorsCubit>().emitStreamAll();
    context.read<IssuesCubit>().emitStreamAllActiveIssues();
    context.read<MaintenanceCubit>().emitStreamCurrentMaintenance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const _AppDrawer(),
      body: const HomeViewBody(),
    );
  }
}

class _AppDrawer extends StatelessWidget {
  const _AppDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 0.7.sw,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppTheme.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 28.r,
                  backgroundColor: AppTheme.white,
                  child: AppIcons.userIcon
                      .copyWith(color: AppTheme.blue, size: 32),
                ),
                const SizedBox(height: 12),
                Text(
                  'مرحبا بك 👋',
                  style:
                      AppTextStyles.textStyle16.copyWith(color: Colors.white),
                ),
                Text(
                  'لوحة التحكم',
                  style:
                      AppTextStyles.textStyle14.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            leading: AppIcons.maintenanceIcon.copyWith(size: 18),
            title: const Text('قائمة الصيانات'),
            onTap: () {
              context.pop();
              context
                  .push("${AppRoute.home.path}${AppRoute.maintenances.path}");
            },
          ),
          ListTile(
            leading: AppIcons.reportProblemIcon,
            title: const Text('قائمة الأعطال'),
            onTap: () {
              context.pop();
              context.push("${AppRoute.home.path}${AppRoute.issues.path}");
            },
          ),
          Divider(
            thickness: .3.sp,
            color: AppTheme.grey,
          ),
          ListTile(
            leading: AppIcons.logoutIcon,
            title: const Text('تسجيل الخروج'),
            onTap: () async {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: const Text('تأكيد تسجيل الخروج'),
                      content:
                          const Text('هل أنت متأكد أنك تريد تسجيل الخروج؟'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            context.pop();
                          },
                          child: const Text('إلغاء'),
                        ),
                        TextButton(
                          onPressed: () async {
                            context.pop();
                            await context.read<AuthCubit>().signOut(context);
                          },
                          child: const Text('تأكيد'),
                        ),
                      ],
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}
