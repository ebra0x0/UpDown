import 'package:UpDown/core/utils/model/building_model.dart';
import 'package:UpDown/core/utils/styles.dart';
import 'package:flutter/material.dart';

class BuildingsGridViewBox extends StatefulWidget {
  const BuildingsGridViewBox({
    super.key,
    required this.building,
  });

  final BuildingModel building;

  @override
  State<BuildingsGridViewBox> createState() => _BuildingsGridViewBoxState();
}

class _BuildingsGridViewBoxState extends State<BuildingsGridViewBox> {
  double _scale = 1;
  double _opacity = 1;
  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _scale,
      duration: Duration(milliseconds: 100),
      child: AnimatedOpacity(
        opacity: _opacity,
        duration: Duration(milliseconds: 100),
        child: GestureDetector(
          onTap: () {
            print("tap");
          },
          onTapDown: (d) {
            setState(() {
              _scale = .9;
              _opacity = .5;
            });
          },
          onTapUp: (d) {
            setState(() {
              _scale = 1;
              _opacity = 1;
            });
          },
          child: Container(
            padding: EdgeInsets.all(16),
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.building.name,
                            style: Styles.textStyle18,
                          ),
                          Text(
                            "${widget.building.elevators.length} مصعد",
                            style:
                                Styles.textStyle14.copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.apartment_rounded,
                        size: 24,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "",
                        style: Styles.textStyle14.copyWith(color: Colors.green),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.grey,
                      ),
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
