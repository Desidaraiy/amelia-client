import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/helpers/colors.dart';
import '../../generated/l10n.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({Key key, this.stars}) : super(key: key);
  final int stars;
  @override
  Widget build(BuildContext context) {
    return Row(
      children:[
        for(int i=0;i<stars;i++)
        SvgPicture.asset( 'assets/icons/grade_300_24.svg',
          color: accent_200,),

        for(int i=5;stars<i;i--)
          SvgPicture.asset( 'assets/icons/grade_300_24.svg',
            color: neutral_100,),
SizedBox(width: 8,),
        Text(S.of(context).and_higher, style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color: neutral_500, height: 1.2)),)
      ]

    );
  }
}
