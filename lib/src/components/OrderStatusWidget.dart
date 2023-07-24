import 'package:flutter/material.dart';
import 'package:markets/src/helpers/colors.dart';
import '../../generated/l10n.dart';

class OrderStatusWidget extends StatelessWidget {
  const OrderStatusWidget({Key key, this.status}) : super(key: key);
  final String status;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22,
      padding: EdgeInsets.fromLTRB(8, 3, 8, 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
          color: status == S.of(context).received ||
                  status == S.of(context).delivered ||
                  status == S.of(context).paid_offline ||
                  status == S.of(context).paid_online
              ? expanded_green_50
              : status == S.of(context).order_is_packing
                  ? accent_100
                  : status == S.of(context).wait_for_delivery_man ||
                          status == S.of(context).ready_for_pickup
                      ? secondary_100
                      : expanded_light_neutral_50),
      child: Text(status,
        style: Theme.of(context).textTheme.caption.merge(TextStyle(height: 1.2,color:status == S.of(context).received ||
            status == S.of(context).delivered ||
            status == S.of(context).paid_offline ||
            status == S.of(context).paid_online
            ? expanded_green_dimmed_400
            : status == S.of(context).order_is_packing
            ? accent_200
            : status == S.of(context).wait_for_delivery_man ||
            status == S.of(context).ready_for_pickup
            ? secondary_300
            : neutral_500 )),),
    );
  }
}
