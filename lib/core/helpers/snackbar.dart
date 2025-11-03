import 'package:flutter/material.dart';

class Snackbar {
  // Generic Snackbar
  static void showSnackbar(
    BuildContext context, {
    required String message,
    Color backgroundColor = Colors.black87,
    Duration duration = const Duration(seconds: 3),
  }) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: backgroundColor,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(16),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  // Success Snackbar
  static void showSuccess(
    BuildContext context, {
    required String message,
  }) {
    showSnackbar(
      context,
      message: message,
      backgroundColor: Colors.green,
    );
  }

  // Error Snackbar
  static void showError(
    BuildContext context, {
    required String message,
  }) {
    showSnackbar(
      context,
      message: message,
      backgroundColor: Colors.red,
    );
  }

  // Warning Snackbar
  static void showWarning(
    BuildContext context, {
    required String message,
  }) {
    showSnackbar(
      context,
      message: message,
      backgroundColor: Colors.orange,
    );
  }
}
