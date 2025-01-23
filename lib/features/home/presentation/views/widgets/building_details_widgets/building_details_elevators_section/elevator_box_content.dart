import 'package:UpDown/core/utils/pallete.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:UpDown/core/widgets/custom_card.dart';
import 'package:flutter/material.dart';

class ElevatorBoxContent extends StatelessWidget {
  const ElevatorBoxContent({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        children: [
          ElevatorBoxHeader(),
          ElevatorBoxBody(),
        ],
      ),
    );
  }
}

class ElevatorBoxBody extends StatelessWidget {
  const ElevatorBoxBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text('المصعد يعمل',
            style: Styles.textStyle14.copyWith(color: Pallete.textPrimary)),
      ),
    );
  }
}

class ElevatorBoxHeader extends StatelessWidget {
  const ElevatorBoxHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('مصعد 2',
            style: Styles.textStyle14.copyWith(color: Pallete.textSecondary)),
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Pallete.success.withValues(alpha: 0.2),
          ),
          child: Icon(
            Icons.circle,
            color: Pallete.success,
            size: 12,
          ),
        ),
      ],
    );
  }
}
