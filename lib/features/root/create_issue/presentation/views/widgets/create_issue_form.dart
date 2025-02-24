import 'package:UpDown/constants.dart';
import 'package:UpDown/core/utils/app_router.dart';
import 'package:UpDown/core/utils/manager/user_cubit/cubit/user_data_cubit.dart';
import 'package:UpDown/core/widgets/custom_button.dart';
import 'package:UpDown/core/widgets/custom_text_form_field.dart';
import 'package:UpDown/core/widgets/media_selector_box.dart';
import 'package:UpDown/core/widgets/custom_drob_down.dart';
import 'package:UpDown/features/root/create_issue/presentation/manager/cubit/create_issue_cubit.dart';
import 'package:UpDown/features/root/create_issue/presentation/views/widgets/building_dropdown.dart';
import 'package:UpDown/features/root/create_issue/presentation/views/widgets/elevator_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateReportForm extends StatefulWidget {
  const CreateReportForm({
    super.key,
  });

  @override
  State<CreateReportForm> createState() => _CreateReportFormState();
}

class _CreateReportFormState extends State<CreateReportForm> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    Future<void> submit() async {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();

        await BlocProvider.of<CreateIssueCubit>(context).createIssue();

        context.go(AppRouter.khomeView);
      }
    }

    print(BlocProvider.of<UserDataCubit>(context).userData);

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Form(
          key: formKey,
          child: Column(
            children: [
              MediaSelectorBox(),
              const SizedBox(height: 24),
              Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 64,
                      child: BuildingDropdown(
                          buildings: BlocProvider.of<CreateIssueCubit>(context)
                              .buildings),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 64,
                      child: ElevatorDropdown(
                          elevators: BlocProvider.of<CreateIssueCubit>(context)
                              .elevators),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              BlocBuilder<CreateIssueCubit, CreateIssueState>(
                builder: (context, state) {
                  return CustomDrobDown(
                    listItem: kIssuesList,
                    hint: "إختر نوع العطل",
                    value: state is SelectSuccess ? state.issueType : null,
                  );
                },
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                keyType: TextInputType.multiline,
                labelText: "وصف العطل",
                maxLines: 6,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "يرجى كتابة وصف العطل";
                  } else {
                    context.read<CreateIssueCubit>().updateDescription(value);
                  }
                  return null;
                },
              ),
              SizedBox(height: 32),
              BlocBuilder<CreateIssueCubit, CreateIssueState>(
                builder: (context, state) => CustomButton(
                    title: "إبلاغ",
                    isLoading: state is CreateIssueLoading,
                    onPress: submit),
              ),
            ],
          )),
    );
  }
}
