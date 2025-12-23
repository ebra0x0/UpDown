import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/features/issues/presentation/manager/issues_cubit/issues_cubit.dart';
import 'package:UpDown/features/issues/presentation/widgets/all_issues_view_widgets/all_issues_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllIssuesView extends StatefulWidget {
  const AllIssuesView({super.key});

  @override
  State<AllIssuesView> createState() => _AllIssuesViewState();
}

class _AllIssuesViewState extends State<AllIssuesView> {
  @override
  void initState() {
    super.initState();
    context.read<IssuesCubit>().emitAllIssues();
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
        body: AllIssuesViewBody());
  }
}
