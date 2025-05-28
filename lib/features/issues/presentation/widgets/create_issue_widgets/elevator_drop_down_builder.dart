import 'package:UpDown/core/utils/model/drop_down_model.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/custom_drop_down.dart';
import 'package:UpDown/features/elevators/data/models/elevator_summary_model.dart';
import 'package:UpDown/features/issues/presentation/manager/create_issue_cubit/create_issue_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ElevatorDropDownBuilder extends StatelessWidget {
  const ElevatorDropDownBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateIssueCubit, CreateIssueState>(
      builder: (context, state) {
        final CreateIssueCubit cubit = context.read<CreateIssueCubit>();
        final List<ElevatorSummaryModel>? elevators = cubit.elevators;
        final ElevatorSummaryModel? selectedElevator = cubit.selectedElevator;

        final dropDownList = elevators
                ?.map((e) => DropDownModel(
                      label: e.name,
                      value: e,
                    ))
                .toList() ??
            [];

        final matchValue = dropDownList.cast<DropDownModel?>().firstWhere(
              (e) =>
                  (e!.value as ElevatorSummaryModel).id == selectedElevator?.id,
              orElse: () => null,
            );

        return CustomDropDown(
          isLoading: state is SelectLoading,
          listItem: dropDownList,
          hint: "إختر المصعد",
          value: matchValue,
          error: "يرجى إختيار المصعد",
          prefixIcon: Styles.elevatorIcon,
          onChanged: (value) => onChanged(context, value as DropDownModel?),
        );
      },
    );
  }

  void onChanged(BuildContext context, DropDownModel? value) {
    if (value != null) {
      context.read<CreateIssueCubit>().selectElevator(value.value);
    }
  }
}
