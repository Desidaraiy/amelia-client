import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:markets/src/helpers/colors.dart';

class PrimaryButtonLoader extends StatelessWidget {
  const PrimaryButtonLoader({
    Key key,
    this.text,
    this.small,
    this.onPressed,
    this.left_padding,
    this.right_padding,
    this.top_padding,
    this.bottom_padding,
    this.border_radius,
    this.icon,
    this.buttonText,
    this.min_width,
    this.min_height,
    this.enabled = true,
    this.isLoading = false, // Новая переменная
  }) : super(key: key);

  final String text;
  final bool small;
  final void Function() onPressed;
  final double left_padding;
  final double right_padding;
  final double top_padding;
  final double bottom_padding;
  final double border_radius;
  final Widget icon;
  final bool buttonText;
  final double min_width;
  final double min_height;
  final bool enabled;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return buttonText
        ? Container(
            width: min_width ?? double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(
                    left_padding, top_padding, right_padding, bottom_padding)),
                minimumSize: MaterialStateProperty.all<Size>(
                    Size(min_width, min_height)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(border_radius),
                  ),
                ),
                backgroundColor: enabled
                    ? MaterialStateProperty.all(secondary_300)
                    : MaterialStateProperty.all(neutral_500),
                elevation: MaterialStateProperty.all(0),
              ),
              onPressed: isLoading ? null : onPressed,
              child: isLoading
                  ? Container(
                      width: 20.0,
                      height: 20.0,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        icon != null ? icon : Container(),
                        Text(
                          text,
                          style: small == true
                              ? Theme.of(context)
                                  .textTheme
                                  .button
                                  .merge(TextStyle(
                                    fontSize: 14.05,
                                    fontWeight: FontWeight.w400,
                                    height: 1.3,
                                  ))
                              : Theme.of(context).textTheme.button,
                        ),
                      ],
                    ),
            ),
          )
        : ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                  EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4)),
              minimumSize: MaterialStateProperty.all<Size>(Size(44.0, 44.0)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              backgroundColor: MaterialStateProperty.all(secondary_300),
              elevation: MaterialStateProperty.all(0),
            ),
            onPressed: enabled && !isLoading ? onPressed : null,
            child: isLoading ? CircularProgressIndicator() : icon,
          );
  }
}
