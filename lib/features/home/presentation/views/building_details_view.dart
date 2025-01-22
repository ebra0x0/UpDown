import 'package:UpDown/core/utils/model/building_model.dart';
import 'package:UpDown/features/home/presentation/views/widgets/building_details_view_body.dart';
import 'package:flutter/material.dart';

class BuildingDetailsView extends StatelessWidget {
  const BuildingDetailsView({super.key, required this.building});

  final BuildingModel building;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: BuildingDetailsViewBody(
      building: building,
    )));
  }
}
