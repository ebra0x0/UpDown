import 'package:UpDown/core/theme/app_icons.dart';
import 'package:UpDown/core/utils/extensions/icon_ext.dart';

import 'package:flutter/widgets.dart';

class BubbleStatus extends StatelessWidget {
  const BubbleStatus({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withValues(alpha: 0.2),
        ),
        child: AppIcons.circleIcon.copyWith(color: color));
  }
}
