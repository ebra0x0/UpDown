import 'package:UpDown/core/utils/manager/auth_cubit/cubit/auth_cubit.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildActionSection extends StatefulWidget {
  const BuildActionSection({super.key, required this.email});

  final String email;

  @override
  State<BuildActionSection> createState() => _BuildActionSectionState();
}

class _BuildActionSectionState extends State<BuildActionSection> {
  bool isButtonVisible = false;
  bool isSent = false;

  @override
  void initState() {
    super.initState();
    showButtonAfterDuration();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return isButtonVisible
          ? Column(
              children: [
                (isSent)
                    ? CustomButton(
                        onPress: () {},
                        title: 'فعلت الحساب ؟',
                        isLoading: state is AuthStateLoading,
                      )
                    : CustomButton(
                        onPress: () async {
                          await context
                              .read<AuthCubit>()
                              .sendConfirmationEmail(email: widget.email);

                          if (state is AuthStateError) {
                            return;
                          }
                          setState(() {
                            isSent = true;
                          });
                        },
                        title: 'لم يصلك الرمز ؟',
                        isLoading: state is AuthStateLoading,
                      ),
                const SizedBox(height: 20),
                Text(
                  state is AuthStateError
                      ? state.errorMsg
                      : isSent
                          ? 'تم إرسال الرمز '
                          : '',
                  textAlign: TextAlign.center,
                  style: Styles.textStyle14.copyWith(color: Colors.grey),
                )
              ],
            )
          : SizedBox();
    });
  }

  void showButtonAfterDuration() {
    Future.delayed(const Duration(seconds: 45), () {
      setState(() {
        isButtonVisible = true;
      });
    });
  }
}
