import 'dart:io';
import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/extensions/ext_icon.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/custom_text_form_field.dart';
import 'package:UpDown/features/issues/presentation/manager/create_issue_cubit/create_issue_cubit.dart';
import 'package:UpDown/features/issues/presentation/widgets/create_issue_widgets/building_drop_down_builder.dart';
import 'package:UpDown/features/issues/presentation/widgets/create_issue_widgets/create_issue_button_builder.dart';
import 'package:UpDown/core/widgets/media_form_field.dart';
import 'package:UpDown/features/issues/presentation/widgets/create_issue_widgets/elevator_drop_down_builder.dart';
import 'package:UpDown/features/issues/presentation/widgets/create_issue_widgets/issue_drop_down_builder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateIssueFormBody extends StatefulWidget {
  final TextEditingController descriptionController;
  final Future<void> Function(BuildContext context) submit;
  const CreateIssueFormBody({
    super.key,
    required this.descriptionController,
    required this.submit,
  });

  @override
  State<CreateIssueFormBody> createState() => _CreateIssueFormBodyState();
}

class _CreateIssueFormBodyState extends State<CreateIssueFormBody> {
  void onMediaSelected(File file, MediaType mediaType) async {
    context.read<CreateIssueCubit>().selectMedia(file: file, type: mediaType);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MediaFormField(
          onMediaSelected: onMediaSelected,
        ),
        const SizedBox(height: 24),
        Row(
          spacing: 8,
          children: [
            Expanded(child: BuildingDropDownBuilder()),
            Expanded(child: ElevatorDropDownBuilder()),
          ],
        ),
        SizedBox(height: 16),
        IssueDropDownBuilder(),
        const SizedBox(height: 16),
        CustomTextFormField(
          controller: widget.descriptionController,
          keyType: TextInputType.multiline,
          labelText: "وصف العطل",
          maxLines: 6,
          maxLength: 200,
          prefixIcon: Styles.descriptionIcon.copyWith(
            color: AppTheme.primary,
          ),
          onChanged: (value) =>
              context.read<CreateIssueCubit>().updateDescription(value ?? ''),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "يرجى كتابة تفاصيل العطل";
            }
            return null;
          },
        ),
        SizedBox(height: 32),
        CreateIssueButtonBuilder(onPress: () => widget.submit(context)),
      ],
    );
  }

  @override
  void dispose() {
    widget.descriptionController.dispose();
    super.dispose();
  }
}
