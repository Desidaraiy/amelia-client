import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/components/CompletedOrderItemWidget.dart';
import 'package:markets/src/controllers/order_controller.dart';
import 'package:markets/src/helpers/colors.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';

class CompletedOrdersWidget extends StatefulWidget {
  const CompletedOrdersWidget({Key key}) : super(key: key);

  @override
  _CompletedOrdersWidgetState createState() => _CompletedOrdersWidgetState();
}

class _CompletedOrdersWidgetState extends StateMVC<CompletedOrdersWidget> {
  OrderController _con;

  _CompletedOrdersWidgetState() : super(OrderController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary_50,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: SvgPicture.asset(
            'assets/icons/navigate_before_200.svg',
            color: primary_700,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).completed_orders,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _con.refreshOrders,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${_con.completedOrders.length} заказов",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(height: 8,),
                ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  primary: false,
                  itemCount: _con.completedOrders.length,
                  itemBuilder: (context, index) {
                    var _order = _con.orders.elementAt(index);
                    return  CompletedOrderItemWidget(
                        order: _order
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
        ),
      ),
    );
  }
}
