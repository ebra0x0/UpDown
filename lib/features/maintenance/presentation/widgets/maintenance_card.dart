import 'package:UpDown/core/theme/app_icons.dart';
import 'package:UpDown/core/theme/app_insets.dart';
import 'package:UpDown/core/theme/app_radius.dart';
import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/core/utils/extensions/icon_ext.dart';
import 'package:flutter/widgets.dart';
import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/features/maintenance/data/models/maintenanace_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MaintenanceCard extends StatelessWidget {
  final MaintenanceModel maintenance;
  const MaintenanceCard({super.key, required this.maintenance});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: AppRadius.borderRadius12,
      ),
      padding: AppInsets.all16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الصف العلوي (العنوان والتكلفة)
          Row(
            children: [
              Expanded(
                child: Text(
                  maintenance.type.title,
                  style: AppTextStyles.textStyle18,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "${maintenance.cost} جم",
                style: AppTextStyles.textStyle18.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // التوحيد والزمن
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _InfoChip(
                  label: "التوحيد",
                  icon: AppIcons.apartmentIcon.copyWith(
                    color: AppTheme.primary,
                    size: 18.sp,
                  )),
              const SizedBox(width: 8),
              _InfoChip(
                  label: "الأيمن",
                  icon: AppIcons.elevatorIcon.copyWith(
                    color: AppTheme.primary,
                    size: 18.sp,
                  )),
            ],
          ),
          const SizedBox(height: 16),

          // اسم الفني
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "اسم الفني : ابراهيم${maintenance.technicianName}",
                style: AppTextStyles.textStyle14,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                maintenance.status.title,
                style: AppTextStyles.textStyle14.copyWith(
                  color: maintenance.status.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final Icon icon;

  const _InfoChip({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        const SizedBox(width: 4),
        Text(
          label,
          style: AppTextStyles.textStyle12,
        ),
      ],
    );
  }
}
