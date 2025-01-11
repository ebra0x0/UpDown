import 'package:UpDown/constants.dart';
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
        child: ElevatedButton(
          onPressed: isLoading ? null : onPress,
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            )),
            backgroundColor: WidgetStatePropertyAll(kprimaryColor),
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
                  style: TextStyle(fontSize: 20, color: Colors.white)),
        ));
  }
}
