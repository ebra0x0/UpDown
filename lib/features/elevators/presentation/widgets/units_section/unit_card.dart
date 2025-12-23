import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/widgets/smart_bottom_sheet.dart';
import 'package:UpDown/features/elevators/data/models/units/cabin_model.dart';
import 'package:UpDown/features/elevators/data/models/units/control_model.dart';
import 'package:UpDown/features/elevators/data/models/units/counter_model.dart';
import 'package:UpDown/features/elevators/data/models/units/engine_model.dart';
import 'package:UpDown/features/elevators/data/models/units/wires_model.dart';
import 'package:UpDown/features/elevators/presentation/widgets/units_section/units_info/cabin_info.dart';
import 'package:UpDown/features/elevators/presentation/widgets/units_section/units_info/control_info.dart';
import 'package:UpDown/features/elevators/presentation/widgets/units_section/units_info/counter_info.dart';
import 'package:UpDown/features/elevators/presentation/widgets/units_section/units_info/engine_info.dart';
import 'package:UpDown/features/elevators/presentation/widgets/units_section/units_info/wires_info.dart';
import 'package:flutter/material.dart';
import 'package:UpDown/core/theme/app_insets.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/core/widgets/bubble_status.dart';
import 'package:UpDown/core/widgets/custom_card.dart';
import 'package:UpDown/features/elevators/data/models/units/unit_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ElevatorUnitCard extends StatelessWidget {
  const ElevatorUnitCard({
    super.key,
    required this.unit,
  });

  final UnitModel unit;

  void _openBottomSheet(BuildContext context, UnitModel unit) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      isDismissible: true,
      showDragHandle: true,
      useSafeArea: true,
      backgroundColor: AppTheme.scaffoldColor,
      builder: (BuildContext context) =>
          SmartBottomSheet(children: [_getUnitInfoWidget(unit)]),
    );
  }

  Widget _getUnitInfoWidget(UnitModel unit) {
    switch (unit.type) {
      case UnitType.engine:
        return EngineInfo(unit: unit as EngineModel);
      case UnitType.cabin:
        return CabinInfo(unit: unit as CabinModel);
      case UnitType.counter:
        return CounterInfo(unit: unit as CounterModel);
      case UnitType.wires:
        return WiresInfo(unit: unit as WiresModel);
      case UnitType.control:
        return ControlInfo(unit: unit as ControlModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openBottomSheet(context, unit),
      child: CustomCard(
        padding:
            EdgeInsets.only(top: 8.sp, bottom: 16.sp, left: 8.sp, right: 8.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: AppInsets.bottom8,
              child: BubbleStatus(color: unit.status.color),
            ),
            // Needs enhancement to be more smooth
            Expanded(
              child: Center(
                child: SvgPicture.asset(
                  unit.type.assetPath(),
                  placeholderBuilder: (context) => CircleAvatar(
                    backgroundColor: AppTheme.surfaceColor,
                    radius: 45.sp,
                  ),
                  height: 90.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
