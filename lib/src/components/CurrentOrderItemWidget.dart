import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/helpers/colors.dart';
import '../../generated/l10n.dart';
import 'package:intl/intl.dart';

class CurrentOrderItemWidget extends StatelessWidget {
  const CurrentOrderItemWidget(
      {Key key,
      this.ready,
      this.delivery,
      this.orderId,
      this.status,
      this.pickupAddress,
      this.deliveryAddress,
      this.date,
      this.pickUpTime,
      this.deliveryTimeStart,
      this.deliveryTimeEnd,
      this.onTap})
      : super(key: key);
  final bool ready;
  final bool delivery;
  final String orderId;
  final String status;
  final String pickupAddress;
  final String deliveryAddress;
  final DateTime date;
  final DateTime pickUpTime;
  final DateTime deliveryTimeStart;
  final DateTime deliveryTimeEnd;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(12, 8, 12, 12),
        width: 316,
        height: delivery ? 148 : 128,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0),
            color: ready ? expanded_green_50 : accent_50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        S.of(context).order,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .merge(TextStyle(height: 1.1)),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        "#${orderId}",
                        style: Theme.of(context).textTheme.bodyText2.merge(
                            TextStyle(
                                height: 1.1, fontWeight: FontWeight.w500)),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      ready
                          ? Row(
                              children: [
                                Text(
                                  "// ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .merge(TextStyle(height: 1.1)),
                                ),
                                Text(
                                  status,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .merge(TextStyle(height: 1.2)),
                                )
                              ],
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
                SvgPicture.asset(
                  'assets/icons/navigate_next_200.svg',
                  height: 24,
                  width: 24,
                  fit: BoxFit.scaleDown,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Divider(
                color: ready ? expanded_green_100 : secondary_100,
                height: 1.5,
              ),
            ),
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    delivery
                        ? Text(
                            "Куда?",
                            style: Theme.of(context).textTheme.bodyText2.merge(
                                TextStyle(
                                    height: 1.1, fontWeight: FontWeight.w500)),
                          )
                        : Text(
                            "Где?",
                            style: Theme.of(context).textTheme.bodyText2.merge(
                                TextStyle(
                                    height: 1.1, fontWeight: FontWeight.w500)),
                          ),
                    SizedBox(
                      width: 4,
                    ),
                    deliveryAddress.isNotEmpty
                        ? Expanded(
                            child: Text(
                              deliveryAddress,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .merge(TextStyle(
                                    height: 1.1,
                                  )),
                            ),
                          )
                        : Expanded(
                            child: Text(
                              pickupAddress,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .merge(TextStyle(
                                    height: 1.1,
                                  )),
                            ),
                          )
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Text(
                      "Когда?",
                      style: Theme.of(context).textTheme.bodyText2.merge(
                          TextStyle(height: 1.1, fontWeight: FontWeight.w500)),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      DateFormat('d MMMM, EEEE, ' 'yyyy', 'ru_RU').format(date),
                      style:
                          Theme.of(context).textTheme.bodyText2.merge(TextStyle(
                                height: 1.1,
                              )),
                    )
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Text(
                      "Во сколько?",
                      style: Theme.of(context).textTheme.bodyText2.merge(
                          TextStyle(height: 1.1, fontWeight: FontWeight.w500)),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    pickUpTime != null
                        ? Text(
                            "${DateFormat("HH:mm").format(pickUpTime)}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .merge(TextStyle(
                                  height: 1.1,
                                )),
                          )
                        : Text(
                            "${deliveryTimeStart}–${deliveryTimeEnd}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .merge(TextStyle(
                                  height: 1.1,
                                )),
                          ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
