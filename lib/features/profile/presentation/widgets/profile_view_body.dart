import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/extensions/ext_icon.dart';
import 'package:UpDown/core/utils/model/profile_model.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/avatar_picker.dart';
import 'package:UpDown/core/widgets/header_text.dart';
import 'package:UpDown/features/profile/presentation/manager/profile_cubit/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key, required this.profile});

  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AvatarPicker(
              image: profile.imagePath,
              onImageSelected: (file) =>
                  context.read<ProfileCubit>().updateAvatar(file),
            ),
            const SizedBox(height: 22),
            HeaderText(
                title: "المعلومات الشخصية",
                textStyle: Styles.textStyle14.copyWith(color: AppTheme.grey)),
            ListTile(
              leading: Styles.userIcon.copyWith(color: AppTheme.primary),
              subtitle: Text(profile.name,
                  style: Styles.textStyle14.copyWith(
                    color: AppTheme.grey,
                  )),
              title: Text(
                "الاسم",
                style: Styles.textStyle14,
              ),
            ),
            Visibility(
              visible: profile.email != null,
              child: ListTile(
                leading: Styles.emailIcon,
                subtitle: Text(profile.email!,
                    style: Styles.textStyle14.copyWith(
                      color: AppTheme.grey,
                    )),
                title: Text("البريد الالكتروني", style: Styles.textStyle14),
              ),
            ),
            ListTile(
              leading: Styles.phoneIcon,
              subtitle: Text(profile.phone,
                  style: Styles.textStyle14.copyWith(
                    color: AppTheme.grey,
                  )),
              title: Text("رقم الهاتف", style: Styles.textStyle14),
            ),
            ListTile(
              leading: Styles.locationIcon,
              subtitle: Text(profile.address,
                  style: Styles.textStyle14.copyWith(
                    color: AppTheme.grey,
                  )),
              title: Text("العنوان", style: Styles.textStyle14),
            ),
          ],
        ),
      ),
    );
  }
}
