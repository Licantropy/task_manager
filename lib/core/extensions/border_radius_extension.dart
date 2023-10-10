import 'package:flutter/material.dart';

extension BorderRadiusExtension on int {
  BorderRadius get r => BorderRadius.circular(toDouble());
}