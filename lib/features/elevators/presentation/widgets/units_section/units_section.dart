import 'package:UpDown/core/theme/app_insets.dart';
import 'package:UpDown/features/elevators/data/models/units/unit_model.dart';
import 'package:UpDown/features/elevators/presentation/widgets/units_section/unit_card.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UnitsSection extends StatelessWidget {
  final List<UnitModel> units;

  const UnitsSection({super.key, required this.units});

  List<Widget> buildUnitWidgets() {
    return units
        .map((e) =>
            AspectRatio(aspectRatio: .65, child: ElevatorUnitCard(unit: e)))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170.sp,
      child: ListView(
        padding: AppInsets.h8,
        scrollDirection: Axis.horizontal,
        children: buildUnitWidgets(),
      ),
    );
  }
}
