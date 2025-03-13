import 'package:UpDown/core/utils/app_router.dart';
import 'package:UpDown/core/utils/status_handler.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/bubble_status.dart';
import 'package:UpDown/core/widgets/loading_indicator.dart';
import 'package:UpDown/features/root/home/presentation/manager/active_issues_cubit/cubit/active_issues_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ActiveIssuesSection extends StatelessWidget {
  const ActiveIssuesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "الأعطال الحالية",
          style: Styles.textStyle18,
        ),
        BlocBuilder<ActiveIssuesCubit, ActiveIssuesState>(
          builder: (context, state) {
            if (state is ActiveIssuesLoaded) {
              return Expanded(
                child: ActiveIssuesListView(
                  state: state,
                ),
              );
            } else if (state is ActiveIssuesError) {
              return Center(
                child: Text(state.error),
              );
            } else {
              return DataLoadingIndicator();
            }
          },
        ),
      ],
    );
  }
}

class ActiveIssuesListView extends StatelessWidget {
  const ActiveIssuesListView({
    super.key,
    required this.state,
  });
  final ActiveIssuesLoaded state;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: state.activeIssues.length,
      itemBuilder: (context, index) {
        if (index >= state.activeIssues.length) {
          return const Center(
            child: DataLoadingIndicator(),
          );
        }
        final issue = state.activeIssues[index];
        return ListTile(
          onTap: () =>
              context.push('${AppRouter.khomeView}/issueView', extra: issue),
          title: Text(
            StatusHandler.fromIssueStatus(
              status: issue.status!,
              issueType: issue.issueType,
            ).title,
          ),
          subtitle: const Text("الماسة , المصعد:1"),
          leading: BubbleStatus(status: issue.status!),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.grey,
          ),
        );
      },
    );
  }
}
