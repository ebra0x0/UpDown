import 'package:UpDown/core/widgets/custom_card.dart';
import 'package:UpDown/core/widgets/loading_indicator.dart';
import 'package:UpDown/features/issues/presentation/manager/create_issue_cubit/create_issue_cubit.dart';
import 'package:UpDown/features/buildings/data/models/building_summary_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildingDropdown extends StatelessWidget {
  const BuildingDropdown(
      {super.key,
      required this.buildings,
      this.selectedBuilding,
      this.isLoading = false});

  final BuildingSummaryModel? selectedBuilding;
  final List<BuildingSummaryModel>? buildings;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.4 / 1,
      child: CustomCard(
        padding: 0,
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField<BuildingSummaryModel>(
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 8),
              prefixIcon: Icon(Icons.apartment_rounded, color: Colors.grey),
            ),
            isDense: false,
            hint: isLoading ? LoadingIndicator() : Text("إختر المبنى"),
            isExpanded: true,
            value: selectedBuilding,
            onChanged: (value) {
              if (value != null) {
                context.read<CreateIssueCubit>().selectBuilding(value);
              }
            },
            items: buildings == null
                ? []
                : buildings!.map((building) {
                    return DropdownMenuItem<BuildingSummaryModel>(
                      value: building,
                      child: Text(building.name,
                          maxLines: 1, overflow: TextOverflow.ellipsis),
                    );
                  }).toList(),
          ),
        ),
      ),
    );
  }
}
