import 'package:UpDown/core/utils/pallete.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/loading_indicator.dart';
import 'package:UpDown/features/elevators/data/models/elevator_summary_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ElevatorDropdown extends StatelessWidget {
  const ElevatorDropdown(
      {super.key,
      required this.onChanged,
      required this.elevators,
      this.selectedElevator,
      this.isLoading = false});
  final void Function(ElevatorSummaryModel? elevator) onChanged;
  final List<ElevatorSummaryModel>? elevators;
  final ElevatorSummaryModel? selectedElevator;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField<ElevatorSummaryModel>(
        decoration: InputDecoration(
          errorBorder: Styles.errorBorder,
          enabledBorder: Styles.enabledBorder,
          border: OutlineInputBorder(
            borderRadius: Styles.borderRadius8,
            borderSide: BorderSide(
                color: Pallete.lightSecondary.withValues(alpha: .2),
                width: 1.8.sp),
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 4.sp, vertical: 4.sp),
          prefixIcon: Styles.elevatorIcon,
        ),
        hint: isLoading ? LoadingIndicator() : Text("إختر المصعد"),
        isDense: false,
        isExpanded: true,
        value: selectedElevator,
        onChanged: (value) => onChanged(value),
        validator: (value) {
          if (value == null) {
            return "المصعد مطلوب";
          }
          return null;
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
    );
  }
}
