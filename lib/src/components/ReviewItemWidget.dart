import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/components/AddRemoveWidget.dart';
import 'package:markets/src/components/CounterWidget.dart';
import 'package:markets/src/helpers/colors.dart';
import '../../generated/l10n.dart';
import 'package:markets/src/models/order.dart';

class ReviewItemWidget extends StatelessWidget {
  const ReviewItemWidget({Key key, this.order}) : super(key: key);
  final Order order;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: primary_50,
      height: 104,
      child: Row(
        children: [
          CachedNetworkImage(
            height: 104,
            width: 104,
            fit: BoxFit.cover,
            imageUrl: order.productOrders.first.product.image.thumb,
            placeholder: (context, url) => Image.asset(
              'assets/img/loading.gif',
              fit: BoxFit.cover,
              height: 104,
              width: 104,
            ),
            errorWidget: (context, url, error) => Icon(Icons.error_outline),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.productOrders.first.product.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          order.productOrders.first.product.category.name ??
                              'Пусто',
                          style: Theme.of(context).textTheme.overline,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          order.productOrders.first.product.discountPrice ==
                                      0 &&
                                  order.productOrders.first.product.price != 0
                              ? Text(
                                  order.productOrders.first.product.price
                                      .toInt()
                                      .toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .merge(TextStyle(
                                          fontSize: 15.0, height: 1.0)),
                                )
                              : order.productOrders.first.product
                                              .discountPrice !=
                                          0 &&
                                      order.productOrders.first.product.price !=
                                          0
                                  ? Text(
                                      order.productOrders.first.product
                                          .discountPrice
                                          .toInt()
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .merge(TextStyle(
                                              fontSize: 15.0, height: 1.0)),
                                    )
                                  : SizedBox(),
                          SizedBox(
                            width: 1,
                          ),
                          Text(
                            '₽',
                            style: Theme.of(context).textTheme.overline.merge(
                                TextStyle(color: primary_700, height: 1.0)),
                          ),
                        ],
                      ),
                      order.productOrders.first.product.price != 0 &&
                              order.productOrders.first.product.discountPrice !=
                                  0
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  order.productOrders.first.product.price
                                      .toInt()
                                      .toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .overline
                                      .merge(TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontWeight: FontWeight.w300,
                                          height: 1.0)),
                                ),
                              ],
                            )
                          : SizedBox(),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
