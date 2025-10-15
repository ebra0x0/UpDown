import 'package:UpDown/core/theme/app_skeleton.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/features/issues/presentation/manager/issues_cubit/issues_cubit.dart';
import 'package:UpDown/features/issues/presentation/widgets/issues_section/issue_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IssuesListViewBody extends StatelessWidget {
  const IssuesListViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ListViewBuilder();
  }
}

class _ListViewBuilder extends StatelessWidget {
  const _ListViewBuilder();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IssuesCubit, IssuesState>(
        buildWhen: (previous, current) => previous.issues != current.issues,
        builder: (context, state) => AppSkeletonizer(
              enabled: state.status == ContentStatus.loading,
              child: ListView.builder(
                  itemCount: state.issues!.length,
                  itemBuilder: (context, index) =>
                      IssueCard(issue: state.issues![index])),
            ));
  }
}
