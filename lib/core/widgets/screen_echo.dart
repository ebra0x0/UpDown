import 'package:UpDown/core/theme/app_text_styles.dart';
import 'package:UpDown/core/theme/app_theme.dart';

import 'package:flutter/widgets.dart';

class ScreenEcho extends StatelessWidget {
  const ScreenEcho({
    super.key,
    this.image,
    required this.message,
  });

  final ImageProvider? image;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (image != null)
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: image!,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              )),
            ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles.textStyle18.copyWith(
              color: AppTheme.grey,
            ),
          ),
        ],
      ),
    );
  }
}
