import 'package:UpDown/core/theme/app_icons.dart';
import 'package:UpDown/core/theme/app_insets.dart';
import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/core/utils/extensions/icon_ext.dart';
import 'package:UpDown/core/widgets/bubble_icon.dart';
import 'package:UpDown/core/widgets/custom_list_tile.dart';
import 'package:UpDown/core/widgets/section_box.dart';
import 'package:UpDown/features/elevators/data/models/units/cabin_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CabinInfo extends StatelessWidget {
  const CabinInfo({super.key, required this.unit});

  final CabinModel unit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.all16,
      child: Column(
        children: [
          Text(
            unit.type.title(context),
            style:
                AppTextStyles.textStyle26.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          SectionBox(
            children: [
              Text('المعلومات العامة', style: AppTextStyles.textStyle16),
              InfoRow(title: 'النوع', value: unit.type.title(context)),
              InfoRow(
                title: 'الحالة',
                value: unit.status.title(context),
                iconColor: unit.status.color,
              ),
              InfoRow(title: 'الموديل', value: unit.model ?? 'غير متوفر'),
            ],
          ),
          const SizedBox(height: 12),
          SectionBox(
            children: [
              Text('المواصفات', style: AppTextStyles.textStyle16),
              InfoRow(title: 'عدد الأنوار', value: unit.lightCount.toString()),
              InfoRow(
                title: 'مروحة',
                value: unit.hasFan ? 'نعم' : 'لا',
                iconColor:
                    unit.hasFan ? AppTheme.greenColor : AppTheme.redColor,
              ),
            ],
          ),
          const SizedBox(height: 12),
          SectionBox(
            children: [
              Text('إعدادات جهاز الأمان', style: AppTextStyles.textStyle16),
              InfoRow(
                title: 'نوع الجهاز',
                value: unit.password.type,
              ),
              InfoRow(
                title: 'رمز الدخول',
                value: unit.password.pass,
              ),
              InfoRow(
                title: 'مفعّلة؟',
                value: unit.password.isActive ? 'نعم' : 'لا',
                iconColor: unit.password.isActive
                    ? AppTheme.greenColor
                    : AppTheme.redColor,
              ),
            ],
          ),
          const SizedBox(height: 12),
          SectionBox(
            children: [
              Text('التواريخ', style: AppTextStyles.textStyle16),
              InfoRow(
                title: 'تاريخ الإنشاء',
                value: DateFormat('yyyy-MM-dd').format(unit.createdAt),
              ),
              if (unit.updatedAt != null)
                InfoRow(
                  title: 'آخر تعديل',
                  value: DateFormat('yyyy-MM-dd').format(unit.updatedAt!),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String title;
  final String value;
  final Icon? icon;
  final Color? iconColor;

  const InfoRow({
    super.key,
    required this.title,
    required this.value,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final Icon leadingIcon =
        icon?.copyWith(size: 16) ?? AppIcons.circleIcon.copyWith(size: 16);
    return CustomListTile(
        padding: EdgeInsets.zero,
        leading: BubbleIcon(
          icon: leadingIcon,
          color: iconColor ?? AppTheme.primaryColor,
        ),
        title: title,
        subtitle: value,
        titleStyle:
            AppTextStyles.textStyle12.copyWith(color: AppTheme.greyColor),
        subtitleStyle: AppTextStyles.textStyle14);
  }
}
