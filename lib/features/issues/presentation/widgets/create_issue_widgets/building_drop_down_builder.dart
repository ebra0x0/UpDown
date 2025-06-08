import 'package:UpDown/core/utils/model/drop_down_model.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/custom_drop_down.dart';
import 'package:UpDown/features/buildings/data/models/building_summary_model.dart';
import 'package:UpDown/features/buildings/presentation/manager/buildings_cubit/buildings_cubit.dart';
import 'package:UpDown/features/issues/presentation/manager/create_issue_cubit/create_issue_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildingDropDownBuilder extends StatelessWidget {
  const BuildingDropDownBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuildingsCubit, BuildingsState>(
        builder: (context, state) {
      final CreateIssueState issueCubitState =
          context.watch<CreateIssueCubit>().state;
      final bool isCreating =
          issueCubitState.status == CreateIssueStatus.loading;
      final BuildingSummaryModel? selectedBuilding = issueCubitState.building;
      final List<BuildingSummaryModel>? buildings =
          state is BuildingsLoaded ? state.buildings : null;

      final dropDownList = buildings
              ?.map((e) => DropDownModel(
                    label: e.name,
                    value: e,
                  ))
              .toList() ??
          [];

      final matchValue = dropDownList.cast<DropDownModel?>().firstWhere(
            (e) =>
                (e!.value as BuildingSummaryModel).id == selectedBuilding?.id,
            orElse: () => null,
          );

      return CustomDropDown(
        isEnabled: !isCreating,
        isLoading: state is BuildingsLoading,
        listItem: dropDownList,
        hint: "إختر المبنى",
        value: matchValue,
        error: "يرجى إختيار المبنى",
        prefixIcon: Styles.apartmentIcon,
        onChanged: (value) => onChanged(context, value as DropDownModel?),
      );
    });
  }

  void onChanged(BuildContext context, DropDownModel? value) {
    if (value != null) {
      context.read<CreateIssueCubit>().selectBuilding(value.value);
    }
  }
}
