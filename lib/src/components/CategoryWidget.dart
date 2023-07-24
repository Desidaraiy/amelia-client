import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/helpers/colors.dart';
import 'package:markets/src/models/category.dart';
import 'package:markets/src/models/route_argument.dart';
import '../../generated/l10n.dart';

class MyWing extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final firstEndPoint = Offset(10, size.height * 0.7);
    final firstControlPoint = Offset(35, size.height * 0.7);

    return Path()
      ..lineTo(0, size.height)
      ..quadraticBezierTo(firstEndPoint.dx, firstEndPoint.dy,
          firstControlPoint.dx, firstControlPoint.dy)
      ..lineTo(size.width, size.height * 0.7)
      ..lineTo(size.width, 0)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class CustomCategory extends StatefulWidget {
  const CustomCategory(
      {Key key,
      this.title,
      this.categoryPhoto,
      this.price,
      this.free,
      this.category,
      this.onTap,
      this.enableBorder})
      : super(key: key);
  final String title;
  final Widget categoryPhoto;
  final String price;
  final bool free;
  final bool enableBorder;
  final Category category;
  final VoidCallback onTap;
  @override
  _CustomCategoryState createState() => _CustomCategoryState();
}

class _CustomCategoryState extends State<CustomCategory> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.onTap == null) {
          Navigator.of(context).pushNamed('/Category',
              arguments: RouteArgument(id: widget.category.id));
        } else {
          widget.onTap();
        }
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
        width: widget.enableBorder ? 76 : 74,
        height: 82,
        decoration: BoxDecoration(
            color: primary_50,
            border: widget.enableBorder
                ? Border.all(
                    color: secondary_300, width: 1.0, style: BorderStyle.solid)
                : null,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 32,
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(left: 4, right: 4),
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.overline.merge(TextStyle(
                      fontSize: 10.84, color: primary_700, height: 1.2)),
                ),
              ),
            ),
            widget.price.isEmpty
                ? SizedBox(
                    height: 8,
                  )
                : SizedBox(
                    height: 2,
                  ),
            Expanded(
              child: Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: Container(
                              height: 24,
                              width: 24,
                              alignment: Alignment.bottomLeft,
                              padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                              child: SvgPicture.asset(
                                  'assets/icons/left_wing.svg',
                                  fit: BoxFit.cover)),
                        ),
                      ],
                    ),
                    widget.categoryPhoto,
                    Column(
                      children: [
                        Expanded(
                          child: Container(
                              height: 24,
                              width: 24,
                              alignment: Alignment.topRight,
                              padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                              child: SvgPicture.asset(
                                'assets/icons/right_wing.svg',
                                fit: BoxFit.cover,
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            widget.price.isNotEmpty
                ? SizedBox(
                    height: 2,
                  )
                : SizedBox(),
            widget.price.isEmpty
                ? SizedBox()
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget.free
                          ? Text(
                              S.of(context).free,
                              style: Theme.of(context).textTheme.overline.merge(
                                  TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: expanded_green_400)),
                            )
                          : Row(
                              children: [
                                Text(
                                  "от",
                                  style: Theme.of(context)
                                      .textTheme
                                      .overline
                                      .merge(TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: expanded_green_400)),
                                ),
                                SizedBox(
                                  width: 1,
                                ),
                                Text(
                                  widget.price,
                                  style: Theme.of(context)
                                      .textTheme
                                      .overline
                                      .merge(TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: expanded_green_400)),
                                ),
                                SizedBox(
                                  width: 1,
                                ),
                                Text(
                                  '₽',
                                  style: Theme.of(context)
                                      .textTheme
                                      .overline
                                      .merge(TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: expanded_green_400)),
                                ),
                              ],
                            ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
