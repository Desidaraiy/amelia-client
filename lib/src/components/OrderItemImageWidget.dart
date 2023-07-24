import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:markets/src/helpers/colors.dart';

class OrderItemImageWidget extends StatefulWidget {
  const OrderItemImageWidget(
      {Key key,
      this.imgName,
      this.created,
      this.topLeft,
      this.topRight,
      this.bottomRight,
      this.bottomLeft,
      this.quantity,
      this.imgBottomLeft,
      this.imgTopLeft,
      this.imgBottomRight,
      this.imgTopRight,
      this.imgUrl})
      : super(key: key);
  final String imgName;
  final String imgUrl;
  final bool created;
  final int quantity;
  final double topLeft,
      topRight,
      bottomRight,
      bottomLeft,
      imgBottomLeft,
      imgTopLeft,
      imgBottomRight,
      imgTopRight;

  @override
  State<OrderItemImageWidget> createState() => _OrderItemImageWidgetState();
}

class _OrderItemImageWidgetState extends State<OrderItemImageWidget> {
  String _url;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    setState(() {
      _url = widget.imgUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.loose,
        // alignment: AlignmentDirectional.bottomStart,
        children: [
          ClipRRect(
            borderRadius: widget.created
                ? BorderRadius.only(
                    topLeft: Radius.circular(widget.topLeft),
                    topRight: Radius.circular(widget.topRight),
                    bottomRight: Radius.circular(widget.bottomRight),
                    bottomLeft: Radius.circular(widget.bottomLeft))
                : BorderRadius.all(Radius.circular(5.0)),
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Color.fromRGBO(15, 19, 20, 0.85)
                    ]).createShader(bounds);
              },
              blendMode: BlendMode.darken,
              child: Container(
                width: 90,
                height: 116,
                decoration: BoxDecoration(
                  borderRadius: widget.created
                      ? BorderRadius.only(
                          topLeft: Radius.circular(widget.topLeft),
                          topRight: Radius.circular(widget.topRight),
                          bottomRight: Radius.circular(widget.bottomRight),
                          bottomLeft: Radius.circular(widget.bottomLeft))
                      : BorderRadius.all(Radius.circular(5.0)),
                  // image: widget.imgName != "fs"
                  //     ? DecorationImage(
                  //         image: AssetImage(
                  //             'assets/img/' + widget.imgName + '.jpg'),
                  //         fit: BoxFit.cover,
                  //       )
                  //     : CachedNetworkImage(
                  //         imageUrl: widget.imgUrl,
                  //         fit: BoxFit.cover,
                  //       ),
                  image: DecorationImage(
                      image: NetworkImage(_url),
                      // : AssetImage('assets/img/' + widget.imgName + '.jpg'),
                      fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                  color: expanded_light_neutral_100,
                  borderRadius: widget.created
                      ? BorderRadius.only(
                          topRight: Radius.circular(widget.imgTopRight),
                          bottomRight: Radius.circular(widget.imgBottomRight),
                          bottomLeft: Radius.circular(widget.imgBottomLeft),
                          topLeft: Radius.circular(widget.imgTopLeft))
                      : BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5))),
              child: Container(
                alignment: Alignment.center,
                width: 30,
                child: Text(
                  "x" + widget.quantity.toString(),
                  style: Theme.of(context).textTheme.caption.merge(TextStyle(
                        height: 1.1,
                        color: neutral_500,
                      )),
                ),
              ),
            ),
          )
        ]);
  }
}
