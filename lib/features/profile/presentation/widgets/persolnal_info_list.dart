import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/extensions/ext_icon.dart';
import 'package:UpDown/core/utils/model/profile_model.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/custom_list_tile.dart';
import 'package:flutter/widgets.dart';

class PersonalInfoList extends StatelessWidget {
  const PersonalInfoList({
    super.key,
    required this.profile,
  });

  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return Column(spacing: 12, children: [
      CustomListTile(
        title: "الاسم",
        subtitle: profile.name,
        leading: Styles.userIcon.copyWith(
          color: AppTheme.grey,
        ),
      ),
      Visibility(
          visible: profile.email != null,
          child: CustomListTile(
            title: "البريد الإلكتروني",
            subtitle: profile.email,
            leading: Styles.emailIcon,
          )),
      CustomListTile(
        title: "رقم الهاتف",
        subtitle: profile.phone,
        leading: Styles.phoneIcon,
      ),
      CustomListTile(
        title: "المدينة",
        subtitle: profile.address,
        leading: Styles.locationIcon,
      ),
    ]);
  }
}
