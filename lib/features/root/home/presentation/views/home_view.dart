import 'package:UpDown/core/utils/manager/user_cubit/cubit/user_data_cubit.dart';
import 'package:UpDown/core/widgets/loading_indicator.dart';
import 'package:UpDown/core/widgets/user_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/home_widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataCubit, UserDataState>(
      builder: (context, state) {
        return Scaffold(
          drawer: state is UserDataSuccess ? UserDrawer(state: state) : null,
          appBar: AppBar(
            title: const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                'أنت تدير',
                style: TextStyle(
                  color: Color.fromARGB(221, 34, 34, 34),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          body: Builder(
            builder: (context) {
              if (state is UserDataSuccess) {
                return const HomeViewBody();
              } else if (state is UserDataError) {
                return Center(
                  child: Text(
                    'حدث خطأ أثناء تحميل البيانات',
                    style: TextStyle(color: Colors.red),
                  ),
                );
              } else {
                return const DataLoadingIndicator();
              }
            },
          ),
        );
      },
    );
  }
}
