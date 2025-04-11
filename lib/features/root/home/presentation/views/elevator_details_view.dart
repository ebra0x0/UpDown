import 'package:UpDown/core/widgets/back_nav_button.dart';
import 'package:UpDown/core/widgets/loading_indicator.dart';
import 'package:UpDown/core/widgets/text_error.dart';
import 'package:UpDown/features/root/home/presentation/manager/elevator_details_cubit/cubit/elevator_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/elevator_details_widgets/elevator_details_view_body.dart';

class ElevatorDetailsView extends StatelessWidget {
  const ElevatorDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(children: [
      BlocBuilder<ElevatorDetailsCubit, ElevatorDetailsState>(
          builder: (context, state) {
        if (state is ElevatorDetailsLoaded) {
          return ElevatorDetailsViewBody(state: state);
        } else if (state is ElevatorDetailsError) {
          return TextError(errorMessage: state.error);
        } else {
          return const DataLoadingIndicator();
        }
      }),
      Positioned(top: 16, right: 16, child: BackButtonNavigation()),
    ])));
  }
}
