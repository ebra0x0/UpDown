import 'package:UpDown/core/widgets/back_nav_button.dart';
import 'package:UpDown/core/widgets/loading_indicator.dart';
import 'package:UpDown/core/widgets/text_error.dart';
import 'package:UpDown/features/root/home/presentation/manager/building_details_cubit/cubit/building_details_cubit.dart';
import 'package:UpDown/features/root/home/presentation/views/widgets/building_details_widgets/building_details_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildingDetailsView extends StatelessWidget {
  const BuildingDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(children: [
      BlocBuilder<BuildingDetailsCubit, BuildingDetailsState>(
          builder: (context, state) {
        if (state is BuildingDetailsLoaded) {
          return BuildingDetailsViewBody(state: state);
        } else if (state is BuildingDetailsError) {
          return TextError(errorMessage: state.error);
        } else {
          return DataLoadingIndicator();
        }
      }),
      Positioned(top: 16, right: 16, child: BackButtonNavigation()),
    ])));
  }
}
