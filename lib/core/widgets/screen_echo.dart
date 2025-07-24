import 'package:UpDown/core/theme/app_borders.dart';
import 'package:UpDown/core/theme/app_icons.dart';
import 'package:UpDown/core/theme/app_insets.dart';
import 'package:UpDown/core/theme/app_radius.dart';
import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/extensions/box_border_ext.dart';
import 'package:UpDown/core/utils/extensions/icon_ext.dart';

import 'package:flutter/widgets.dart';

class ScreenEcho extends StatelessWidget {
  const ScreenEcho({
    super.key,
    this.icon,
    required this.message,
  });

  final Icon? icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: AppInsets.all8,
        decoration: BoxDecoration(
          border: AppBorders.errorBoxBorder
              .copyWith(color: AppTheme.red.withValues(alpha: 0.4)),
          borderRadius: AppRadius.borderRadius12,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 6,
          children: [
            icon ?? AppIcons.errorOutlineIcon.copyWith(color: AppTheme.red),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.textStyle14.copyWith(
                color: AppTheme.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
