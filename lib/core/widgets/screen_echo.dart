import 'package:UpDown/core/theme/app_theme.dart';
import 'package:UpDown/core/utils/styles.dart';
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
            style: Styles.textStyle18.copyWith(
              color: AppTheme.grey,
            ),
          ),
        ],
      ),
    );
  }
}
