import 'package:UpDown/core/theme/app_insets.dart';
import 'package:UpDown/core/widgets/custom_sliver_app_bar.dart';
import 'package:UpDown/features/issues/presentation/manager/issue_details_cubit/issue_details_cubit.dart';
import 'package:UpDown/features/issues/presentation/widgets/issue_details_widgets/issue_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IssueViewBuilder extends StatelessWidget {
  const IssueViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IssueDetailsCubit, IssueDetailsState>(
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            const CustomSliverAppBar(
              title: "تفاصيل العطل",
            ),
            SliverPadding(padding: AppInsets.h8, sliver: const IssueViewBody()),
          ],
        );
      },
    );
  }
}
