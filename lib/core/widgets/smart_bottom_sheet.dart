import 'package:UpDown/core/theme/app_theme.dart';
import 'package:flutter/widgets.dart';

class SmartBottomSheet extends StatelessWidget {
  const SmartBottomSheet({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7, // Min height (peek)
      minChildSize: 0.5, // Allow close
      maxChildSize: 1.0, // Max height (full)
      snap: true,
      snapSizes: const [0.7, 1.0],
      builder: (context, scrollController) {
        return Container(
          color: AppTheme.scaffoldColor,
          child: SafeArea(
            top: false,
            child: ListView(
              controller: scrollController,
              children: children,
            ),
          ),
        );
      },
    );
  }
}
