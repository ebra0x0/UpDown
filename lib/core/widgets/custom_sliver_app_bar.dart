import 'package:UpDown/core/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  final String title;
  final Widget? leading;
  final bool isCenterTitle;
  final bool isFloating;
  final TextStyle? titleStyle;
  const CustomSliverAppBar({
    super.key,
    required this.title,
    this.leading,
    this.titleStyle,
    this.isCenterTitle = true,
    this.isFloating = true,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: isFloating,
      leading: leading,
      title: Text(
        title,
        style: titleStyle ?? Styles.textStyle22,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      centerTitle: isCenterTitle,
    );
  }
}
