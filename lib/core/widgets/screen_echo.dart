import 'package:flutter/widgets.dart';
import 'package:UpDown/core/theme/app_borders.dart';
import 'package:UpDown/core/theme/app_icons.dart';
import 'package:UpDown/core/theme/app_insets.dart';
import 'package:UpDown/core/theme/app_radius.dart';
import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/extensions/icon_ext.dart';

class ScreenEcho extends StatelessWidget {
  final bool isError;
  final Icon? icon;
  final String message;
  const ScreenEcho({
    super.key,
    this.icon,
    required this.message,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: AppInsets.all8,
        decoration: BoxDecoration(
          border:
              isError ? AppBorders.errorBoxBorder : AppBorders.generalBoxBorder,
          borderRadius: AppRadius.borderRadius12,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 6,
          children: [
            icon ??
                AppIcons.errorOutlineIcon.copyWith(color: AppTheme.greyColor),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.textStyle14.copyWith(
                color: isError ? AppTheme.redColor : AppTheme.greyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
