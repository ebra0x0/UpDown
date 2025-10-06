import 'package:UpDown/features/buildings/presentation/cubits/buildings_cubit/buildings_cubit.dart';
import 'package:UpDown/features/buildings/presentation/widgets/building_details_view_body.dart';
import 'package:UpDown/features/elevators/presentation/manager/elevators_cubit/elevators_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildingDetailsView extends StatefulWidget {
  final String buildingId;
  const BuildingDetailsView({super.key, required this.buildingId});

  @override
  State<BuildingDetailsView> createState() => _BuildingDetailsViewState();
}

class _BuildingDetailsViewState extends State<BuildingDetailsView> {
  @override
  void initState() {
    super.initState();
    context.read<BuildingsCubit>().selectBuilding(widget.buildingId);
    context.read<ElevatorsCubit>().selectBuildingElevators(widget.buildingId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BuildingDetailsViewBody());
  }
}
