import 'package:UpDown/core/theme/app_insets.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/core/widgets/bubble_status.dart';
import 'package:UpDown/core/widgets/custom_card.dart';
import 'package:UpDown/features/elevators/data/models/units/unit_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ElevatorUnitCard extends StatelessWidget {
  const ElevatorUnitCard({
    super.key,
    required this.unit,
  });

  final UnitModel unit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
            Expanded(
              child: Center(
                child: SvgPicture.asset(
                  unit.type.assetPath(),
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
