import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:markets/src/helpers/colors.dart';
import 'package:markets/src/models/product_order.dart';
import 'package:markets/src/models/order.dart';
import 'package:markets/src/models/route_argument.dart';
import '../../generated/l10n.dart';
import 'package:intl/intl.dart';

import 'PrimaryButtonWidget.dart';

class CompletedOrderItemWidget extends StatelessWidget {
  const CompletedOrderItemWidget({
    Key key,
    // this.productOrder,
    this.onTap, this.order,
  }) : super(key: key);
  // final ProductOrder productOrder;
  final Order order;
  final Function() onTap;
  // final ProductOrder productOrder;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: order.productOrders.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0), color: primary_50),
          child: Column(
            children: [
              InkWell(

                onTap: onTap,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      child: CachedNetworkImage(
                        height: 124,
                        width: 100,
                        fit: BoxFit.cover,
                        imageUrl: order.productOrders[index].product.image.thumb,
                        placeholder: (context, url) => Image.asset(
                          'assets/img/loading.gif',
                          fit: BoxFit.cover,
                          height: 124,
                          width: 100,
                        ),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error_outline),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order.productOrders[index].product.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headline2.merge(
                              TextStyle(fontSize: 18.22, height: 1.0),
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Row(
                            children: [
                              Text(
                                "${S.of(context).order}",
                                style: Theme.of(context).textTheme.bodyText2.merge(
                                  TextStyle(height: 1.1),
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                "#${order.id}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyText2.merge(
                                  TextStyle(
                                      height: 1.1, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Divider(
                              color: expanded_light_neutral_100,
                              height: 1,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                S.of(context).delivered,
                                style: Theme.of(context).textTheme.bodyText2.merge(
                                  TextStyle(
                                      height: 1.1, fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                "${DateFormat('dd.MM.yyyy').format(DateTime.now())}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyText2.merge(
                                  TextStyle(
                                    height: 1.1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              Text(
                                "В",
                                style: Theme.of(context).textTheme.bodyText2.merge(
                                  TextStyle(
                                      height: 1.1, fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                "${DateFormat('HH:mm').format(DateTime.now())}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyText2.merge(
                                  TextStyle(
                                    height: 1.1,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              PrimaryButton(
                icon: null,
                small: false,
                text: "Написать отзыв",
                onPressed: () {
                  Navigator.of(context).pushNamed('/WriteReview', arguments: RouteArgument(id: order.id, heroTag: "market_reviews"));
                },
                min_width: 176,
                min_height: 44,
                left_padding: 0,
                right_padding: 0,
                top_padding: 14,
                bottom_padding: 14,
                border_radius: 5,
                buttonText: true,
              ),
            ],
          ),
        );
      },

    );
  }
}
