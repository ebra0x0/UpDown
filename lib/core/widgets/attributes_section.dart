import 'package:flutter/material.dart';

class AttributesSection extends StatelessWidget {
  const AttributesSection({super.key, required this.attributes});

  final List<Map<String, dynamic>> attributes;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: attributes.map((e) => AttributeBox(attribute: e)).toList());
  }
}

class AttributeBox extends StatelessWidget {
  const AttributeBox({super.key, required this.attribute});

  final Map<String, dynamic> attribute;

  @override
  Widget build(BuildContext context) {
    return Column(spacing: 4, children: [
      Icon(attribute["icon"], color: Colors.grey),
      Text(attribute["title"]),
    ]);
  }
}
