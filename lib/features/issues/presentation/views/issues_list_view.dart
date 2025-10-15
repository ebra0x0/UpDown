import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/features/issues/presentation/manager/issues_cubit/issues_cubit.dart';
import 'package:UpDown/features/issues/presentation/widgets/issues_list_view_widgets/issues_list_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IssuesListView extends StatefulWidget {
  const IssuesListView({super.key});

  @override
  State<IssuesListView> createState() => _IssuesListViewState();
}

class _IssuesListViewState extends State<IssuesListView> {
  @override
  void initState() {
    super.initState();
    context.read<IssuesCubit>().emitIssues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "قائمة الأعطال",
            style: AppTextStyles.textStyle22,
          ),
        ),
        body: IssuesListViewBody());
  }
}
