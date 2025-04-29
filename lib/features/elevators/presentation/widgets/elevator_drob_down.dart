import 'package:UpDown/core/widgets/custom_card.dart';
import 'package:UpDown/core/widgets/loading_indicator.dart';
import 'package:UpDown/features/issues/presentation/manager/create_issue_cubit/create_issue_cubit.dart';
import 'package:UpDown/features/elevators/data/models/elevator_summary_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ElevatorDropdown extends StatelessWidget {
  const ElevatorDropdown(
      {super.key,
      required this.elevators,
      this.selectedElevator,
      this.isLoading = false});

  final List<ElevatorSummaryModel>? elevators;
  final ElevatorSummaryModel? selectedElevator;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.4 / 1,
      child: CustomCard(
        padding: 0,
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField<ElevatorSummaryModel>(
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 4),
              prefixIcon: Icon(Icons.elevator_outlined, color: Colors.grey),
            ),
            hint: isLoading ? LoadingIndicator() : Text("إختر المصعد"),
            isDense: false,
            isExpanded: true,
            value: selectedElevator,
            onChanged: (value) {
              if (value != null) {
                context.read<CreateIssueCubit>().selectElevator(value);
              }
            },
            items: elevators == null
                ? []
                : elevators!.map((elevator) {
                    return DropdownMenuItem<ElevatorSummaryModel>(
                      value: elevator,
                      child: Text(elevator.name,
                          maxLines: 1, overflow: TextOverflow.ellipsis),
                    );
                  }).toList(),
          ),
        ),
      ),
    );
  }
}
