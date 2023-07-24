import 'package:flutter/material.dart';
import 'package:markets/src/helpers/colors.dart';
import '../../generated/l10n.dart';

class InTotalWidget extends StatelessWidget {
  const InTotalWidget({Key key, this.deliveryPrice, this.delivery, this.total})
      : super(key: key);
  final bool deliveryPrice;
  final int delivery;
  final double total;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Товары',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${total.toInt().toString()}",
                  style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(
                      fontWeight: FontWeight.w500, color: neutral_500)),
                ),
                SizedBox(
                  width: 1,
                ),
                Text(
                  '₽',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .merge(TextStyle(color: neutral_500)),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        // Row(
        //   children: [
        //     Expanded(
        //       child: Text(
        //         'Скидка',
        //         style: Theme.of(context).textTheme.subtitle1,
        //       ),
        //     ),
        //     Row(
        //       crossAxisAlignment: CrossAxisAlignment.end,
        //       children: [
        //         Text(
        //           "–550",
        //           style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(
        //               fontWeight: FontWeight.w500, color: expanded_red_450)),
        //         ),
        //         SizedBox(
        //           width: 1,
        //         ),
        //         Text(
        //           '₽',
        //           style: Theme.of(context)
        //               .textTheme
        //               .bodyText2
        //               .merge(TextStyle(color: expanded_red_450)),
        //         ),
        //       ],
        //     ),
        //   ],
        // ),
        deliveryPrice
            ? Column(
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Доставка',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          delivery == 0
                              ? Text(
                                  "Выберите район",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .merge(TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: expanded_green_400)),
                                )
                              : Text(
                                  delivery.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .merge(TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: neutral_500)),
                                ),
                          delivery > 0
                              ? Row(
                                  children: [
                                    SizedBox(
                                      width: 1,
                                    ),
                                    Text(
                                      '₽',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .merge(TextStyle(color: neutral_500)),
                                    ),
                                  ],
                                )
                              : SizedBox(),
                        ],
                      ),
                    ],
                  ),
                ],
              )
            : SizedBox()
      ],
    );
  }
}
