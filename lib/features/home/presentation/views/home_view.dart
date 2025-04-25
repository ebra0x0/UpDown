import 'package:UpDown/features/buildings/presentation/manager/buildings_cubit/buildings_cubit.dart';
import 'package:UpDown/features/issues/presentation/manager/issues_cubit/issues_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/home_view_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    context.read<BuildingsCubit>().call();
    context.read<IssuesCubit>().fetchActiveIssues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              'أنت تدير',
              style: TextStyle(
                color: Color.fromARGB(221, 34, 34, 34),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: const HomeViewBody());
  }
}
