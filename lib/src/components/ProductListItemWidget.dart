import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/components/PrimaryButtonWidget.dart';
import 'package:markets/src/controllers/product_controller.dart';
import 'package:markets/src/helpers/colors.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../models/Product.dart';
import '../models/route_argument.dart';
import '../helpers/helper.dart';
import '../models/route_argument.dart';
import '../repository/user_repository.dart';

class ProductListItemWidget extends StatefulWidget {
  ProductListItemWidget({
    Key key,
    this.image_width,
    this.image_height,
    this.info_width,
    this.info_height,
    this.product_name,
    this.product_category,
    this.new_product,
    this.sale,
    this.review,
    this.buttonText,
    this.icon,
    this.horizontal,
    this.heroTag,
    this.product,
    this.handleFavorites,
    this.handleCart,
    this.onPressed,
    // this.isFavorite,
    // this.isInCart
  }) : super(key: key);
  final double image_width;
  final double image_height;
  final double info_width;
  final double info_height;
  final String product_name;
  final String product_category;
  final bool new_product;
  final bool sale;
  final bool review;
  final bool buttonText;
  final Widget icon;
  final bool horizontal;
  String heroTag;
  Product product;
  // Future<bool> isFavorite;
  // Future<bool> isInCart;
  final VoidCallback onPressed;
  final void Function(Product, bool) handleFavorites;
  final void Function(Product) handleCart;
  @override
  _ProductListItemWidgetState createState() => _ProductListItemWidgetState();
}

class _ProductListItemWidgetState extends StateMVC<ProductListItemWidget> {
  ProductController _con;

  _ProductListItemWidgetState() : super(ProductController()) {
    _con = controller;
  }

  Future<bool> _localFav;
  // Future<bool> _localCart;
  bool _localFavBool;
  // Future<bool> _localCartBool;
  bool tapped = false;
  // bool _isAdded = false;

  void initFav() async {
    _localFavBool = await _con.isInFavorite(widget.product.id);
    _localFav = _con.isInFavorite(widget.product.id);
    // _localCart = _con.isInCart(widget.product.id);
  }

