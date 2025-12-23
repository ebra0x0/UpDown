import 'package:UpDown/core/theme/app_icons.dart';
import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/core/utils/enums/app_route.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/widgets/header_section.dart';
import 'package:UpDown/features/issues/presentation/manager/issues_cubit/issues_cubit.dart';
import 'package:UpDown/features/issues/presentation/widgets/active_issues_section/issues_list_section.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:UpDown/core/theme/app_skeleton.dart';
import 'package:go_router/go_router.dart';

class IssuesSectionBuilder extends StatelessWidget {
  const IssuesSectionBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IssuesCubit, IssuesState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return AppSkeletonizer(
            isSliver: true,
            enabled: state.status == ContentStatus.loading,
            child: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Visibility(
                    visible: state.activeIssues?.isNotEmpty ?? false,
                    child: HeaderSection(
                      title: "الأعطال الحالية",
                      titleIcon: AppIcons.reportProblemIcon,
                      titleStyle: AppTextStyles.textStyle18,
                      actionText: "عرض الكل",
                      onActionTap: () {
                        context.push(
                            "${AppRoute.home.path}${AppRoute.issues.path}");
                      },
                    ),
                  ),
                  IssuesListSection(
                    issues: state.activeIssues ?? [],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
