import 'dart:async';

import 'package:flutter/material.dart';
import 'package:markets/src/helpers/colors.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/cart_controller.dart';
import '../helpers/helper.dart';

class CartBottomDetailsWidget extends StatefulWidget {
  const CartBottomDetailsWidget(
      {Key key, this.cartController, this.deliveryOption})
      : super(key: key);
  final CartController cartController;
  final int deliveryOption;
  @override
  _CartBottomDetailsWidgetState createState() =>
      _CartBottomDetailsWidgetState();
}

class _CartBottomDetailsWidgetState extends StateMVC<CartBottomDetailsWidget> {
  CartController _con;

  // _CartBottomDetailsWidgetState() : super(CartController()) {
  //   _con = controller;
  // }

  Stream<double> _stream;

  @override
  void initState() {
    super.initState();
    _con = widget.cartController;
    _stream = _con.totalStream;
  }

  @override
  Widget build(BuildContext context) {
    return
        // _con.carts.isEmpty
        //   ? SizedBox(height: 0)
        //   :
        Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      color: expanded_light_neutral_100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    // color: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 0),
                      child: Row(
                        children: [
                          Text(
                            '${S.of(context).total}:',
                            style: Theme.of(context).textTheme.subtitle1.merge(
                                TextStyle(
                                    fontWeight: FontWeight.w500, height: 1.2)),
                          ),
                          SizedBox(width: 8),
                          Row(
                            children: [
                              StreamBuilder(
                                  stream: _stream,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<double> snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data == 0.9) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else {
                                        return Text(
                                          "${snapshot.data.toInt()}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1
                                              .merge(
                                                TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: neutral_500,
                                                  height: 1.2,
                                                ),
                                              ),
                                        );
                                      }
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  }),

                              // Text(
                              //   "200",
                              //   style:
                              //       Theme.of(context).textTheme.subtitle1.merge(
                              //             TextStyle(
                              //               fontWeight: FontWeight.w500,
                              //               color: neutral_500,
                              //               height: 1.2,
                              //             ),
                              //           ),
                              // ),
                              SizedBox(width: 1),
                              Text(
                                "₽",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .merge(TextStyle(
                                        color: neutral_500, height: 1.2)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Helper.getPrice(_con.subTotal, context, style: Theme.of(context).textTheme.subtitle1, zeroPlaceholder: '0')
                Expanded(
                  child: GestureDetector(
                    onTap: () =>
                        _con.goCheckout(context, widget.deliveryOption),
                    child: Container(
                      color: secondary_300,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                        child: Text(S.of(context).checkout,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .button
                                .merge(TextStyle(height: 1.2))),
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
