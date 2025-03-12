import 'package:UpDown/core/utils/status_handler.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/bubble_status.dart';
import 'package:UpDown/core/widgets/loading_indicator.dart';
import 'package:UpDown/features/root/home/presentation/manager/active_issues_cubit/cubit/active_issues_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.activeIssues.length,
                  itemBuilder: (context, index) => ListTile(
                    onTap: () => {},
                    title: Text(
                      StatusHandler.fromIssueStatus(
                        status: state.activeIssues[index].status!,
                        issueType: state.activeIssues[index].issueType,
                      ).title,
                    ),
                    subtitle: Text(
                      "الماسة , المصعد:1",
                    ),
                    leading:
                        BubbleStatus(status: state.activeIssues[index].status!),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.grey,
                    ),
                  ),
                ),
              );
            } else {
              return const Center(
                child: DataLoadingIndicator(),
              );
            }
          },
        ),
      ],
    );
  }
}
