import 'package:UpDown/features/buildings/presentation/manager/buildings_cubit/buildings_cubit.dart';
import 'package:UpDown/core/utils/manager/active_issues_cubit/active_issues_cubit.dart';
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
    context.read<BuildingsCubit>().call();
    context.read<ActiveIssuesCubit>().fetchAllActive();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const HomeViewBody());
  }
}
