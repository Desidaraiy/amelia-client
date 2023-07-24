import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/helpers/colors.dart';

class DeleteLabel extends StatelessWidget {
  const DeleteLabel({Key key, this.small, this.title}) : super(key: key);
  final bool small;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: small ?CrossAxisAlignment.end:CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          small == true
              ? 'assets/icons/delete_300_16.svg'
              : 'assets/icons/delete_300_24.svg',


          color: expanded_red_450,
        ),
        SizedBox(
          width: 2,
        ),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .button
              .merge(TextStyle(fontSize: 15, color: expanded_red_450,fontWeight: FontWeight.w400,height: small ?1.0:1.35)),
        )
      ],
    );
  }
}
