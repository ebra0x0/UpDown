import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:UpDown/features/issues/presentation/manager/create_issue_cubit/create_issue_cubit.dart';
import 'package:UpDown/features/issues/presentation/widgets/create_issue_widgets/create_issue_form_body.dart';

class CreateIssueForm extends StatefulWidget {
  const CreateIssueForm({
    super.key,
  });

  @override
  State<CreateIssueForm> createState() => _CreateIssueFormState();
}

class _CreateIssueFormState extends State<CreateIssueForm> {
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  final descriptionController = TextEditingController();

  Future<void> submit(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      FocusScope.of(context).unfocus();
      if (!context.mounted) return;
      await context.read<CreateIssueCubit>().createIssue();
      descriptionController.clear();
    } else {
      setState(() {
        autoValidateMode = AutovalidateMode.always;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        autovalidateMode: autoValidateMode,
        child: CreateIssueFormBody(
          descriptionController: descriptionController,
          submit: submit,
        ));
  }
}
