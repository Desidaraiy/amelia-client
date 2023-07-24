import 'package:flutter/material.dart';
import 'package:markets/src/helpers/colors.dart';

class ProductTagWidget extends StatelessWidget {
  const ProductTagWidget(
      {Key key, this.text, this.tagColor, this.topPadding, this.bottomPadding, this.icon})
      : super(key: key);
  final String text;
  final Color tagColor;
  final double topPadding;
  final double bottomPadding;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: expanded_light_neutral_50,
          borderRadius: BorderRadius.all(Radius.circular(3))),
      child: Padding(
        padding: EdgeInsets.fromLTRB(8, topPadding, 8, bottomPadding),
        child: Row(
          children: [
            icon !=null ? Row(
              children: [
                icon,
                SizedBox(width: 4,),
              ],
            ) :SizedBox(),
            Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .merge(TextStyle(color: tagColor,height: 1.15,)
            ),
            ),
          ],
        ),
      ),
    );
  }
}
