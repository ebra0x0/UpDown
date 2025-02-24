import 'package:UpDown/features/root/home/presentation/views/widgets/building_details_widgets/building_details_view_body.dart';
import 'package:flutter/material.dart';

class BuildingDetailsView extends StatelessWidget {
  const BuildingDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: BuildingDetailsViewBody()));
  }
}
