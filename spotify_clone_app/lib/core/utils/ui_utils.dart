import 'package:flutter/material.dart';
import 'package:spotify_clone_app/core/errors/failure.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
}

void handleError(
  BuildContext context,
  Object error, {
  StackTrace? st,
  String? message,
  bool snackBar = true,
}) {
  if (error is Failure) {
    if (snackBar) {
      showSnackBar(context, error.message);
    }
  } else {
    debugPrint(error.toString());
    debugPrint(st.toString());
    if (snackBar) {
      showSnackBar(context, message ?? 'Unexpected error occurred!');
    }
  }
}
