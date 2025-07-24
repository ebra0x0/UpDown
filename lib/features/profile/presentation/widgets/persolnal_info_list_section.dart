import 'package:UpDown/core/theme/app_icons.dart';
import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/extensions/icon_ext.dart';
import 'package:UpDown/features/profile/data/model/profile_response_model.dart';
import 'package:UpDown/core/widgets/custom_list_tile.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalInfoListSection extends StatelessWidget {
  const PersonalInfoListSection({
    super.key,
    required this.profile,
  });

  final ProfileResponseModel profile;

  @override
  Widget build(BuildContext context) {
    return Column(spacing: 8.sp, children: [
      CustomListTile(
        title: "الاسم",
        subtitle: profile.name,
        leading: AppIcons.userIcon.copyWith(
          color: AppTheme.grey,
        ),
      ),
      CustomListTile(
        title: "البريد الإلكتروني",
        subtitle: profile.email,
        leading: AppIcons.emailIcon,
      ),
      CustomListTile(
        title: "رقم الهاتف",
        subtitle: profile.phone,
        leading: AppIcons.phoneIcon,
      ),
      CustomListTile(
        title: "المدينة",
        subtitle: profile.address,
        leading: AppIcons.locationIcon,
      ),
    ]);
  }
}
