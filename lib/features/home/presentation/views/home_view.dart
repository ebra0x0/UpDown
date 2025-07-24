import 'package:UpDown/core/network/network_cubit.dart';
import 'package:UpDown/core/theme/app_icons.dart';
import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/extensions/icon_ext.dart';
import 'package:UpDown/core/widgets/screen_echo.dart';
import 'package:UpDown/features/buildings/presentation/cubits/buildings_cubit/buildings_cubit.dart';
import 'package:UpDown/features/issues/presentation/manager/issues_cubit/issues_cubit.dart';
import 'package:UpDown/features/home/presentation/widgets/home_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    context.read<BuildingsCubit>().listenToBuildings();
    context.read<IssuesCubit>().fetchAllActive();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<NetworkCubit, NetworkStatus>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) => state == NetworkStatus.disconnected
                ? const OfflineHomeViewBody()
                : const HomeViewBody()));
  }
}

class OfflineHomeViewBody extends StatelessWidget {
  const OfflineHomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScreenEcho(
        icon: AppIcons.offlineIcon.copyWith(color: AppTheme.red),
        message: "لا يوجد اتصال بالانترنت",
      ),
    );
  }
}
