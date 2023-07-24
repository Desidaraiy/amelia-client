import 'package:flutter/material.dart';
import 'package:markets/src/helpers/colors.dart';
import '../../generated/l10n.dart';

class ShippingMethodWidget extends StatefulWidget {
  ShippingMethodWidget(
      {Key key, this.onTapDelivery, this.onTapPickUp, this.selectedIndex})
      : super(key: key);
  final Function() onTapDelivery;
  final Function() onTapPickUp;
  int selectedIndex;
  @override
  State<ShippingMethodWidget> createState() => _ShippingMethodWidgetState();
}

class _ShippingMethodWidgetState extends State<ShippingMethodWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap:  widget.onTapDelivery,
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.40,
              decoration: BoxDecoration(
                color: widget.selectedIndex == 0 ? secondary_100 : primary_50,
                border: widget.selectedIndex == 0
                    ? Border.all(
                        color: secondary_300,
                        width: 1.0,
                        style: BorderStyle.solid)
                    : Border.all(
                        color: primary_50,
                        width: 1.0,
                        style: BorderStyle.solid),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(0),
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(0),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Text(
                S.of(context).delivery_man,
                style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(
                    color: widget.selectedIndex == 0
                        ? secondary_300
                        : neutral_250)),
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: widget.onTapPickUp,
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.40,
              decoration: BoxDecoration(
                color: widget.selectedIndex == 1 ? secondary_100 : primary_50,
                border: widget.selectedIndex == 1
                    ? Border.all(
                        color: secondary_300,
                        width: 1.0,
                        style: BorderStyle.solid)
                    : Border.all(
                        color: primary_50,
                        width: 1.0,
                        style: BorderStyle.solid),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  topLeft: Radius.circular(0),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(5),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Text(
                S.of(context).pickup,
                style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(
                    color: widget.selectedIndex == 1
                        ? secondary_300
                        : neutral_250)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
