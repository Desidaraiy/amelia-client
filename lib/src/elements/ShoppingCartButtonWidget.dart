import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/helpers/colors.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../controllers/cart_controller.dart';
import '../models/route_argument.dart';
import '../repository/user_repository.dart';

class ShoppingCartButtonWidget extends StatefulWidget {
  const ShoppingCartButtonWidget({
    this.iconColor,
    this.labelColor,
    Key key,
  }) : super(key: key);

  final Color iconColor;
  final Color labelColor;

  @override
  _ShoppingCartButtonWidgetState createState() =>
      _ShoppingCartButtonWidgetState();
}

class _ShoppingCartButtonWidgetState
    extends StateMVC<ShoppingCartButtonWidget> {
  CartController _con;

  _ShoppingCartButtonWidgetState() : super(CartController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForCartsCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (currentUser.value.apiToken != null) {
          Navigator.of(context).pushNamed('/Cart',
              arguments: RouteArgument(param: '/Pages', id: '2'));
        } else {
          Navigator.of(context).pushNamed('/Login');
        }
      },
      color: Colors.transparent, icon: Stack(
      alignment: AlignmentDirectional.topEnd,
      children: <Widget>[
        SvgPicture.asset('assets/icons/cart_200.svg'),
        _con.cartCount!=0 ? Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
              color: expanded_red_450,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          width: 14,height: 14,
          child:      Text(
            _con.cartCount >= 5
                ? "5+"
                : _con.cartCount.toString(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.caption.merge(
              TextStyle(color: primary_50, fontSize: 10, height: 1.2),
            ),
          ),
        ):SizedBox(),

      ],
    ),
    );
  }
}
