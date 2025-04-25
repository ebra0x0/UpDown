import 'package:UpDown/constants.dart';
import 'package:UpDown/core/widgets/custom_drob_down.dart';
import 'package:UpDown/features/issues/presentation/manager/create_issue_cubit/create_issue_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IssueDrobDownBuilder extends StatelessWidget {
  const IssueDrobDownBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String? issueType = context.watch<CreateIssueCubit>().issueType;
    return CustomDrobDown(
      listItem: kIssuesList,
      hint: "إختر نوع العطل",
      value: issueType,
    );
  }
}
