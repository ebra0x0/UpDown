import 'package:UpDown/core/utils/service_locator.dart';
import 'package:UpDown/features/issues/data/repo/issues_repo_imp.dart';
import 'package:UpDown/features/issues/presentation/manager/create_issue_cubit/create_issue_cubit.dart';
import 'package:UpDown/features/issues/presentation/widgets/create_issue_widgets/create_issue_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateIssueView extends StatelessWidget {
  const CreateIssueView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateIssueCubit(gitIt.get<IssuesRepoImp>()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('الإبلاغ عن عطل جديد'),
        ),
        body: CreateIssueBody(),
      ),
    );
  }
}
