import 'package:UpDown/core/utils/manager/auth_cubit/cubit/auth_cubit.dart';
import 'package:UpDown/core/utils/manager/user_cubit/cubit/user_data_cubit.dart';
import 'package:UpDown/core/widgets/loading_indicator.dart';
import 'package:UpDown/features/root/home/presentation/views/widgets/home_widgets/home_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: const Text(
            'أنت تدير',
            style: TextStyle(
              color: Color.fromARGB(221, 34, 34, 34),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: const HomeViewBody(),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        BlocBuilder<UserDataCubit, UserDataState>(
          builder: (context, state) {
            if (state is UserDataLoading) {
              return const DataLoadingIndicator();
            } else if (state is UserDataSuccess) {
              return UserAccountsDrawerHeader(
                accountName: Text(state.userDataModel!.name),
                accountEmail: Text(state.userDataModel!.email),
              );
            } else if (state is UserDataError) {
              return Text(state.error);
            }
            return Container();
          },
        ),
        IconButton(
            onPressed: () => BlocProvider.of<AuthCubit>(context).signOut(),
            icon: const Icon(Icons.logout))
      ],
    ));
  }
}
