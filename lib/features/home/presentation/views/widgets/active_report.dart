import 'package:UpDown/constants.dart';
import 'package:flutter/material.dart';

class ActiveReport extends StatelessWidget {
  const ActiveReport({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kprimaryColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "العطل رقم: 12345#",
                  ),
                  SizedBox(height: 8),
                  Text("نوع العطل: المصعد متوقف"),
                  SizedBox(height: 8),
                  Text("المبنى: برج النور"),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: const [
                      Text(
                        "الحالة: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "جاري الإصلاح",
                        style: TextStyle(color: Colors.teal),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text("موعد الإصلاح المتوقع: 21 ديسمبر 2024"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