  @override
  void didChangeDependencies() {
    initFav();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return widget.horizontal
        ? InkWell(
            onTap: () => Navigator.of(context).pushNamed('/Product',
                arguments: new RouteArgument(
                    heroTag: this.widget.heroTag, id: this.widget.product.id)),
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
                          tag: widget.heroTag + widget.product.id,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        widget.product.image.thumb ??
                                            widget.product.imageurl),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    bottomLeft: Radius.circular(5))),
                            height: widget.image_height,
                            width: double.infinity,
                          ),
                        ),
                        widget.review == true
                            ? Positioned(
                                right: 0,
                                bottom: 6,
                                child: Container(
                                  // alignment: Alignment.centerRight,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color: primary_50,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(3),
                                          bottomLeft: Radius.circular(3))),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(6, 2, 6, 2),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/grade_200_16.svg',
                                          color: accent_200,
                                        ),
                                        SizedBox(
                                          width: 1,
                                        ),
                                        Text(
                                          '4.9',
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption
                                              .merge(TextStyle(
                                                  color: neutral_200)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            widget.new_product == true
                                ? Flexible(
                                    child: Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Container(
                                      height: 20,
                                      decoration: BoxDecoration(
                                          color: expanded_green_dimmed_400,
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(3),
                                              topRight: Radius.circular(3))),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            6, 4, 6, 4),
                                        child: Text(
                                          'новинка',
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        ),
                                      ),
                                    ),
                                  ))
                                : SizedBox(),
                            widget.product.discountPrice != 0.0
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
                                        padding: const EdgeInsets.fromLTRB(
                                            6, 4, 6, 4),
                                        child: Text(
                                          "-${(widget.product.discountPrice - widget.product.price) * 100 ~/ widget.product.discountPrice}"
                                                  .toString() +
                                              "%",
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.product.name,
                                style: Theme.of(context).textTheme.headline3,
                              ),
                              SizedBox(
                                height: 4,
                              ),

                              ///Не отображается категория
                              // Text(
                              //   product.category.name ?? '',
                              //   style: Theme.of(context).textTheme.overline,
                              // ),
                              Text(
                                widget.product_category ??
                                    widget.product.catname,
                                style: Theme.of(context).textTheme.overline,
                              ),
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
                                        widget.product.price,
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
                                  widget.product.discountPrice != 0.0
                                      ? Column(
                                          children: [
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Helper.getPrice(
                                              widget.product.discountPrice,
                                              context,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .overline
                                                  .merge(TextStyle(
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      fontWeight:
                                                          FontWeight.w300,
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
                            // Container(
                            //     padding: EdgeInsets.all(6),
                            //     child: SvgPicture.asset(
                            //       'assets/icons/favorite_filled_false.svg',
                            //       color: expanded_red_450,
                            //     )),
                            PrimaryButton(
                              icon: SvgPicture.asset(
                                  'assets/icons/cart_200.svg',
                                  color: primary_50),
                              small: true,
                              onPressed: widget.onPressed,
                              left_padding: 8,
                              right_padding: 8,
                              top_padding: 8,
                              bottom_padding: 8,
                              border_radius: 3,
                              buttonText: widget.buttonText,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  width: widget.image_width,
                  height: widget.image_height,
                  decoration: BoxDecoration(
                      color: primary_50,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Stack(
                    fit: StackFit.loose,
                    alignment: AlignmentDirectional.topStart,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5)),
                          child: CachedNetworkImage(
                              height: widget.image_height,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              imageUrl:
                                  // "https://sun9-57.userapi.com/impg/4bQlcatv9WLaW08DQ-2tx9rKsbOi3mQzpYZtxA/KcErEhme7F0.jpg?size=721x1080&quality=95&sign=1c1477edebf44263a30222a5e6e25bea&type=album")),
                                  widget.product.imageurl)),
                      widget.review == true
                          ? Positioned(
                              right: 0,
                              bottom: 6,
                              child: Container(
                                // alignment: Alignment.centerRight,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: primary_50,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(3),
                                        bottomLeft: Radius.circular(3))),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(6, 2, 6, 2),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/grade_200_16.svg',
                                        color: accent_200,
                                      ),
                                      SizedBox(
                                        width: 1,
                                      ),
                                      Text(
                                        '4.9',
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .merge(
                                                TextStyle(color: neutral_200)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.new_product == true
                              ? Flexible(
                                  child: Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Container(
                                    height: 20,
                                    decoration: BoxDecoration(
                                        color: expanded_green_dimmed_400,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(3),
                                            bottomRight: Radius.circular(3))),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(6, 4, 6, 4),
                                      child: Text(
                                        'новинка',
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      ),
                                    ),
                                  ),
                                ))
                              : SizedBox(),
                          widget.sale == true
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
                                        '-20%',
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      ),
                                    ),
                                  ),
                                ))
                              : SizedBox(),
                        ],
                      )
                    ],
                  )),
              Container(
                width: widget.info_width,
                height: widget.info_height,
                decoration: BoxDecoration(
                    color: primary_50,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5))),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.product_name,
                                style: Theme.of(context).textTheme.headline3,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                widget.product_category ??
                                    widget.product.catname,
                                style: Theme.of(context).textTheme.overline,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Container(
                      //   height: 4,
                      // ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Row(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        // Text(
                                        //   '320',
                                        //   style: Theme.of(context)
                                        //       .textTheme
                                        //       .bodyText1
                                        //       .merge(TextStyle(height: 1.1)),
                                        // ),
                                        Text(
                                          widget.product.price
                                              .toInt()
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .merge(TextStyle(height: 1.1)),
                                        ),
                                        SizedBox(
                                          width: 1,
                                        ),
                                        Text(
                                          '₽',
                                          style: Theme.of(context)
                                              .textTheme
                                              .overline
                                              .merge(TextStyle(
                                                  color: primary_700,
                                                  height: 1.1)),
                                        ),
                                      ],
                                    ),
                                    widget.sale == true
                                        ? Column(
                                            children: [
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                '500',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .overline
                                                    .merge(TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        fontWeight:
                                                            FontWeight.w300,
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
                              InkWell(
                                child: Container(
                                  padding: EdgeInsets.all(6),
                                  child: FutureBuilder<bool>(
                                    future: _localFav,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<bool> snapshot) {
                                      if (snapshot.hasData) {
                                        return SvgPicture.asset(
                                          (tapped
                                                  ? _localFavBool
                                                  : snapshot.data)
                                              ? 'assets/icons/favorite_filled_true.svg'
                                              : 'assets/icons/favorite_filled_false.svg',
                                          color: expanded_red_450,
                                        );
                                      } else if (snapshot.hasError) {
                                        return SvgPicture.asset(
                                          'assets/icons/favorite_filled_false.svg',
                                          color: neutral_500,
                                        );
                                      } else {
                                        return CircularProgressIndicator();
                                      }
                                    },
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    tapped = true;
                                    _localFavBool = !_localFavBool;
                                  });
                                  if (currentUser.value.id == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Авторизуйтесь. '),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pushNamed(
                                                    '/Pages',
                                                    arguments: 4);
                                              },
                                              child: Text('Перейти',
                                                  style: TextStyle(
                                                      color: Colors.black87)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  } else {
                                    widget.handleFavorites(
                                        widget.product, _localFavBool);
                                  }
                                },
                              ),
                              Expanded(
                                child: PrimaryButton(
                                  icon: Icon(Icons.add),
                                  text: 'В корзину',
                                  small: true,
                                  onPressed: () {
                                    if (currentUser.value.id == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Авторизуйтесь. '),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pushNamed('/Pages',
                                                          arguments: 4);
                                                },
                                                child: Text('Перейти',
                                                    style: TextStyle(
                                                        color: Colors.black87)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      widget.handleCart(widget.product);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text('Добавлено в корзину.'),
                                        ),
                                      );
                                    }
                                  },
                                  left_padding: 8,
                                  right_padding: 8,
                                  top_padding: 8,
                                  bottom_padding: 8,
                                  border_radius: 3,
                                  buttonText: widget.buttonText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
  }
}
