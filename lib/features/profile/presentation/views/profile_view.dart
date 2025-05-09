import 'package:UpDown/core/utils/service_locator.dart';
import 'package:UpDown/features/profile/data/repos/profile_repo_imp.dart';
import 'package:UpDown/features/profile/presentation/widgets/profile_view_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:UpDown/features/profile/presentation/manager/profile_cubit/cubit/profile_cubit.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الحساب')),
      body: BlocProvider(
        create: (context) => ProfileCubit(gitIt.get<ProfileRepoImp>()),
        child: ProfileViewBuilder(),
      ),
    );
  }
}
