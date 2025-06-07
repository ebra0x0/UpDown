import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IssueDescriptionSection extends StatelessWidget {
  final String issuerDescription;

  const IssueDescriptionSection({
    super.key,
    required this.issuerDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: Styles.borderRadius12,
      ),
      padding: EdgeInsets.all(16.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle('وصف العطل'),
          SizedBox(height: 12.sp),
          _DescriptionBox(issuerDescription),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Styles.textStyle16,
    );
  }
}

class _DescriptionBox extends StatelessWidget {
  final String text;

  const _DescriptionBox(
    this.text,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.sp),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: Styles.borderRadius12,
      ),
      child: Text(
        text,
        style: Styles.textStyle14,
      ),
    );
  }
}
