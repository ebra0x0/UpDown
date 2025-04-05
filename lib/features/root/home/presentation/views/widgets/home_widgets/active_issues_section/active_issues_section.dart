import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/loading_indicator.dart';
import 'package:UpDown/features/root/home/presentation/manager/active_issues_cubit/cubit/active_issues_cubit.dart';
import 'package:UpDown/features/root/home/presentation/views/widgets/home_widgets/active_issues_section/active_issues_list_view.dart';
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
