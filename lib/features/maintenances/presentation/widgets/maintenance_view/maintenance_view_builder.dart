import 'package:UpDown/core/theme/app_insets.dart';
import 'package:UpDown/core/theme/app_spacing.dart';
import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/widgets/bubble_text.dart';
import 'package:UpDown/features/maintenances/presentation/cubit/maintenance_cubit.dart';
import 'package:UpDown/features/maintenances/presentation/cubit/maintenance_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaintenanceViewBuilder extends StatelessWidget {
  const MaintenanceViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MaintenanceCubit, MaintenanceState>(
      builder: (context, state) {
        return SliverList(
          delegate: SliverChildListDelegate.fixed(
            <Widget>[
              const SizedBox(height: 16),
              const TypeAndStatus(),
              const SizedBox(height: 8),
              const Summary(),
            ],
          ),
        );
      },
    );
  }
}

class TypeAndStatus extends StatelessWidget {
  const TypeAndStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: AppTheme.shadowColor.withValues(alpha: (0.1)),
      child: Container(
        padding: AppInsets.all12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("التوحيد", style: AppTextStyles.textStyle16),
            Text(
              "الفردي",
              style:
                  AppTextStyles.textStyle12.copyWith(color: AppTheme.greyColor),
            ),
            Divider(
              color: AppTheme.surfaceColor,
              height: 32,
            ),
            SizedBox(height: 8),
            Row(
              spacing: AppSpacing.s6,
              children: [
                BubbleText(
                    bubbleColor: AppTheme.primaryColor, bubbleText: "زيت"),
                BubbleText(
                    bubbleColor: AppTheme.greenColor, bubbleText: "أكتملت"),
                Expanded(
                  child: Text("16 نوفمبر 2025, 10:30 ص",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.textStyle10
                          .copyWith(color: AppTheme.greyColor)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Summary extends StatelessWidget {
  const Summary({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: AppTheme.shadowColor.withValues(alpha: (0.1)),
      child: Container(
        padding: AppInsets.all12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("تفاصيل أساسية", style: AppTextStyles.textStyle14),
            SizedBox(height: 16),
            Column(
              children: [
                Row(
                  children: [
                    Text("رقم الصيانة : ",
                        style: AppTextStyles.textStyle12
                            .copyWith(color: AppTheme.greyColor)),
                    Text("#123456", style: AppTextStyles.textStyle12),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text("تاريخ الصيانة : ",
                        style: AppTextStyles.textStyle12
                            .copyWith(color: AppTheme.greyColor)),
                    Text("16 نوفمبر 2025", style: AppTextStyles.textStyle12),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
