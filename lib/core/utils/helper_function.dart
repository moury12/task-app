
import 'package:flutter/material.dart';

class SnackbarService {
  static void showSnackbar({
    required BuildContext context,
    required String message,
    String? title,
    bool isError = false,
    Duration duration = const Duration(seconds: 3),
  }) {

    final snackBar = SnackBar(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isError ? Colors.red[300] : Colors.green[300],
              ),
            ),
          Text(message),
        ],
      ),
      backgroundColor: isError ? Colors.red : Colors.green,
      duration: duration,
    );

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}



