import 'package:flutter/material.dart';
import 'package:markets/src/controllers/cart_controller.dart';
import 'package:markets/src/controllers/delivery_pickup_controller.dart';
import 'package:markets/src/helpers/colors.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';

class CheckoutButtonsWidget extends StatefulWidget {
  const CheckoutButtonsWidget(
      {Key key,
      this.next,
      this.onTapNext,
      this.onTapBack,
      this.back,
      this.cartController,
      this.isLoading,
      this.status})
      : super(key: key);
  final Function() onTapNext;
  final Function() onTapBack;
  final String next;
  final String back;
  final String status;
  final bool isLoading;
  final DeliveryPickupController cartController;
  @override
  _CheckoutButtonsWidgetState createState() => _CheckoutButtonsWidgetState();
}

class _CheckoutButtonsWidgetState extends StateMVC<CheckoutButtonsWidget> {
  DeliveryPickupController _con;
  int selectedIndex;

  @override
  void initState() {
    setState(() {
      _con = widget.cartController;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 98,
      width: MediaQuery.of(context).size.width,
      color: expanded_light_neutral_100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: primary_50,
              boxShadow: [
                BoxShadow(
                  color: expanded_light_neutral_100.withOpacity(0.60),
                  offset: Offset(0.0, -1.0), //(x,y)
                  blurRadius: 1.0,
                ),
              ],
            ),
            height: 38,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  S.of(context).total.toUpperCase() + ":",
                  style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(
                        height: 1.2,
                      )),
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  // "${_con.total.toInt().toString()}",
                  // _con.deliveryPrice.isEmpty
                  _con.deliveryOrPickup == 1
                      ? "${_con.total.toInt().toString()}"
                      : "${_con.total + int.parse(_con.deliveryPrice == "" ? "0" : _con.deliveryPrice)}",
                  style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(
                      height: 1.2,
                      fontWeight: FontWeight.w500,
                      color: neutral_500)),
                ),
                SizedBox(
                  width: 1,
                ),
                Text(
                  '₽',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .merge(TextStyle(color: neutral_500)),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                widget.status == S.of(context).order_is_canceled ||
                        widget.status == S.of(context).delivered ||
                        widget.status == S.of(context).received
                    ? SizedBox()
                    : Expanded(
                        child: InkWell(
                          onTap: widget.onTapBack,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.status.isEmpty
                                      ? S.of(context).back
                                      : widget.back,
                                  style: Theme.of(context)
                                      .textTheme
                                      .button
                                      .merge(TextStyle(
                                          color: widget.status.isEmpty
                                              ? neutral_500
                                              : expanded_red_450,
                                          height: 1.2)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                Expanded(
                  child: InkWell(
                    onTap: widget.onTapNext,
                    child: Container(
                      color: secondary_300,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                        child: !widget.isLoading
                            ? Text(widget.next,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .button
                                    .merge(TextStyle(height: 1.2)))
                            : Center(
                                child: Container(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                    color: Colors.white),
                              )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
