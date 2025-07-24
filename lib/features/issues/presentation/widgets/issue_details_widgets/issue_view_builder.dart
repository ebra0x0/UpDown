import 'package:UpDown/core/theme/app_insets.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/widgets/back_nav_button.dart';
import 'package:UpDown/core/widgets/custom_sliver_app_bar.dart';
import 'package:UpDown/core/widgets/screen_echo.dart';
import 'package:UpDown/features/issues/presentation/manager/issue_details_cubit/issue_details_cubit.dart';
import 'package:UpDown/features/issues/presentation/widgets/issue_details_widgets/issue_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IssueViewBuilder extends StatelessWidget {
  const IssueViewBuilder({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IssueDetailsCubit, IssueDetailsState>(
      builder: (context, state) {
        final isError = state.status == ContentStatus.error;

        return CustomScrollView(
          slivers: [
            const CustomSliverAppBar(
              title: "تفاصيل العطل",
              leading: BackButtonNavigation(),
            ),
            if (!isError)
              SliverPadding(
                  padding: AppInsets.h8, sliver: const IssueViewBody()),
            if (isError)
              SliverFillRemaining(
                hasScrollBody: false,
                child:
                    ScreenEcho(message: state.errorMsg ?? "حدث خطأ غير متوقع"),
              ),
          ],
        );
      },
    );
  }
}
