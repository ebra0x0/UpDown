import 'package:flutter/material.dart';

abstract class Styles {
  static const textStyle14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static const textStyle16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const textStyle18 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const textStyle20 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.normal,
  );

  static const textStyle26 = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
  );

  static const textStyle30 = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w900,
    letterSpacing: 1.2,
  );

  // Border Radius

  static const borderRadius4 = BorderRadius.all(Radius.circular(4));

  static const borderRadius6 = BorderRadius.all(Radius.circular(6));

  static const borderRadius8 = BorderRadius.all(Radius.circular(8));

  static const borderRadius12 = BorderRadius.all(Radius.circular(12));

  static const borderRadius14 = BorderRadius.all(Radius.circular(14));

  static const borderRadius18 = BorderRadius.all(Radius.circular(18));

  // Box Shadow

  static const boxShadow = BoxShadow(
    color: Color(0xFFE0E0E0),
    blurRadius: 5,
    offset: Offset(0, 4),
  );
}
