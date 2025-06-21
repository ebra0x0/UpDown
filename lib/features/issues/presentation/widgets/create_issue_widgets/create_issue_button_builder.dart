import 'package:UpDown/core/widgets/custom_button.dart';
import 'package:UpDown/features/issues/presentation/manager/create_issue_cubit/create_issue_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateIssueButtonBuilder extends StatelessWidget {
  const CreateIssueButtonBuilder({
    super.key,
    required this.onPress,
  });

  final Future<void> Function() onPress;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateIssueCubit, CreateIssueState>(
      builder: (context, state) => CustomButton(
          title: "إبلاغ",
          isLoading: state.status == CreateIssueStatus.loading,
          onPress: onPress),
    );
  }
}
