import 'package:UpDown/core/utils/pallete.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/features/root/home/presentation/views/widgets/building_details_widgets/building_details_elevators_section/building_details_elevators_section.dart';
import 'package:flutter/material.dart';

import 'building_details_header_section/building_details_header_section.dart';

class BuildingDetailsViewBody extends StatelessWidget {
  const BuildingDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: BuildingDetailsHeaderSection()),
          SliverToBoxAdapter(
            child: SizedBox(height: 12),
          ),
          SliverFillRemaining(
            child: BuildingDetailsElevatorsSection(),
          ),
        ],
      ),
    );
  }
}

class AlertBanner extends StatelessWidget {
  const AlertBanner({
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
      color: color ?? Pallete.lightSecondary,
      child: Text(
        title ?? "تم الإبلاغ عن عطل وسيتم حله قريباً",
        style: Styles.textStyle14.copyWith(color: Colors.white),
      ),
    );
  }
}
