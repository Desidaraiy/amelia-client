import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:markets/src/helpers/colors.dart';

class ProductSet extends StatelessWidget {
  const ProductSet(
      {Key key,
      this.setName,
      this.imgName,
      this.favorite,
      this.width,
      this.height,
      this.crossAxisAlignment,
      this.left,
      this.right,
      this.bottom,
      this.icon,
      this.small})
      : super(key: key);
  final String setName;
  final String imgName;
  final Widget favorite;
  final double width;
  final double height;
  final CrossAxisAlignment crossAxisAlignment;
  final double left;
  final double right;
  final double bottom;
  final bool small;
  final bool icon;
  @override
  Widget build(BuildContext context) {
    return !icon
        ? Stack(fit: StackFit.loose,
            // alignment: AlignmentDirectional.bottomStart,
            children: [
                ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Color.fromRGBO(3, 30, 38, 0.60)
                              ]).createShader(bounds);
                        },
                        blendMode: BlendMode.darken,
                        child: Container(
                            width: small ? 90 : 148,
                            height: small ? 116 : 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/img/' + imgName + '.jpg'),
                                fit: BoxFit.cover,
                              ),
                            )))),
                Positioned(
                  left: small ? 8 : 10,
                  right: small ? 8 : 10,
                  bottom: small ? 8 : 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          setName,
                          style: small
                              ? Theme.of(context).textTheme.overline.merge(
                                  TextStyle(
                                      fontWeight: FontWeight.w500,
                                      height: 1.0,
                                      color: primary_50,
                                      fontSize: 10.84))
                              : Theme.of(context).textTheme.headline4,
                        ),
                      ),
                    ],
                  ),
                )
              ])
        : Stack(fit: StackFit.loose,
            // alignment: AlignmentDirectional.bottomStart,
            children: [
                ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Color.fromRGBO(3, 30, 38, 0.50)
                              ]).createShader(bounds);
                        },
                        blendMode: BlendMode.darken,
                        child: Container(
                            width: 90,
                            height: 116,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(imgName),
                                fit: BoxFit.cover,
                              ),
                            )))),
                Positioned(
                    right: 10,
                    bottom: 10,
                    child: SvgPicture.asset(
                      'assets/icons/favorite_filled_true.svg',
                      color: expanded_red_450,
                    ))
              ]);
  }
}
