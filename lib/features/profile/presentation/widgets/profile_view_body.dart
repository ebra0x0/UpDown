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
            const HeaderText(
                title: "المعلومات الشخصية", textStyle: Styles.textStyle16),
            ListTile(
              leading: const Icon(Icons.person_outline_rounded),
              subtitle: Text(profile.name, style: Styles.textStyle14),
              title: Text(
                "الاسم",
                style: Styles.textStyle14,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.email_outlined),
              subtitle: Text(profile.email, style: Styles.textStyle14),
              title: Text("البريد الالكتروني", style: Styles.textStyle14),
            ),
            ListTile(
              leading: const Icon(Icons.phone_enabled_outlined),
              subtitle: Text(profile.phone, style: Styles.textStyle14),
              title: Text("رقم الجوال", style: Styles.textStyle14),
            ),
            ListTile(
              leading: const Icon(Icons.location_on_outlined),
              subtitle: Text(profile.address, style: Styles.textStyle14),
              title: Text("العنوان", style: Styles.textStyle14),
            ),
          ],
        ),
      ),
    );
  }
}
