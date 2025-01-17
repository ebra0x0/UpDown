import 'package:UpDown/core/widgets/custom_button.dart';
import 'package:UpDown/core/widgets/custom_text_form_field.dart';
import 'package:UpDown/core/widgets/media_selector_box.dart';
import 'package:UpDown/features/create_report/presentation/views/widgets/report_drob_down.dart';
import 'package:flutter/material.dart';

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

    final Map<String, String> reportData = {
      "building_name": "",
      "reporter_name": "",
      "issue_type": "",
      "floor_number": "",
      "elevator_number": "",
      "issue_description": "",
    };

    void updateIssueType(String? selectedIssue) =>
        reportData["issue_type"] = selectedIssue!;

    return Form(
        key: formKey,
        child: Column(
          children: [
            MediaSelectorBox(),
            const SizedBox(height: 16),
            CustomTextFormField(
              keyType: TextInputType.text,
              onChanged: (value) => reportData["building_name"] = value!,
              labelText: "إسم المبنى",
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              keyType: TextInputType.text,
              onChanged: (value) => reportData["reporter_name"] = value!,
              labelText: "إسم المبلغ",
            ),
            const SizedBox(height: 16),
            ReportDrobDown(onChanged: updateIssueType),
            const SizedBox(height: 16),
            CustomTextFormField(
              onChanged: (value) => reportData["floor_number"] = value!,
              keyType: TextInputType.number,
              labelText: "رقم الطابق",
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              onChanged: (value) => reportData["elevator_number"] = value!,
              keyType: TextInputType.number,
              labelText: "رقم المصعد",
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              onChanged: (value) => reportData["issue_description"] = value!,
              keyType: TextInputType.text,
              labelText: "وصف العطل",
            ),
            SizedBox(height: 32),
            CustomButton(
                title: "إبلاغ",
                onPress: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                  }
                }),
          ],
        ));
  }
}
