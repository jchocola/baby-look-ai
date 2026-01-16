import 'package:flutter/widgets.dart';
import 'package:toastification/toastification.dart';

void showSuccessCustomToastification({required String title}) {
  toastification.show(
    title: Text(title),
    style: ToastificationStyle.flatColored,
    autoCloseDuration: Duration(seconds: 3),
  );
}
