import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/components/PrimaryButtonWidget.dart';
import 'package:markets/src/controllers/cart_controller.dart';
import 'package:markets/src/helpers/colors.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../helpers/app_config.dart' as config;
import '../models/cart.dart';

class EmptyCartWidget extends StatefulWidget {
  EmptyCartWidget({this.controller});
  final CartController controller;

  @override
  _EmptyCartWidgetState createState() => _EmptyCartWidgetState();
}

class _EmptyCartWidgetState extends StateMVC<EmptyCartWidget> {
  bool loading = true;
  CartController _con;

  @override
  void initState() {
    setState(() {
      _con = widget.controller;
    });

    Timer(Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        loading
            ? SizedBox(
                height: 3,
                child: LinearProgressIndicator(
                  backgroundColor:
                      Theme.of(context).accentColor.withOpacity(0.2),
                ),
              )
            : SizedBox(),
        Container(
          alignment: AlignmentDirectional.center,
          padding: EdgeInsets.symmetric(horizontal: 16),
          height: config.App(context).appHeight(70),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                'assets/img/empty_cart.png',

                // fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              // Text(
              //   (!_con.cartsLoading && _con.carts.isEmpty)
              //       ? S.of(context).dont_have_any_item_in_your_cart
              //       : 'Корзина обновляется...',
              //   textAlign: TextAlign.center,
              //   style: Theme.of(context).textTheme.subtitle1,
              // ),
              _con.cartsLoading
                  ? Text('Корзина обновляется...',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1)
                  : Text(S.of(context).dont_have_any_item_in_your_cart,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1),

              SizedBox(height: 6),
              Text(
                S.of(context).here_will_be_your_items,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4.merge(
                    TextStyle(color: neutral_200, fontWeight: FontWeight.w400)),
              ),
              SizedBox(height: 24),
              // !loading,
              SizedBox(
                width: 124,
                child: PrimaryButton(
                  min_width: 80,
                  min_height: 48,
                  buttonText: true,
                  onPressed: () {
                    Navigator.of(context).pushNamed('/Pages', arguments: 0);
                  },
                  icon: SvgPicture.asset(
                    'assets/icons/navigate_before_300.svg',
                    color: primary_50,
                    width: 24,
                    height: 24,
                    fit: BoxFit.scaleDown,
                  ),
                  text: 'На главную',
                  small: true,
                  left_padding: 14,
                  right_padding: 14,
                  top_padding: 10,
                  bottom_padding: 10,
                  border_radius: 10,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
