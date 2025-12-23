import 'package:UpDown/core/theme/app_insets.dart';
import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/extensions/icon_ext.dart';
import 'package:flutter/widgets.dart';

class BubbleIcon extends StatelessWidget {
  const BubbleIcon({
    super.key,
    required this.icon,
    this.color,
    this.padding,
  });

  final Icon icon;
  final Color? color;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color?.withValues(alpha: 0.2) ??
            AppTheme.primaryColor.withValues(alpha: 0.2),
      ),
      padding: padding ?? AppInsets.all8,
      child: icon.copyWith(
        color: color ?? AppTheme.primaryColor,
      ),
    );
  }
}
