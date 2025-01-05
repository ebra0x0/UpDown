import 'package:UpDown/constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.onPress,
  });

  final String title;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 160,
        height: 50,
        child: ElevatedButton(
          onPressed: onPress,
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            )),
            backgroundColor: WidgetStatePropertyAll(kprimaryColor),
          ),
          child: const Text("إرسال",
              style: TextStyle(fontSize: 20, color: Colors.white)),
        ));
  }
}
