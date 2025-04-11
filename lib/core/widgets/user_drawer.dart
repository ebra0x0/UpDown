import 'package:UpDown/core/utils/manager/user_cubit/cubit/user_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/manager/auth_cubit/cubit/auth_cubit.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({
    super.key,
    required this.state,
  });

  final UserDataSuccess state;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(state.userDataModel!.name),
            accountEmail: Text(state.userDataModel!.email),
          ),
          IconButton(
            onPressed: () => BlocProvider.of<AuthCubit>(context).signOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
