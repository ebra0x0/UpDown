import 'package:UpDown/core/utils/pallete.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:flutter/material.dart';

class PreviousReportItem extends StatelessWidget {
  const PreviousReportItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: ButtonStyle(
          overlayColor:
              WidgetStatePropertyAll(Pallete.primary.withValues(alpha: 0.3)),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: Styles.borderRadius4,
          ))),
      child: ListTile(
        leading: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4)),
        ),
        title: Text(
          "العطل رقم: 12345#",
          style: Styles.textStyle14,
        ),
        subtitle: Text("نوع العطل: المصعد متوقف", style: Styles.textStyle14),
        trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_forward_ios_rounded)),
      ),
    );
  }
}
