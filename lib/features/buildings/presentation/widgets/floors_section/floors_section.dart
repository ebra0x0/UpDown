import 'package:UpDown/core/theme/app_icons.dart';
import 'package:UpDown/core/theme/app_spacing.dart';

import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/core/widgets/bubble_icon.dart';
import 'package:UpDown/core/widgets/bubble_status.dart';
import 'package:UpDown/core/widgets/custom_list_tile.dart';
import 'package:UpDown/features/buildings/data/models/building_model.dart';
import 'package:flutter/widgets.dart';

class BuildingFloorsSection extends StatelessWidget {
  final List<FloorModel> floors;

  const BuildingFloorsSection({super.key, required this.floors});

  List<Widget> _buildFloorListTile() =>
      floors.take(4).map((floor) => FloorListTile(floor: floor)).toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.s8,
      children: _buildFloorListTile(),
    );
  }
}

class FloorListTile extends StatelessWidget {
  final FloorModel floor;

  const FloorListTile({super.key, required this.floor});

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      onTap: () => {},
      leading: BubbleIcon(icon: AppIcons.stairsIcon),
      trailing: SizedBox(
        width: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BubbleStatus(color: floor.status.color),
            AppIcons.forwardIcon,
          ],
        ),
      ),
      title: "الدور ${floor.number == 0 ? "الأرضي" : floor.number}",
    );
  }
}
