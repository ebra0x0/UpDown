import 'package:UpDown/core/widgets/back_nav_button.dart';
import 'package:UpDown/core/widgets/data_loading_shimmer.dart';
import 'package:UpDown/core/widgets/placeholder_panel.dart';
import 'package:UpDown/features/buildings/presentation/manager/building_details_cubit/building_details_cubit.dart';
import 'package:UpDown/features/elevators/presentation/manager/elevators_cubit/elevators_cubit.dart';
import 'package:UpDown/features/buildings/presentation/widgets/building_details_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildingDetailsView extends StatefulWidget {
  const BuildingDetailsView({super.key, required this.buildingId});

  final String buildingId;

  @override
  State<BuildingDetailsView> createState() => _BuildingDetailsViewState();
}

class _BuildingDetailsViewState extends State<BuildingDetailsView> {
  @override
  void initState() {
    super.initState();
    context.read<BuildingDetailsCubit>().call(buildingId: widget.buildingId);
    context.read<ElevatorsCubit>().call(buildingId: widget.buildingId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuildingDetailsCubit, BuildingDetailsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: state is BuildingDetailsLoaded
              ? null
              : AppBar(
                  leading: BackButtonNavigation(),
                ),
          body: () {
            if (state is BuildingDetailsLoaded) {
              return BuildingDetailsViewBody(state: state);
            } else if (state is BuildingDetailsError) {
              return PlaceholderPanel(message: state.error);
            } else if (state is BuildingDetailsEmpty) {
              return PlaceholderPanel(message: "يبدو أن المبنى قد حذف");
            }
            return const DataLoadingIndicator();
          }(),
        );
      },
    );
  }
}
