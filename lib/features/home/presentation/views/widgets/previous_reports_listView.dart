import 'package:flutter/material.dart';

class PreviousReportsListView extends StatelessWidget {
  const PreviousReportsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Row(children: [
            Expanded(
              child: ListTile(
                title: const Text("العطل رقم: 12345#"),
                subtitle: const Text("نوع العطل: المصعد متوقف"),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {},
                ),
              ),
            ),
          ]);
        });
  }
}
