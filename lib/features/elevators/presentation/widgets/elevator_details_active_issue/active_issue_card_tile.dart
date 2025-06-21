import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/enums/enums_extensions.dart';
import 'package:UpDown/core/utils/extensions/ex_box_border.dart';
import 'package:UpDown/core/utils/extensions/ex_date_time.dart';
import 'package:UpDown/core/utils/extensions/ex_icon.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/bubble_icon.dart';
import 'package:UpDown/core/widgets/text_and_bubble_text_row.dart';
import 'package:UpDown/core/widgets/card_tile.dart';
import 'package:UpDown/features/issues/data/models/issue_summary_model.dart';
import 'package:flutter/widgets.dart';

class ActiveIssueCardTile extends StatelessWidget {
  final IssueSummaryModel activeIssue;

  const ActiveIssueCardTile({
    super.key,
    required this.activeIssue,
  });

  @override
  Widget build(BuildContext context) {
    return CardTile(
      decoration: BoxDecoration(
        color: AppTheme.red.withValues(alpha: 0.2),
        border: Styles.generalBoxBorder
            .copyWith(color: AppTheme.red.withValues(alpha: 0.2)),
        borderRadius: Styles.borderRadius18,
      ),
      leading: BubbleIcon(
        icon: Styles.errorOutlineIcon.copyWith(
          size: 22,
        ),
        color: AppTheme.red,
        padding: 8,
      ),
      title: Text("عطل ${activeIssue.issueType.priority(context)}",
          style: Styles.textStyle16.copyWith(
            color: AppTheme.red,
            fontWeight: FontWeight.w900,
          )),
      body: Text(
        activeIssue.issueType.title(context),
        style: Styles.textStyle14.copyWith(color: AppTheme.text),
      ),
      footer: TextAndbubbleTextRow(
          text: activeIssue.createdAt.toDateTimeFormat(),
          bubbleText: activeIssue.status.title(context),
          bubbleColor: AppTheme.red),
    );
  }
}
