import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/core/widgets/bubble_status.dart';
import 'package:UpDown/core/widgets/custom_card.dart';
import 'package:UpDown/features/elevators/data/models/unit_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ElevatorUnitCard extends StatelessWidget {
  const ElevatorUnitCard({
    super.key,
    required this.unit,
  });

  final UnitModel unit;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        child: Stack(children: [
      Positioned(
        top: 0,
        right: 0,
        child: Opacity(
          opacity: 0.4,
          child: SvgPicture.asset(
            "assets/svgs/${unit.name}.svg",
            height: 160,
          ),
        ),
      ),
      Positioned(
          top: 0,
          left: 0,
          child: BubbleStatus(
            color: unit.status.color,
          )),
    ]));
  }
}
