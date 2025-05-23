import 'package:UpDown/core/utils/constants.dart';
import 'package:UpDown/core/widgets/custom_drop_down.dart';
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
    return CustomDropDown(
      listItem: kIssuesList,
      hint: "إختر نوع العطل",
      value: issueType,
    );
  }
}
