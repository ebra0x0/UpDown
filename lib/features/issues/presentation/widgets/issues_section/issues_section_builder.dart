import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/widgets/header_section.dart';
import 'package:UpDown/features/issues/presentation/manager/issues_cubit/issues_cubit.dart';
import 'package:UpDown/core/widgets/screen_echo.dart';
import 'package:UpDown/features/issues/data/models/issue_summary_response_model.dart';
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
    return BlocBuilder<IssuesCubit, IssuesState>(builder: (context, state) {
      final issues = state.status == ContentStatus.loaded
          ? state.issues!
          : List.generate(2, (_) => IssueSummaryResponseModel.empty());
      if (state.status == ContentStatus.error) {
        return SliverToBoxAdapter(
          child: ScreenEcho(message: state.errorMsg!),
        );
      } else if (state.status == ContentStatus.empty) {
        return SliverToBoxAdapter(child: null);
      }
      return AppSkeletonizer(
        isSliver: true,
        enabled: state.status == ContentStatus.loading,
        child: SliverList(
          delegate: SliverChildListDelegate(
            [
              Visibility(
                visible: issues.isNotEmpty,
                child: HeaderSection(
                  title: "الأعطال الحالية",
                  titleStyle: AppTextStyles.textStyle18,
                  actionText: "عرض الكل",
                  onActionTap: () {},
                ),
              ),
              IssuesListSection(
                issues: issues,
              ),
            ],
          ),
        ),
      );
    });
  }
}
