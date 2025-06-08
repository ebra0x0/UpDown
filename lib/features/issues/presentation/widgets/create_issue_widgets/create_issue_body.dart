import 'package:UpDown/core/utils/app_router.dart';
import 'package:UpDown/core/utils/function/toast.dart';
import 'package:UpDown/features/issues/presentation/manager/create_issue_cubit/create_issue_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'create_issue_form.dart';

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
          context.go(AppRouter.khomeView);
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
          padding: EdgeInsets.symmetric(horizontal: 8.sp),
          child: CreateIssueForm()),
    );
  }
}
