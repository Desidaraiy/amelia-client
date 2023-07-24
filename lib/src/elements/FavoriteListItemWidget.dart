import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/components/AlertDialogWidget.dart';
import 'package:markets/src/components/PrimaryButtonWidget.dart';
import 'package:markets/src/helpers/colors.dart';

import '../helpers/helper.dart';
import '../models/favorite.dart';
import '../models/route_argument.dart';

// ignore: must_be_immutable
class FavoriteListItemWidget extends StatelessWidget {
  String heroTag;
  Favorite favorite;

  FavoriteListItemWidget({Key key, this.heroTag, this.favorite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed('/Product',
          arguments: new RouteArgument(
              heroTag: this.heroTag, id: this.favorite.product.id)),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              width: 116,
              height: 116,
              child: Stack(
                fit: StackFit.loose,
                alignment: AlignmentDirectional.topStart,
                children: [
                  Hero(
                    tag: heroTag + favorite.product.id,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(favorite.product.imageurl),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5))),
                      height: 116,
                      width: double.infinity,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // new_product == true
                      //     ? Flexible(
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(top: 6),
                      //       child: Container(
                      //         height: 20,
                      //         decoration: BoxDecoration(
                      //             color: expanded_green_dimmed_400,
                      //             borderRadius: BorderRadius.only(
                      //                 bottomRight: Radius.circular(3),
                      //                 topRight: Radius.circular(3))),
                      //         child: Padding(
                      //           padding: const EdgeInsets.fromLTRB(
                      //               6, 4, 6, 4),
                      //           child: Text(
                      //             'новинка',
                      //             style: Theme.of(context)
                      //                 .textTheme
                      //                 .caption,
                      //           ),
                      //         ),
                      //       ),
                      //     ))
                      //     : SizedBox(),
                      favorite.product.discountPrice != 0.0
                          ? Flexible(
                              child: Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Container(
                                height: 20,
                                decoration: BoxDecoration(
                                    color: expanded_red_550,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(3),
                                        bottomRight: Radius.circular(3))),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(6, 4, 6, 4),
                                  child: Text(
                                    "-${(favorite.product.discountPrice - favorite.product.price) * 100 ~/ favorite.product.discountPrice}"
                                            .toString() +
                                        "%",
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ),
                              ),
                            ))
                          : SizedBox(),
                    ],
                  )
                ],
              )),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: primary_50,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5))),
              padding: EdgeInsets.all(6),
              height: 116,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                favorite.product.name,
                                style: Theme.of(context).textTheme.headline3,
                              ),
                              SizedBox(
                                height: 4,
                              ),

                              ///Не отображается категория
                              Text(
                                favorite.product.catname ?? '',
                                style: Theme.of(context).textTheme.overline,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () => showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  AlertDialogWidget(
                                    title: "Удалить товар из избранного?",
                                    onYes: "Удалить",
                                  )),
                          child: SvgPicture.asset(
                            'assets/icons/close_24.svg',
                            color: neutral_150,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 4,
                  ),
                  Row(
                    // mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Helper.getPrice(
                                  favorite.product.price,
                                  context,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .merge(TextStyle(height: 1.1)),
                                ),
                                SizedBox(
                                  width: 1,
                                ),
                                // Text(
                                //   '₽',
                                //   style: Theme.of(context)
                                //       .textTheme
                                //       .overline
                                //       .merge(TextStyle(
                                //           color: primary_700,
                                //           height: 1.1)),
                                // ),
                              ],
                            ),
                            favorite.product.discountPrice != 0.0
                                ? Column(
                                    children: [
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Helper.getPrice(
                                        favorite.product.discountPrice,
                                        context,
                                        style: Theme.of(context)
                                            .textTheme
                                            .overline
                                            .merge(TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                fontWeight: FontWeight.w300,
                                                height: 1.1)),
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Container(
                          padding: EdgeInsets.all(6),
                          child: SvgPicture.asset(
                            'assets/icons/favorite_filled_true.svg',
                            color: expanded_red_450,
                          )),
                      PrimaryButton(
                        icon: SvgPicture.asset('assets/icons/cart_200.svg',
                            color: primary_50),
                        small: true,
                        onPressed: () {},
                        left_padding: 8,
                        right_padding: 8,
                        top_padding: 8,
                        bottom_padding: 8,
                        border_radius: 3,
                        buttonText: false,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    //   InkWell(
    //   splashColor: Theme.of(context).accentColor,
    //   focusColor: Theme.of(context).accentColor,
    //   highlightColor: Theme.of(context).primaryColor,
    //   onTap: () {
    //     Navigator.of(context).pushNamed('/Product', arguments: new RouteArgument(heroTag: this.heroTag, id: this.favorite.product.id));
    //   },
    //   child: Container(
    //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    //     decoration: BoxDecoration(
    //       color: Theme.of(context).primaryColor.withOpacity(0.9),
    //       boxShadow: [
    //         BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 5, offset: Offset(0, 2)),
    //       ],
    //     ),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       children: <Widget>[
    //         Hero(
    //           tag: heroTag + favorite.product.id,
    //           child: Container(
    //             height: 60,
    //             width: 60,
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.all(Radius.circular(5)),
    //               image: DecorationImage(image: NetworkImage(favorite.product.image.thumb), fit: BoxFit.cover),
    //             ),
    //           ),
    //         ),
    //         SizedBox(width: 15),
    //         Flexible(
    //           child: Row(
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: <Widget>[
    //               Expanded(
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: <Widget>[
    //                     Text(
    //                       favorite.product.name,
    //                       overflow: TextOverflow.ellipsis,
    //                       maxLines: 2,
    //                       style: Theme.of(context).textTheme.subtitle1,
    //                     ),
    //                     Text(
    //                       favorite.product.market.name,
    //                       overflow: TextOverflow.fade,
    //                       softWrap: false,
    //                       style: Theme.of(context).textTheme.caption,
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               SizedBox(width: 8),
    //               Helper.getPrice(favorite.product.price, context, style: Theme.of(context).textTheme.headline4),
    //             ],
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}
