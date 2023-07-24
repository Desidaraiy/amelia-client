import "package:flutter/material.dart";
import 'package:markets/src/helpers/colors.dart';

ScaffoldFeatureController snackbarMessage(
    BuildContext context, String message, bool error, bool info) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(milliseconds: 2500),
    elevation: 1.0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: error
        ? expanded_red_50
        : info
            ? neutral_100
            : expanded_green_50,
    content: Flexible(
      child: Padding(
        padding: EdgeInsets.zero,
        child: Text(
          message,
          style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(
              height: 1.0,
              color: error
                  ? semantic_error
                  : info
                      ? semantic_info
                      : semantic_success)),
        ),
      ),
    ),
  ));
}
