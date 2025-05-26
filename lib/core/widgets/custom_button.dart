import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.onPress,
    this.isLoading = false,
  });

  final String title;
  final Function() onPress;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 160,
        height: 50,
        child: TextButton(
          onPressed: isLoading ? null : onPress,
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: Styles.borderRadius8,
            )),
            backgroundColor: WidgetStatePropertyAll(AppTheme.primary),
          ),
          child: isLoading
              ? LoadingIndicator(
                  color: Colors.white,
                )
              : Text(title,
                  style: Styles.textStyle16.copyWith(color: Colors.white)),
        ));
  }
}
