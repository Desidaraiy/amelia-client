import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:markets/src/helpers/colors.dart';
import '../../generated/l10n.dart';
import '../controllers/delivery_pickup_controller.dart';
import 'UserOrderWidget.dart';

class OrderPaymentWidget extends StatefulWidget {
  const OrderPaymentWidget({Key key, this.userOrder, this.controller})
      : super(key: key);
  final bool userOrder;
  final DeliveryPickupController controller;
  @override
  _OrderPaymentWidgetState createState() => _OrderPaymentWidgetState();
}

class _OrderPaymentWidgetState extends State<OrderPaymentWidget> {
  List<String> paymentImg = [
    "assets/icons/credit_card.svg",
    "assets/icons/ruble.svg"
  ];
  List<String> paymentModes;

  int selectedIndex = 0;
  DeliveryPickupController _con;

  void _handlePaymentMethod() {
    String method;
    switch (selectedIndex) {
      case 0:
        method = 'Картой онлайн';
        break;
      case 1:
        method = 'При получении';
        break;
    }

    _con.handleFourthStep(method);
  }

  void _initWidget(context) {
    if (_con.deliveryOrPickup == 0) {
      paymentModes = [
        S.of(context).pay_online,
      ];
      paymentImg = [
        "assets/icons/credit_card.svg",
      ];
    } else {
      paymentModes = [S.of(context).pay_online, S.of(context).pay_by_cash];
    }
    if (_con.paymentMethod.isNotEmpty) {
      if (_con.paymentMethod == 'Картой онлайн') {
        selectedIndex = 0;
      } else {
        selectedIndex = 1;
      }
    }
    _handlePaymentMethod();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _con = widget.controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    // List<String> paymentModes = [
    //   S.of(context).pay_online,
    //   S.of(context).pay_by_cash
    // ];
    _initWidget(context);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).payment_mode,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 64,
              child: ListView.builder(
                itemCount: paymentModes.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, int index) {
                  return Row(
                    children: [
                      index == 0
                          ? SizedBox(
                              width: 16,
                            )
                          : SizedBox(),
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                            _handlePaymentMethod();
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 64,
                          decoration: BoxDecoration(
                              border: selectedIndex == index
                                  ? Border.all(color: secondary_300)
                                  : Border.all(style: BorderStyle.none),
                              color: selectedIndex == index
                                  ? secondary_100
                                  : primary_50,
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 12, right: 12, top: 4, bottom: 8),
                            child: Column(
                              children: [
                                SvgPicture.asset(paymentImg[index]),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(paymentModes[index],
                                    style: Theme.of(context)
                                        .textTheme
                                        .overline
                                        .merge(TextStyle(
                                            // height: 1.2,
                                            color: neutral_350,
                                            fontWeight: FontWeight.w500))),
                              ],
                            ),
                          ),
                        ),
                      ),
                      index != paymentModes.length - 1
                          ? SizedBox(
                              width: 8,
                            )
                          : SizedBox(),
                      index == paymentModes.length - 1
                          ? SizedBox(
                              width: 16,
                            )
                          : SizedBox(),
                    ],
                  );
                },
              ),
            ),
            widget.userOrder
                ? Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            Divider(
                              color: expanded_light_neutral_100,
                              height: 1.5,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : SizedBox(),
            // widget.userOrder
            //     ? UserOrderWidget(
            //   price: true,
            // )
            //     : SizedBox(),
          ],
        ),
      ),
    );
  }
}
