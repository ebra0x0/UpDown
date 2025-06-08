import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/extensions/ext_icon.dart';
import 'package:UpDown/core/utils/model/profile_model.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/avatar_picker.dart';
import 'package:UpDown/core/widgets/custom_list_tile.dart';
import 'package:UpDown/core/widgets/header_text.dart';
import 'package:UpDown/features/auth/manager/auth_cubit.dart';
import 'package:UpDown/features/profile/presentation/manager/profile_cubit/cubit/profile_cubit.dart';
import 'package:UpDown/features/profile/presentation/widgets/persolnal_info_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key, required this.profile});

  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    final AuthCubit authCubit = context.watch<AuthCubit>();

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 8.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AvatarPicker(
              image: profile.imagePath,
              onImageSelected: (file) {
                final profileWithImage = profile.copyWith(imagePath: file.path);
                context.read<ProfileCubit>().updateProfile(profileWithImage);
              }),
          SizedBox(height: 22.sp),
          HeaderText(title: "المعلومات الشخصية", textStyle: Styles.textStyle16),
          PersonalInfoList(profile: profile),
          SizedBox(height: 22.sp),
          HeaderText(title: "الحساب", textStyle: Styles.textStyle16),
          CustomListTile(
            isLoading: authCubit.state.status == AuthStatus.loading,
            loadingColor: AppTheme.red,
            title: "تسجيل الخروج",
            leading: Styles.logoutIcon.copyWith(color: AppTheme.red),
            onTap: () async => await authCubit.signOut(),
          ),
        ],
      ),
    );
  }
}
