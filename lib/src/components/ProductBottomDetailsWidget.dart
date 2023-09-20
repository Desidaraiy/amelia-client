import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/components/PrimaryButtonWidget.dart';
import 'package:markets/src/helpers/colors.dart';

import '../models/Product.dart';

class ProductBottomDetailsWidget extends StatefulWidget {
  const ProductBottomDetailsWidget(
      {Key key,
      this.handleFavorites,
      this.product,
      this.price = 0.0,
      this.handleCart,
      this.isFavorite})
      : super(key: key);
  final void Function(Product, bool) handleFavorites;
  final void Function(Product) handleCart;
  final Future<bool> isFavorite;
  final Product product;
  final double price;
  @override
  State<ProductBottomDetailsWidget> createState() =>
      _ProductBottomDetailsWidgetState();
}

class _ProductBottomDetailsWidgetState
    extends State<ProductBottomDetailsWidget> {
  bool _localFavBool;
  bool tapped = false;

  void initFavs() async {
    _localFavBool = await widget.isFavorite;
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    initFavs();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
          color: primary_50,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      padding: EdgeInsets.only(left: 16),
      child: Row(
        // mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      (widget.price == null || widget.price == 0.0)
                          ? '${widget.product.price.toInt()}'
                          : '${widget.price.toInt()}',
                      style: Theme.of(context).textTheme.subtitle1.merge(
                          TextStyle(height: 1.1, fontWeight: FontWeight.w300)),
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    Text(
                      '₽',
                      style: Theme.of(context).textTheme.bodyText2.merge(
                          TextStyle(
                              color: primary_700,
                              height: 1.1,
                              fontWeight: FontWeight.w300)),
                    ),
                  ],
                ),
                //             // sale == true
                //             //     ? Column(
                //             //   children: [
                //             //     SizedBox(
                //             //       height:2,
                //             //     ),
                //             //     Text(
                //             //       '500',
                //             //       style: Theme.of(context)
                //             //           .textTheme
                //             //           .overline
                //             //           .merge(TextStyle(
                //             //           decoration:
                //             //           TextDecoration.lineThrough,
                //             //           fontWeight: FontWeight.w300,height: 1.1)),
                //             //     ),
                //             //   ],
                //             // )
                //             //     : SizedBox(),
              ],
            ),
          ),
          SizedBox(
            width: 6,
          ),
          // SvgPicture.asset(
          //   'assets/icons/favorite_filled_false.svg',
          //   color: expanded_red_450,
          //   width: 32,
          //   height: 32,
          //   fit: BoxFit.contain,
          // ),
          GestureDetector(
              child: FutureBuilder<bool>(
                future: widget.isFavorite,
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.hasData) {
                    return SvgPicture.asset(
                      (tapped ? _localFavBool : snapshot.data)
                          ? 'assets/icons/favorite_filled_true.svg'
                          : 'assets/icons/favorite_filled_false.svg',
                      color: expanded_red_450,
                      width: 32,
                      height: 32,
                      fit: BoxFit.contain,
                    );
                  } else if (snapshot.hasError) {
                    return SvgPicture.asset(
                      'assets/icons/favorite_filled_false.svg',
                      color: neutral_500,
                      width: 32,
                      height: 32,
                      fit: BoxFit.contain,
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              onTap: () {
                setState(() {
                  tapped = true;
                  _localFavBool = !_localFavBool;
                });
                widget.handleFavorites(widget.product, _localFavBool);
              }),
          SizedBox(
            width: 12,
          ),
          PrimaryButton(
            // icon: null,
            small: false,
            text: "В корзину",
            onPressed: () {
              widget.handleCart(widget.product);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Добавлено в корзину.'),
                ),
              );
            },
            min_width: 176,
            min_height: 48,
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
  }
}
