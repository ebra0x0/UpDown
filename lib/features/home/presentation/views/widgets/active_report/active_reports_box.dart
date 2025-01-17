import 'package:UpDown/core/utils/pallete.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/utils/model/report_model.dart';
import 'package:flutter/material.dart';

class ActiveReportsBox extends StatelessWidget {
  const ActiveReportsBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Text("الفردوس :",
              style: Styles.textStyle14.copyWith(color: Pallete.primary)),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Pallete.primary,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(children: [
              Row(
                children: [
                  Text(
                    "جاري الإصلاح",
                    style: Styles.textStyle14,
                  ),
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                        color: Pallete.secondry,
                        borderRadius: BorderRadius.circular(8)),
                  )
                ],
              ),
              Center(
                child: Text(
                  "المصعد متوقف",
                  style: Styles.textStyle16,
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                children: [Text("الأثنين 12")],
              )
            ]),
          ),
        ],
      ),
    );
  }
}

class ActiveReportContent extends StatelessWidget {
  const ActiveReportContent({
    required this.reportModel,
    super.key,
  });

  final ReportModel reportModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "العطل رقم : ${reportModel.reportId}",
                style: Styles.textStyle14,
              ),
              SizedBox(height: 8),
              // Text(
              //   "نوع العطل: ${reportModel.}",
              //   style: Styles.textStyle14,
              // ),
              SizedBox(height: 8),
              // Text(
              //   "المبنى: ${reportModel.}",
              //   style: Styles.textStyle14,
              // ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text(
                    "الحالة: ",
                    style: Styles.textStyle14,
                  ),
                  Text(reportModel.status,
                      style: Styles.textStyle14
                          .copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
