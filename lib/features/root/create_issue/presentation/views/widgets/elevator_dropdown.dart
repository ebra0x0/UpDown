import 'package:UpDown/core/utils/pallete.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/features/root/create_issue/presentation/manager/cubit/create_issue_cubit.dart';
import 'package:UpDown/features/root/home/data/model/elevator_summary_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ElevatorDropdown extends StatelessWidget {
  const ElevatorDropdown({super.key, required this.elevators});

  final List<ElevatorSummaryModel> elevators;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.4 / 1,
      child: Container(
        decoration: BoxDecoration(
          color: Pallete.containerLight,
          borderRadius: Styles.borderRadius8,
          boxShadow: [Styles.boxShadow],
        ),
        child: BlocBuilder<CreateIssueCubit, CreateIssueState>(
          builder: (context, state) => DropdownButtonHideUnderline(
            child: DropdownButton<ElevatorSummaryModel>(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              hint: Row(
                spacing: 4,
                children: [
                  Icon(Icons.elevator_outlined, color: Colors.grey),
                  Text("إختر المصعد"),
                ],
              ),
              value:
                  BlocProvider.of<CreateIssueCubit>(context).selectedElevator,
              onChanged: (value) {
                if (value != null) {
                  BlocProvider.of<CreateIssueCubit>(context)
                      .selectElevator(value);
                }
              },
              items: elevators.map((e) {
                return DropdownMenuItem<ElevatorSummaryModel>(
                  value: e,
                  child: Row(
                    spacing: 4,
                    children: [
                      Icon(Icons.elevator_outlined, color: Colors.grey),
                      Text(
                        e.elevatorNumber.toString(),
                      ),
                    ],
                  ),
                );
              }).toList(),
              isExpanded: true,
            ),
          ),
        ),
      ),
    );
  }
}
