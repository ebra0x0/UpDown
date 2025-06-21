import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/extensions/ex_icon.dart';
import 'package:flutter/widgets.dart';

class BubbleIcon extends StatelessWidget {
  const BubbleIcon({
    super.key,
    required this.icon,
    this.color,
    this.padding = 8,
  });

  final Icon icon;
  final Color? color;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color?.withValues(alpha: 0.2) ??
            AppTheme.primary.withValues(alpha: 0.2),
      ),
      padding: EdgeInsets.all(padding),
      child: icon.copyWith(
        color: color ?? AppTheme.primary,
      ),
    );
  }
}
