import 'package:UpDown/core/theme/app_icons.dart';
import 'package:UpDown/core/theme/app_theme.dart';

import 'package:UpDown/core/widgets/bubble_icon.dart';
import 'package:UpDown/core/widgets/bubble_status.dart';
import 'package:UpDown/core/widgets/custom_list_tile.dart';
import 'package:UpDown/features/buildings/data/models/building_model.dart';
import 'package:flutter/widgets.dart';

class FloorListTile extends StatelessWidget {
  const FloorListTile({super.key, required this.floor});

  final FloorModel floor;

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
            BubbleStatus(color: AppTheme.red),
            AppIcons.forwardIcon,
          ],
        ),
      ),
      title: "الدور ${floor.floorNumber == 0 ? "الأرضي" : floor.floorNumber}",
    );
  }
}
