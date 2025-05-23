import 'package:UpDown/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key, this.color, this.size = 24});

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            width: size.sp,
            height: size.sp,
            child: CircularProgressIndicator(
              color: color ?? AppTheme.primary,
            )));
  }
}
