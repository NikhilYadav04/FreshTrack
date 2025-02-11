import 'package:flutter/material.dart';
import 'package:flutter_sliding_toast/flutter_sliding_toast.dart';

ToastController toastSuccessSlide(BuildContext context,String title) {
  return InteractiveToast.slideSuccess(
    context,
    title: Text(
      "${title}",
      style: TextStyle(
        fontSize: 20,
        fontFamily: "Glacial_Bold",
        color: Colors.green.shade800
      ),
    ),
    toastSetting: SlidingToastSetting(
      toastStartPosition: ToastPosition.bottom,
      toastAlignment: Alignment(0, 0.9),
      maxHeight: 180,
      maxWidth: 400,
      animationDuration: Duration(seconds: 1),
      displayDuration: Duration(seconds: 4),
    ),
  );
}

ToastController toastErrorSlide(BuildContext context,String title) {
  return InteractiveToast.slideError(
    context,
    title: Text(
      "${title}",
      style: TextStyle(
        fontSize: 20,
        fontFamily: "Glacial_Bold",
        color: Colors.red
      ),
    ),
    toastSetting: SlidingToastSetting(
      toastStartPosition: ToastPosition.bottom,
      toastAlignment: Alignment(0, 0.9),
      maxHeight: 180,
      maxWidth: 400,
      animationDuration: Duration(seconds: 1),
      displayDuration: Duration(seconds: 4),
    ),
  );
}
