import 'package:flutter/material.dart';

class ReportDrobDown extends StatefulWidget {
  const ReportDrobDown({
    super.key,
    required this.onChanged,
  });

  final void Function(String?) onChanged;

  @override
  State<ReportDrobDown> createState() => _ReportDrobDownState();
}

class _ReportDrobDownState extends State<ReportDrobDown> {
  final List<String> elevatorIssues = const [
    "باب المصعد لا يغلق",
    "المصعد لا يعمل",
    "إضاءة المصعد معطلة",
    "توقف المصعد بين الطوابق",
    "ضوضاء أثناء التشغيل",
    "عطل غير محدد"
  ];
  String? selectedIssue;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
              value: selectedIssue,
              menuMaxHeight: 250,
              isExpanded: true,
              hint: Text("اختر نوع العطل"),
              items: elevatorIssues.map((issue) {
                return DropdownMenuItem<String>(
                  value: issue,
                  child: Text(issue),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedIssue = value;
                  widget.onChanged(value);
                });
              }),
        ));
  }
}
