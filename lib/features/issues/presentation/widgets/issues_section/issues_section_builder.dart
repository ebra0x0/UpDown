import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/widgets/header_section.dart';
import 'package:UpDown/features/issues/presentation/manager/issues_cubit/issues_cubit.dart';
import 'package:UpDown/features/issues/presentation/widgets/issues_section/issues_list_section.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:UpDown/core/theme/app_skeleton.dart';

class IssuesSectionBuilder extends StatelessWidget {
  const IssuesSectionBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IssuesCubit, IssuesState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return AppSkeletonizer(
            isSliver: true,
            enabled: state.status == ContentStatus.loading,
            child: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Visibility(
                    visible: state.issues?.isNotEmpty ?? false,
                    child: HeaderSection(
                      title: "الأعطال الحالية",
                      titleStyle: AppTextStyles.textStyle18,
                      actionText: "عرض الكل",
                      onActionTap: () {},
                    ),
                  ),
                  IssuesListSection(
                    issues: state.issues ?? [],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
