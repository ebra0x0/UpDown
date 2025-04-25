import 'dart:io';

import 'package:UpDown/core/utils/app_router.dart';
import 'package:UpDown/core/utils/enums/enums.dart';
import 'package:UpDown/core/utils/pallete.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/custom_text_form_field.dart';
import 'package:UpDown/core/widgets/media_selector_box.dart';
import 'package:UpDown/features/issues/presentation/manager/create_issue_cubit/create_issue_cubit.dart';
import 'package:UpDown/features/issues/presentation/widgets/create_issue_widgets/building_drob_down_builder.dart';
import 'package:UpDown/features/issues/presentation/widgets/create_issue_widgets/create_issue_button_builder.dart';
import 'package:UpDown/features/issues/presentation/widgets/create_issue_widgets/elevator_drob_down_builder.dart';
import 'package:UpDown/features/issues/presentation/widgets/create_issue_widgets/issue_drob_down_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateIssueForm extends StatefulWidget {
  const CreateIssueForm({
    super.key,
  });

  @override
  State<CreateIssueForm> createState() => _CreateIssueFormState();
}

class _CreateIssueFormState extends State<CreateIssueForm> {
  final formKey = GlobalKey<FormState>();

  final descriptionController = TextEditingController();

  void onMediaSelected(File file, MediaType mediaType) {
    context.read<CreateIssueCubit>().selectMedia(file: file, type: mediaType);
  }

  Future<void> submit(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      FocusScope.of(context).unfocus();
      await context.read<CreateIssueCubit>().createIssue();

      // ignore: use_build_context_synchronously
      if (context.read<CreateIssueCubit>().state is CreateIssueSuccess) {
        // ignore: use_build_context_synchronously
        context.go(AppRouter.khomeView);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CreateIssueCubit>().state;
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                MediaSelectorBox(
                  onMediaSelected: onMediaSelected,
                ),
                const SizedBox(height: 24),
                Row(
                  spacing: 8,
                  children: [
                    Expanded(child: BuildingDrobDownBuilder()),
                    Expanded(child: ElevatorDrobDownBuilder()),
                  ],
                ),
                SizedBox(height: 16),
                IssueDrobDownBuilder(),
                const SizedBox(height: 16),
                CustomTextFormField(
                  controller: descriptionController,
                  keyType: TextInputType.multiline,
                  labelText: "وصف العطل",
                  maxLines: 6,
                  onChanged: (value) => context
                      .read<CreateIssueCubit>()
                      .updateDescription(value ?? ''),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "يرجى كتابة وصف العطل";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32),
                CreateIssueButtonBuilder(onPress: () => submit(context)),
                const SizedBox(height: 24),
                if (state is CreateIssueError)
                  Text(state.error,
                      style: Styles.textStyle16
                          .copyWith(color: Pallete.lightError))
              ],
            ),
          )),
    );
  }
}
