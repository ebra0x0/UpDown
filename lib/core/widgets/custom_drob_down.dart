import 'package:UpDown/core/utils/extensions/ext_icon.dart';
import 'package:UpDown/core/utils/pallete.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/features/issues/presentation/manager/create_issue_cubit/create_issue_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDrobDown extends StatelessWidget {
  const CustomDrobDown({
    super.key,
    required this.listItem,
    required this.hint,
    required this.value,
  });
  final Map<String, String>? listItem;
  final String hint;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
        decoration: InputDecoration(
          errorBorder: Styles.errorBorder,
          enabledBorder: Styles.enabledBorder,
          border: Styles.generalBorder,
          focusedBorder: Styles.focusedBorder,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 4.sp, vertical: 14.sp),
          hintText: hint,
          prefixIcon: Styles.errorIcon.copyWith(color: Pallete.lightSecondary),
        ),
        value: value,
        menuMaxHeight: 250,
        isExpanded: true,
        items: listItem == null
            ? []
            : listItem!.entries.map((issue) {
                return DropdownMenuItem<String>(
                  value: issue.key,
                  child: Text(
                    issue.value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
        validator: (value) {
          if (value == null) {
            return "نوع العطل مطلوب";
          }
          return null;
        },
        onChanged: (value) {
          if (value != null) {
            context.read<CreateIssueCubit>().selectIssueType(value);
          }
        });
  }
}
