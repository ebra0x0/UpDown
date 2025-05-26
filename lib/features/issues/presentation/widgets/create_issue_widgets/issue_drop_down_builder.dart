import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/core/utils/model/drop_down_model.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/custom_drop_down.dart';
import 'package:UpDown/features/issues/presentation/manager/create_issue_cubit/create_issue_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IssueDropDownBuilder extends StatelessWidget {
  const IssueDropDownBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final IssueType? selectedIssueType =
        context.watch<CreateIssueCubit>().selectedIssueType;

    final dropDownList = IssueType.values
        .map((e) => DropDownModel(
              label: e.title(context),
              value: e,
            ))
        .toList();

    final matchValue = dropDownList.cast<DropDownModel?>().firstWhere(
          (e) => e!.value == selectedIssueType,
          orElse: () => null,
        );

    return CustomDropDown(
      listItem: dropDownList,
      hint: "إختر نوع العطل",
      value: matchValue,
      error: "يرجى إختيار نوع العطل",
      prefixIcon: Styles.reportIcon,
      onChanged: (value) => onChanged(context, value as DropDownModel?),
    );
  }

  void onChanged(BuildContext context, DropDownModel? value) {
    if (value != null) {
      context
          .read<CreateIssueCubit>()
          .selectIssueType(value.value as IssueType);
    }
  }
}
