import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:markets/src/helpers/colors.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    Key key,
    this.btn_icon,
    this.text,
    this.small,
    this.onPressed,
  }) : super(key: key);
  final Widget btn_icon;
  final String text;
  final bool small;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.all(12)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: text.isNotEmpty ?BorderRadius.circular(10.0): BorderRadius.circular(5.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(primary_50),
        elevation: MaterialStateProperty.all(0),
      ),
      onPressed: onPressed,
      child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          btn_icon,
          !small
              ? SizedBox(
                  width: 8,
                )
              : SizedBox(),
          Text(
            small == true ? '' : text,
            style: !small
                ? Theme.of(context).textTheme.button.merge(TextStyle(
                    fontSize: 14.05,
                    color: primary_700,
                    fontWeight: FontWeight.w400,
                    height: 1.30))
                : Theme.of(context).textTheme.button,
          )
        ],
      ),
    );
  }
}
