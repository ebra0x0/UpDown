import 'package:UpDown/core/theme/app_icons.dart';
import 'package:UpDown/core/theme/app_insets.dart';
import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/extensions/ex_icon.dart';
import 'package:UpDown/core/utils/helper/toast.dart';
import 'package:UpDown/features/profile/data/model/profile_request_model.dart';
import 'package:UpDown/features/profile/data/model/profile_response_model.dart';
import 'package:UpDown/core/widgets/avatar_picker.dart';
import 'package:UpDown/core/widgets/custom_list_tile.dart';
import 'package:UpDown/core/widgets/custom_sliver_app_bar.dart';
import 'package:UpDown/core/widgets/header_section.dart';
import 'package:UpDown/features/auth/manager/auth_cubit.dart';
import 'package:UpDown/features/profile/presentation/manager/profile_cubit/cubit/profile_cubit.dart';
import 'package:UpDown/features/profile/presentation/widgets/persolnal_info_list_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthCubit authCubit = context.watch<AuthCubit>();

    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state.status == ContentStatus.error) {
          showToast(
            context: context,
            message: state.errorMsg!,
            type: ToastType.error,
          );
        }
      },
      builder: (context, state) {
        return CustomScrollView(slivers: [
          CustomSliverAppBar(
            title: "الملف الشخصي",
            isCenterTitle: false,
            titleStyle: AppTextStyles.textStyle22,
          ),
          Skeletonizer.sliver(
            enabled: state.status == ContentStatus.loading,
            child: SliverToBoxAdapter(
              child: AvatarPicker(
                  image: state.status == ContentStatus.loaded
                      ? state.profile!.imagePath
                      : null,
                  onImageSelected: (file) async {
                    if (state.profile == null) return;
                    final ProfileRequestModel profileImageRequest =
                        ProfileRequestModel(
                            name: state.profile!.name,
                            address: state.profile!.address,
                            phone: state.profile!.phone,
                            imagePath: file.path);
                    await context
                        .read<ProfileCubit>()
                        .updateProfile(profileImageRequest);
                  }),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 22.sp)),
          Skeletonizer.sliver(
            enabled: state.status == ContentStatus.loading,
            child: SliverToBoxAdapter(
              child: HeaderSection(
                  title: "المعلومات الشخصية",
                  titleStyle: AppTextStyles.textStyle16),
            ),
          ),
          Skeletonizer.sliver(
            enabled: state.status == ContentStatus.loading,
            child: SliverPadding(
              padding: AppInsets.h8,
              sliver: SliverToBoxAdapter(
                child: PersonalInfoListSection(
                  profile: state.status == ContentStatus.loaded
                      ? state.profile!
                      : ProfileResponseModel.empty(),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 22.sp)),
          SliverToBoxAdapter(
              child: HeaderSection(
                  title: "الحساب", titleStyle: AppTextStyles.textStyle16)),
          SliverToBoxAdapter(
            child: CustomListTile(
              isLoading: authCubit.state.status == AuthStatus.loading,
              loadingColor: AppTheme.red,
              title: "تسجيل الخروج",
              leading: AppIcons.logoutIcon.copyWith(color: AppTheme.red),
              onTap: () async => await authCubit.signOut(),
            ),
          ),
        ]);
      },
    );
  }
}
