import 'dart:developer';

import 'package:UpDown/core/theme/app_radius.dart';
import 'package:UpDown/core/theme/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IssueMediaBox extends StatelessWidget {
  const IssueMediaBox({super.key, required this.mediaUrl});

  final String mediaUrl;

  @override
  Widget build(BuildContext context) {
    log(mediaUrl);
    return Container(
      width: double.infinity,
      height: 200.h,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: AppRadius.borderRadius8,
        color: AppTheme.surfaceColor,
      ),
      child: CachedNetworkImage(
        imageUrl: mediaUrl,
        progressIndicatorBuilder: (context, url, progress) => Center(
          child: CircularProgressIndicator(value: progress.progress),
        ),
        fit: BoxFit.cover,
      ),
    );
  }
}
