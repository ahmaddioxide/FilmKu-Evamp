import 'package:flutter/material.dart';
import 'package:get/get.dart';


customSnackBar({
  required String message,
}) {
  Get.showSnackbar(
    GetSnackBar(
      message: message,
      duration: const Duration(seconds: 1),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black,
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      isDismissible: true,

    ),
  );
}