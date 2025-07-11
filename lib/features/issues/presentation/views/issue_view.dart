import 'package:UpDown/features/issues/presentation/manager/issue_details_cubit/issue_details_cubit.dart';
import 'package:UpDown/features/issues/presentation/widgets/issue_details_widgets/issue_view_builder.dart';
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
    context.read<IssueDetailsCubit>().call(widget.issueId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IssueViewBuilder(),
    );
  }
}
