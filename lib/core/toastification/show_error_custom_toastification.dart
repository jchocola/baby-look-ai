import 'package:flutter/widgets.dart';
import 'package:toastification/toastification.dart';

void showErrorCustomToastification({required String title}) {
  toastification.show(
    title: Text(title),
    style: ToastificationStyle.flatColored,
    type: ToastificationType.error,
    autoCloseDuration: Duration(seconds: 3),
  );
}
