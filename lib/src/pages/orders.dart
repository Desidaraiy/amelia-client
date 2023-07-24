import 'package:flutter/material.dart';
import 'package:markets/src/helpers/colors.dart';
import 'package:markets/src/models/route_argument.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'package:markets/src/components/CurrentOrderItemWidget.dart';
import 'package:markets/src/components/CompletedOrderItemWidget.dart';

import '../../generated/l10n.dart';
import '../controllers/order_controller.dart';
import '../elements/EmptyOrdersWidget.dart';
import '../elements/OrderItemWidget.dart';
import '../elements/PermissionDeniedWidget.dart';
import '../elements/SearchBarWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../repository/user_repository.dart';

class OrdersWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  OrdersWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _OrdersWidgetState createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends StateMVC<OrdersWidget> {
  OrderController _con;

  _OrdersWidgetState() : super(OrderController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      appBar: AppBar(
        backgroundColor: primary_50,
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).my_orders,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: _con.orders.isEmpty
          ? EmptyOrdersWidget()
          : RefreshIndicator(
              onRefresh: _con.refreshOrders,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).current_orders,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            S.of(context).wait_for_delivery,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),

                    ///Доставка
                    SizedBox(
                      height: 148,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        primary: false,
                        itemCount: _con.activeOrders.length,
                        itemBuilder: (context, index) {
                          var _order = _con.activeOrders.elementAt(index);
                          return Row(
                            children: [
                              index == 0
                                  ? SizedBox(
                                      width: 16,
                                    )
                                  : SizedBox(),
                              _order.active
                                  ? CurrentOrderItemWidget(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                            '/Tracking',
                                            arguments:
                                                RouteArgument(id: _order.id));
                                      },
                                      pickUpTime: _order.delivery_timestamp,
                                      date: _order.dateTime,
                                      // pickupAddress:
                                      //     "ул. Большая Санкт-Петербургская, 138, кв./офис 200",
                                      pickupAddress:
                                          "${_order.delivery_address.address.toString()}",
                                      deliveryAddress: "",
                                      status: _order.orderStatus.status,
                                      ready: _order.orderStatus.status ==
                                                  S
                                                      .of(context)
                                                      .ready_for_pickup ||
                                              _order.orderStatus.status ==
                                                  S
                                                      .of(context)
                                                      .wait_for_delivery_man
                                          ? true
                                          : false,
                                      delivery: true,
                                      orderId: _order.id,
                                      // expanded: index == 0 ? true : false,
                                      // order: _order,
                                      // onCanceled: (e) {
                                      //   _con.doCancelOrder(_order);
                                      // },
                                    )
                                  : SizedBox(),
                              index == _con.activeOrders.length - 1
                                  ? SizedBox(
                                      width: 16,
                                    )
                                  : SizedBox(),
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(width: 8);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            S.of(context).wait_for_pickup,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),

                    ///Самовывоз
                    SizedBox(
                      height: 128,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        primary: false,
                        itemCount: _con.activeOrders.length,
                        itemBuilder: (context, index) {
                          var _order = _con.activeOrders.elementAt(index);
                          return Row(
                            children: [
                              index == 0
                                  ? SizedBox(
                                      width: 16,
                                    )
                                  : SizedBox(),
                              _order.active
                                  ? CurrentOrderItemWidget(
                                      onTap: () => Navigator.of(context)
                                          .pushNamed('/Tracking',
                                              arguments:
                                                  RouteArgument(id: _order.id)),
                                      pickUpTime: _order.delivery_timestamp,
                                      date: _order.dateTime,
                                      // pickupAddress: "ул. Людогоща, 8",
                                      pickupAddress:
                                          _order.delivery_address.address,
                                      deliveryAddress: "",
                                      status: _order.orderStatus.status,
                                      ready: _order.orderStatus.status ==
                                                  S
                                                      .of(context)
                                                      .ready_for_pickup ||
                                              _order.orderStatus.status ==
                                                  S
                                                      .of(context)
                                                      .wait_for_delivery_man
                                          ? true
                                          : false,
                                      delivery: false,
                                      orderId: _order.id,
                                      // expanded: index == 0 ? true : false,
                                      // order: _order,
                                      // onCanceled: (e) {
                                      //   _con.doCancelOrder(_order);
                                      // },
                                    )
                                  : SizedBox(),
                              index == _con.activeOrders.length - 1
                                  ? SizedBox(
                                      width: 16,
                                    )
                                  : SizedBox(),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(width: 8);
                        },
                      ),
                    ),

                    ///Выполненные заказы
                    _con.completedOrders.length != 0
                        // && _con.completedOrders.length >4
                        ? Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            S.of(context).completed_orders,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1,
                                          ),
                                        ),
                                        _con.completedOrders.length > 4
                                            ? GestureDetector(
                                                onTap: () =>
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                            '/CompletedOrders'),
                                                child: Text(
                                                  S.of(context).show_all,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption
                                                      .merge(TextStyle(
                                                          color: neutral_500)),
                                                ),
                                              )
                                            : SizedBox(),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    ListView.separated(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      primary: false,
                                      itemCount: _con.orders.length > 4
                                          ? 5
                                          : _con.orders.length,
                                      itemBuilder: (context, index) {
                                        var _order =
                                            _con.orders.elementAt(index);
                                        return CompletedOrderItemWidget(
                                          onTap: () => Navigator.of(context)
                                              .pushNamed('/Tracking',
                                                  arguments: RouteArgument(
                                                      id: _order.id)),
                                          order: _order,
                                          //productOrder: _productOrder,
                                          // date: _order.dateTime,
                                          // time: _order.delivery_timestamp,
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return SizedBox(height: 8);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : SizedBox()
                  ],
                ),
              ),
            ),
    );
  }
}
