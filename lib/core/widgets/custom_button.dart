import 'package:UpDown/core/utils/pallete.dart';
import 'package:UpDown/core/utils/styles.dart';
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
            backgroundColor: WidgetStatePropertyAll(Pallete.primary),
          ),
          child: isLoading
              ? SizedBox(
                  width: 25,
                  height: 25,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Text(title,
                  style: Styles.textStyle16.copyWith(color: Colors.black87)),
        ));
  }
}
