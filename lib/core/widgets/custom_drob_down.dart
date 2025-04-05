import 'package:UpDown/core/utils/pallete.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/features/root/create_issue/presentation/manager/cubit/create_issue_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDrobDown extends StatelessWidget {
  const CustomDrobDown({
    super.key,
    required this.listItem,
    required this.hint,
    required this.value,
  });
  final Map<String, String> listItem;
  final String hint;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Pallete.lightCard,
            borderRadius: Styles.borderRadius8,
            boxShadow: [Styles.boxShadow]),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
              padding: EdgeInsets.all(8),
              dropdownColor: Colors.white,
              value: value,
              menuMaxHeight: 250,
              isExpanded: true,
              hint: Text(hint),
              items: listItem.entries.map((issue) {
                return DropdownMenuItem<String>(
                  value: issue.key,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Text(issue.value),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  context.read<CreateIssueCubit>().selectIssueType(value);
                }
              }),
        ));
  }
}
