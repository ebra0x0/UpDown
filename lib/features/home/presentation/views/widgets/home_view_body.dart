import 'package:flutter/material.dart';
import 'buildings_section/buildings_grid_view.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 16).copyWith(),
      child: BuildingsGridView(),
    );
  }
}
