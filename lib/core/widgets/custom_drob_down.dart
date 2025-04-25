import 'package:UpDown/core/widgets/custom_card.dart';
import 'package:UpDown/features/issues/presentation/manager/create_issue_cubit/create_issue_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return CustomCard(
      padding: 0,
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 8),
              hintText: hint,
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
            onChanged: (value) {
              if (value != null) {
                context.read<CreateIssueCubit>().selectIssueType(value);
              }
            }),
      ),
    );
  }
}
