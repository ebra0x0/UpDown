import 'package:UpDown/core/theme/app_skeleton.dart';
import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  final String title;
  final Widget? leading;
  final bool isCenterTitle;
  final bool isFloating;
  final TextStyle? titleStyle;
  final bool isLoading;
  const CustomSliverAppBar({
    super.key,
    required this.title,
    this.leading,
    this.titleStyle,
    this.isCenterTitle = true,
    this.isFloating = true,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppSkeletonizer(
      isSliver: true,
      enabled: isLoading,
      child: SliverAppBar(
        floating: isFloating,
        leading: leading,
        title: Text(
          title,
          style: titleStyle ?? AppTextStyles.textStyle22,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        centerTitle: isCenterTitle,
      ),
    );
  }
}
