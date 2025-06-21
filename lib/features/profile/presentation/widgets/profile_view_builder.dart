import 'package:UpDown/core/utils/function/toast.dart';
import 'package:UpDown/core/widgets/data_loading_shimmer.dart';
import 'package:UpDown/features/profile/presentation/manager/profile_cubit/cubit/profile_cubit.dart';
import 'package:UpDown/features/profile/presentation/widgets/profile_view_body.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileViewBuilder extends StatefulWidget {
  const ProfileViewBuilder({super.key});

  @override
  State<ProfileViewBuilder> createState() => _ProfileViewBuilderState();
}

class _ProfileViewBuilderState extends State<ProfileViewBuilder> {
  @override
  void initState() {
    context.read<ProfileCubit>().call();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileError || state is AvatarError) {
          final errorMessage = state is ProfileError
              ? state.error
              : (state as AvatarError).error;
          showToast(
            context: context,
            message: errorMessage,
            type: ToastType.error,
          );
        }
      },
      builder: (context, state) {
        if (state is ProfileLoaded || state is AvatarError) {
          return ProfileViewBody(
              profile: state is ProfileLoaded
                  ? state.profile
                  : (state as AvatarError).profile);
        }
        return const ContentLoadingShimmer();
      },
    );
  }
}
