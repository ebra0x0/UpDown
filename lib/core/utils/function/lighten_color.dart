import 'package:flutter/material.dart';

Color lightenColor({required Color color, double lightRate = 0.1}) {
  lightRate = lightRate.clamp(0, 1);
  // return Color.fromARGB(
  //   color.alpha,
  //   (color.red + ((255 - color.red) * lightRate)).toInt(),
  //   (color.green + ((255 - color.green) * lightRate)).toInt(),
  //   (color.blue + ((255 - color.blue) * lightRate)).toInt(),
  // );
  return color.withAlpha((color.a * (1 - lightRate)).toInt());
}
