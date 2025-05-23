import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:flutter/material.dart';

class AlertBannerIssue extends StatelessWidget {
  const AlertBannerIssue({
    super.key,
    required this.title,
    this.color,
  });

  final String? title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      color: color ?? AppTheme.grey,
      child: Text(
        title ?? "تم الإبلاغ عن عطل وسيتم حله قريباً",
        style: Styles.textStyle14.copyWith(color: Colors.white),
      ),
    );
  }
}
