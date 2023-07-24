import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/components/AlertDialogWidget.dart';
import 'package:markets/src/components/PrimaryButtonWidget.dart';
import 'package:markets/src/components/SecondaryButtonWidget.dart';
import 'package:markets/src/components/UserOrderWidget.dart';
import 'package:markets/src/helpers/colors.dart';
import 'package:markets/src/helpers/helper.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';
import '../controllers/delivery_pickup_controller.dart';
import '../models/route_argument.dart';

class PlacedOrderWidget extends StatefulWidget {
  final RouteArgument routeArgument;
  const PlacedOrderWidget({this.routeArgument});

  @override
  _PlacedOrderWidgetState createState() => _PlacedOrderWidgetState();
}

class _PlacedOrderWidgetState extends StateMVC<PlacedOrderWidget> {
  DeliveryPickupController _con;

  @override
  void initState() {
    super.initState();
    setState(() {
      _con = widget.routeArgument.param as DeliveryPickupController;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper.of(context).onWillPop,
      child: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          backgroundColor: primary_50,
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          title: Text(
            S.of(context).placed_order,
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/img/placed_order.png',
                  fit: BoxFit.scaleDown,
                  width: 142,
                  height: 142,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  S.of(context).order_is_placed,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .merge(TextStyle(fontSize: 22.13)),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).order_number,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .merge(TextStyle(color: neutral_500)),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      "${_con.order.id.toString()}",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1.merge(
                          TextStyle(
                              color: neutral_500, fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: 16,
                // ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 45.0),
                  child: SizedBox(
                    width: 126,
                    child: PrimaryButton(
                      icon: null,
                      small: false,
                      text: "К заказам",
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed('/Pages', arguments: 0);
                      },
                      min_width: 130,
                      min_height: 48,
                      left_padding: 23,
                      right_padding: 23,
                      top_padding: 14,
                      bottom_padding: 14,
                      border_radius: 5,
                      buttonText: true,
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 16,
                // ),
                InkWell(
                  onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialogWidget(
                            title: "Отменить заказ?",
                            onYes: "Отменить",
                          )),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 13,
                    ),
                    child: Text(
                      "Отменить заказ",
                      style:
                          Theme.of(context).textTheme.subtitle1.merge(TextStyle(
                                color: semantic_error,
                              )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                // UserOrderWidget(
                //   price: false,
                //   // total:
                // ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 130,
                      child: SecondaryButton(
                        onPressed: () => Navigator.of(context)
                            .pushReplacementNamed('/Pages', arguments: 0),
                        small: false,
                        text: "На главную",
                        btn_icon: SvgPicture.asset(
                          'assets/icons/navigate_before_200.svg',
                          color: primary_700,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
