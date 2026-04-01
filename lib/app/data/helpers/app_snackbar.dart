import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showAppSnackbar({
  required String title,
  required String message,
  bool isError = false,
}) {
  final theme = Get.theme;
  final scheme = theme.colorScheme;

  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.all(12),
    borderRadius: 12,

    backgroundColor: isError
        ? scheme.error.withValues(alpha: .9)
        : Colors.green.withValues(alpha: .9),
    colorText: Colors.white,
    icon: Icon(
      isError ? Icons.error_outline : Icons.check_circle_outline,
      color: Colors.white,
    ),
    duration: const Duration(seconds: 3),
    animationDuration: const Duration(milliseconds: 300),
    boxShadows: [
      BoxShadow(
        color: Colors.black.withValues(alpha: .15),
        blurRadius: 10,
        offset: const Offset(0, 4),
      )
    ],
  );
}