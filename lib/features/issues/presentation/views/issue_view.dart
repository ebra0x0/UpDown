import 'package:UpDown/features/issues/presentation/manager/issues_cubit/issues_cubit.dart';
import 'package:UpDown/features/issues/presentation/widgets/issue_details_widgets/issue_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IssueView extends StatefulWidget {
  final String issueId;
  const IssueView({super.key, required this.issueId});

  @override
  State<IssueView> createState() => _IssueViewState();
}

class _IssueViewState extends State<IssueView> {
  @override
  void initState() {
    super.initState();
    context.read<IssuesCubit>().selectIssue(widget.issueId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IssueViewBody(),
    );
  }
}
