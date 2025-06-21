import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/core/utils/model/drop_down_model.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/custom_drop_down.dart';
import 'package:UpDown/features/issues/presentation/manager/create_issue_cubit/create_issue_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IssueDropDownBuilder extends StatelessWidget {
  const IssueDropDownBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final CreateIssueState issueCubitState =
        context.watch<CreateIssueCubit>().state;
    final bool isCreating = issueCubitState.status == CreateIssueStatus.loading;

    final dropDownList = IssueType.values
        .map((e) => DropDownModel(
              label: e.title(context),
              value: e,
            ))
        .toList();

    final matchValue = dropDownList.cast<DropDownModel?>().firstWhere(
          (e) => e!.value == issueCubitState.issueType,
          orElse: () => null,
        );

    return CustomDropDown(
      isEnabled: !isCreating,
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
