import 'package:UpDown/core/utils/pallete.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/features/root/create_issue/presentation/manager/cubit/create_issue_cubit.dart';
import 'package:UpDown/features/root/home/data/model/building_summary_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildingDropdown extends StatelessWidget {
  const BuildingDropdown({super.key, required this.buildings});

  final List<BuildingSummaryModel> buildings;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.4 / 1,
      child: Container(
        decoration: BoxDecoration(
            color: Pallete.containerLight,
            borderRadius: Styles.borderRadius8,
            boxShadow: [Styles.boxShadow]),
        child: BlocBuilder<CreateIssueCubit, CreateIssueState>(
          builder: (context, state) => DropdownButtonHideUnderline(
            child: DropdownButton<BuildingSummaryModel>(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              hint: Row(
                spacing: 4,
                children: [
                  Icon(Icons.apartment_rounded, color: Colors.grey),
                  Text("إختر المبنى"),
                ],
              ),
              value:
                  BlocProvider.of<CreateIssueCubit>(context).selectedBuilding,
              onChanged: (value) {
                if (value != null) {
                  BlocProvider.of<CreateIssueCubit>(context)
                      .selectBuilding(value);
                }
              },
              items: buildings.map((building) {
                return DropdownMenuItem<BuildingSummaryModel>(
                  value: building,
                  child: Row(
                    spacing: 4,
                    children: [
                      Icon(Icons.apartment_rounded, color: Colors.grey),
                      SizedBox(
                        width: 65,
                        child: Text(building.name,
                            maxLines: 1, overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                );
              }).toList(),
              isExpanded: false,
            ),
          ),
        ),
      ),
    );
  }
}
