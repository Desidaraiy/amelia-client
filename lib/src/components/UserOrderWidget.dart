import 'package:flutter/material.dart';
import 'package:markets/src/controllers/delivery_pickup_controller.dart';
import 'package:markets/src/helpers/colors.dart';
import 'package:markets/src/models/cart.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';
import 'OrderItemImageWidget.dart';
import 'InTotalWidget.dart';

class UserOrderWidget extends StatefulWidget {
  UserOrderWidget({Key key, this.price, this.controller}) : super(key: key);
  bool price = true;

  DeliveryPickupController controller;
  @override
  _UserOrderWidgetState createState() => _UserOrderWidgetState();
}

class _UserOrderWidgetState extends StateMVC<UserOrderWidget> {
  DeliveryPickupController _con;

  @override
  void initState() {
    super.initState();
    setState(() {
      _con = widget.controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            S.of(context).your_order,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          height: 116,
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: _con.carts.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(right: 8.0),
                child: OrderItemImageWidget(
                    // imgName: "fs",
                    imgUrl: _con.carts[index].product.image.url,
                    quantity: _con.carts[index].quantity.toInt(),
                    created: false),
              );
            },
          ),
        ),
        widget.price
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Divider(
                      color: expanded_light_neutral_100,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: InTotalWidget(
                        deliveryPrice: _con.deliveryOrPickup == 0,
                        delivery: _con.deliveryPrice.isNotEmpty
                            ? int.parse(_con.deliveryPrice)
                            : 0,
                        total: _con.total),
                  )
                ],
              )
            : SizedBox(),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
