import 'package:UpDown/core/theme/app_insets.dart';
import 'package:UpDown/core/utils/enums/app_route.dart';
import 'package:UpDown/core/utils/helper/toast.dart';
import 'package:UpDown/features/issues/presentation/manager/create_issue_cubit/create_issue_cubit.dart';
import 'package:UpDown/features/issues/presentation/widgets/create_issue_widgets/create_issue_form.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateIssueBody extends StatelessWidget {
  const CreateIssueBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateIssueCubit, CreateIssueState>(
      listener: (context, state) {
        if (state.status == CreateIssueStatus.success) {
          showToast(
              context: context,
              message: "تم الإبلاغ عن العطل ",
              type: ToastType.success);
          context.go(AppRoute.home.path);
        }
        if (state.status == CreateIssueStatus.error) {
          showToast(
            context: context,
            message: state.error!,
            type: ToastType.error,
          );
        }
      },
      child: SingleChildScrollView(
          padding: AppInsets.h8, child: CreateIssueForm()),
    );
  }
}
