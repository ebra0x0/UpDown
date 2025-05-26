import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/loading_indicator.dart';
import 'package:UpDown/features/buildings/data/models/building_summary_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildingDropdown extends StatelessWidget {
  const BuildingDropdown(
      {super.key,
      required this.onChanged,
      required this.buildings,
      this.selectedBuilding,
      this.isLoading = false});
  final void Function(BuildingSummaryModel? building) onChanged;
  final BuildingSummaryModel? selectedBuilding;
  final List<BuildingSummaryModel>? buildings;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<BuildingSummaryModel>(
      decoration: InputDecoration(
        errorBorder: Styles.errorBorder,
        enabledBorder: Styles.enabledBorder,
        border: Styles.generalBorder,
        focusedBorder: Styles.focusedBorder,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        contentPadding: EdgeInsets.symmetric(horizontal: 4.sp, vertical: 4.sp),
        errorStyle: TextStyle(height: 0),
        prefixIcon: Styles.apartmentIcon,
      ),
      isDense: false,
      hint: isLoading ? LoadingIndicator() : Text("إختر المبنى"),
      isExpanded: true,
      value: selectedBuilding,
      dropdownColor: AppTheme.accent,
      validator: (value) {
        if (value == null) {
          return "المبنى مطلوب";
        }
        return null;
      },
      onChanged: (value) => onChanged(value),
      items: buildings == null
          ? []
          : buildings!.map((building) {
              return DropdownMenuItem<BuildingSummaryModel>(
                value: building,
                child: Text(building.name,
                    maxLines: 1, overflow: TextOverflow.ellipsis),
              );
            }).toList(),
    );
  }
}
