import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../models/cart.dart';
import '../models/coupon.dart';
import '../models/credit_card.dart';
import '../models/order.dart';
import '../models/order_status.dart';
import '../models/payment.dart';
import '../models/product_order.dart';
import '../repository/order_repository.dart' as orderRepo;
import '../repository/settings_repository.dart' as settingRepo;
import '../repository/user_repository.dart' as userRepo;
import 'cart_controller.dart';
import 'package:intl/intl.dart';

class CheckoutController extends CartController {
  Payment payment;
  CreditCard creditCard = new CreditCard();
  bool loading = true;

  CheckoutController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForCreditCard();
  }

  void listenForCreditCard() async {
    creditCard = await userRepo.getCreditCard();
    setState(() {});
  }

  // @override
  // void onLoadingCartDone() {
  //   if (payment != null) addOrder(carts);
  //   super.onLoadingCartDone();
  // }

  Future<Order> addOrder(
      List<Cart> carts, Order _order, Payment _payment, String myName) async {
    Order order = new Order();
    _order.productOrders = <ProductOrder>[];
    _order.tax = carts[0].product.market.defaultTax;
    _order.deliveryFee = _payment.method == 'Оплата при самовывозе'
        ? 0
        : carts[0].product.market.deliveryFee;
    // OrderStatus _orderStatus = new OrderStatus();
    // _orderStatus.id = '1'; // TODO default order status Id
    // _order.orderStatus = _orderStatus;
    // _order.comment = "vova";
    // _order.delivery_timestamp = DateTime.parse(
    //     DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()));
    // print("DATE ${_order.delivery_timestamp}");
    // _order.receiver_name = "ksya";
    // _order.receiver_phone = "79856546545";
    // _order.sms_after_delivery = "random";
    // var dcf = settingRepo.deliveryAddress.value;
    // if (_payment.method != 'Оплата при самовывозе') {
    //   _order.deliveryAddress = settingRepo.deliveryAddress.value;
    //   print("_order.deliveryAddress  ${_order.deliveryAddress}");
    // }
    // _order.hint = ' ';
    carts.forEach((_cart) {
      ProductOrder _productOrder = new ProductOrder();
      _productOrder.quantity = _cart.quantity;
      _productOrder.price = _cart.product.price;
      _productOrder.product = _cart.product;
      _productOrder.options = _cart.options;
      _order.productOrders.add(_productOrder);
    });
    await orderRepo.addOrder(_order, _payment, myName).then((value) async {
      settingRepo.coupon = new Coupon.fromJSON({});
      return value;
    }).then((value) {
      if (value is Order) {
        order = value;
        setState(() {
          loading = false;
        });
      }
    });
    return order;
  }

  void updateCreditCard(CreditCard creditCard) {
    userRepo.setCreditCard(creditCard).then((value) {
      setState(() {});
      ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
        content: Text(S.of(state.context).payment_card_updated_successfully),
      ));
    });
  }
}
