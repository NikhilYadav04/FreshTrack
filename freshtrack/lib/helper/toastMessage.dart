import 'package:flutter/material.dart';
import 'package:freshtrack/styling/sizeConfig.dart';
import 'package:toastification/toastification.dart';

ToastificationItem toastMessage(BuildContext context, String title,
    String description, ToastificationType type) {
  return toastification.show(
    context: context,
    alignment: Alignment.bottomCenter,
    type: type,
    style: ToastificationStyle.flatColored,
    autoCloseDuration: const Duration(seconds: 5),
    title: Text(
      title,
      style: TextStyle(fontSize: 1.896 * SizeConfig.heightMultiplier),
    ),
    description: Text(
      description,
    ),
  );
}