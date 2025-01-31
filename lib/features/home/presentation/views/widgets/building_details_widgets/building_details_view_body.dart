import 'package:UpDown/core/utils/pallete.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/features/home/presentation/manager/buildings_cubit/cubit/buildings_cubit.dart';
import 'package:UpDown/features/home/presentation/views/widgets/building_details_widgets/building_details_elevators_section/building_details_elevators_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'building_details_header_section/building_details_header_section.dart';

class BuildingDetailsViewBody extends StatelessWidget {
  const BuildingDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      BlocBuilder<BuildingsCubit, BuildingsState>(builder: (context, state) {
        if (state is BuildingsLoaded && state.building!.activeReport != null) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            alignment: Alignment.center,
            color: Pallete.error,
            child: Text(
              state.building!.activeReport!.description ??
                  "تم الإبلاغ عن عطل وسيتم حله قريباً",
              style: Styles.textStyle14.copyWith(color: Colors.white),
            ),
          );
        } else {
          return SizedBox();
        }
      }),
      Expanded(
        child: Padding(
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
        ),
      ),
    ]);
  }
}
