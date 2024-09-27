import 'package:flutter/material.dart';

class TextStyles {
  static const TextStyle heading = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w600,
    fontSize: 23,
    color: Colors
        .black, // Replace with Theme.of(context).colorScheme.secondary in your widget
  );
  static const TextStyle title = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    fontSize: 20,
    color: Colors
        .black, // Replace with Theme.of(context).colorScheme.secondary in your widget
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.normal,
    fontSize: 18,
    color: Colors
        .black, // Replace with Theme.of(context).colorScheme.secondary in your widget
  );

  static const TextStyle body = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w100,
    fontSize: 16,
    // color: Colors.black, // Replace with Theme.of(context).colorScheme.secondary in your widget
  );

  static const TextStyle button = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
    fontSize: 12,
    color: Colors
        .white, // Replace with Theme.of(context).colorScheme.primary in your widget
  );
}
