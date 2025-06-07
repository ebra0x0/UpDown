import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardTile extends StatelessWidget {
  const CardTile({
    super.key,
    this.color,
    this.onTap,
    this.decoration,
    this.leading,
    required this.title,
    this.subtitle,
    this.body,
    this.footer,
    this.trailing,
    this.padding,
  });

  final Color? color;
  final VoidCallback? onTap;
  final BoxDecoration? decoration;
  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final Widget? body;
  final Widget? footer;
  final Widget? trailing;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 125.sp,
        padding: padding ?? EdgeInsets.all(16.sp),
        decoration: decoration ??
            BoxDecoration(
              color: AppTheme.background,
              borderRadius: Styles.borderRadius18,
              boxShadow: [Styles.boxShadow],
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8.sp,
          children: [
            Visibility(
                visible: leading != null, child: leading ?? SizedBox.shrink()),
            _CardTileContent(
              title: title,
              subtitle: subtitle,
              body: body,
              footer: footer,
            ),
            Spacer(),
            Visibility(
                visible: trailing != null,
                child: trailing ?? SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}

class _CardTileContent extends StatelessWidget {
  const _CardTileContent({
    required this.title,
    this.subtitle,
    this.body,
    this.footer,
  });

  final Widget title;
  final Widget? subtitle;
  final Widget? body;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CardTileHeader(
          title: title,
          subtitle: subtitle,
        ),
        Spacer(),
        Visibility(visible: body != null, child: body ?? SizedBox.shrink()),
        Spacer(),
        Visibility(visible: footer != null, child: footer ?? SizedBox.shrink()),
      ],
    );
  }
}

class _CardTileHeader extends StatelessWidget {
  const _CardTileHeader({
    required this.title,
    this.subtitle,
  });

  final Widget title;
  final Widget? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4.sp,
      children: [
        title,
        Visibility(
            visible: subtitle != null, child: subtitle ?? SizedBox.shrink()),
      ],
    );
  }
}
