import 'dart:ui';

import 'package:flutter/material.dart';

class LoadingItem extends StatelessWidget {
  const LoadingItem({Key key, this.width, this.height}) : super(key: key);
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5)),
      child: Image.asset(
        'assets/img/loading.gif',
        fit: BoxFit.cover,
        width: width,
        height: height,
      ),
    );
  }
}
