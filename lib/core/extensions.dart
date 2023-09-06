import 'package:chatapp_test/core/constants.dart';
import 'package:flutter/material.dart';

extension ResponsivenessExtension on BuildContext {
  bool get isNarrowScreen =>
      MediaQuery.of(this).size.width <= Constants.narrowScreenThreshold;
}

extension NavigatorExtension on BuildContext {
  void push(Widget screen) => Navigator.of(this).push(
        MaterialPageRoute(
          builder: (context) => screen,
        ),
      );

  void pop() => Navigator.of(this).pop();
}
