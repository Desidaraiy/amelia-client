import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/helpers/colors.dart';

class SwitchButton extends StatelessWidget {
  const SwitchButton({Key key, this.onPressed, this.add, this.minimum})
      : super(key: key);
  final void Function() onPressed;
  final bool add;
  final bool minimum;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(horizontal: 0.0,)),
        minimumSize: MaterialStateProperty.all<Size>(Size(32, 32)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        backgroundColor: minimum == true
            ? MaterialStateProperty.all(neutral_150)
            : MaterialStateProperty.all(neutral_500),
        elevation: MaterialStateProperty.all(0),
      ),
      onPressed: onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          add == true
              ? SvgPicture.asset(
                  'assets/icons/add_300.svg',
                  color: primary_50,
                )
              : SvgPicture.asset('assets/icons/remove_300.svg',
                  color: primary_50)
        ],
      ),
    );
  }
}
