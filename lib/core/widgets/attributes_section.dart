import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/bubble_icon.dart';
import 'package:UpDown/core/widgets/custom_card.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AttributesSection extends StatelessWidget {
  const AttributesSection({super.key, required this.attributes});

  final List<Map<String, dynamic>> attributes;

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 8,
          crossAxisSpacing: 4,
          childAspectRatio: 1 / 1.4,
        ),
        itemCount: attributes.length,
        itemBuilder: (context, index) {
          return AttributeCard(
            attribute: attributes[index],
          );
        });
  }
}

class AttributeCard extends StatelessWidget {
  const AttributeCard({
    super.key,
    required this.attribute,
    this.isLoading = false,
  });

  final Map<String, dynamic> attribute;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BubbleIcon(
              icon: attribute['icon'] as Icon,
            ),
            Text(
              attribute['name'],
              style: Styles.textStyle14,
              textAlign: TextAlign.center,
            ),
            Text(
              attribute['value'],
              style: Styles.textStyle16.copyWith(fontWeight: FontWeight.w900),
              textAlign: TextAlign.center,
            )
          ],
        ));
  }
}
