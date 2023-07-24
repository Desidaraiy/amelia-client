import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/components/ProductBottomDetailsWidget.dart';
import 'package:markets/src/components/CounterWidget.dart';
import 'package:markets/src/components/PrimaryButtonWidget.dart';
import 'package:markets/src/components/ProductReviewWidget.dart';

import 'package:markets/src/components/SetWidget.dart';
import 'package:markets/src/controllers/cart_controller.dart';
import 'package:markets/src/elements/ShoppingCartButtonWidget.dart';
import 'package:markets/src/helpers/colors.dart';
import 'package:markets/src/models/Product.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:markets/src/components/ProductTagWidget.dart';
import '../../generated/l10n.dart';
import '../controllers/product_controller.dart';
import '../elements/AddToCartAlertDialog.dart';
import '../elements/CircularLoadingWidget.dart';
import 'package:markets/src/components/ProductListItemWidget.dart';
import '../elements/OptionItemWidget.dart';
import '../elements/ReviewsListWidget.dart';
import '../elements/ShoppingCartFloatButtonWidget.dart';
import '../helpers/helper.dart';
import '../models/media.dart';
import '../models/route_argument.dart';
import '../repository/user_repository.dart';

// ignore: must_be_immutable
class ProductWidget extends StatefulWidget {
  RouteArgument routeArgument;

  ProductWidget({Key key, this.routeArgument}) : super(key: key);

  @override
  _ProductWidgetState createState() {
    return _ProductWidgetState();
  }
}

class _ProductWidgetState extends StateMVC<ProductWidget> {
  ProductController _con;
  List<int> roses = [1, 3, 5, 7, 9, 11, 13, 15];
  int selectedIndex;
  double sum;
  _ProductWidgetState() : super(ProductController()) {
    _con = controller;
  }

  String extractParagraph(String input) {
    final startTag = '<p>';
    final endTag = '</p>';

    final startIndex = input.indexOf(startTag);
    final endIndex = input.indexOf(endTag);

    if (startIndex != -1 && endIndex != -1) {
      return input.substring(startIndex + startTag.length, endIndex);
    } else {
      return input;
    }
  }

  void _setSum() {
    double _price = _con.product.price * roses[selectedIndex];
    setState(() {
      sum = _price;
    });
  }

  @override
  void initState() {
    _con.listenForProduct(productId: widget.routeArgument.id);
    _con.listenForCart();
    _con.listenForFavorite(productId: widget.routeArgument.id);
    super.initState();
    setState(() {
      selectedIndex = 0;
    });
    // _setSum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _con.product != null
          ? ProductBottomDetailsWidget(
              product: _con.product,
              price: sum,
              isFavorite: _con.isInFavorite(widget.routeArgument.id),
              handleFavorites: (p, fav) {
                if (fav) {
                  _con.addToFavorite(p);
                } else {
                  _con.removeFromFavorite(p.id);
                }
              },
              handleCart: (p) {
                if (selectedIndex != null) {
                  _con.addToCart(p, quantity: roses[selectedIndex]);
                } else {
                  _con.addToCart(p);
                }
              },
            )
          : Container(height: 0),
      key: _con.scaffoldKey,
      backgroundColor: background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primary_50,
        elevation: 0,
        title: Text(
          S.of(context).more,
          style: Theme.of(context).textTheme.headline2,
        ),
        actions: [
          Stack(
            alignment: AlignmentDirectional.centerStart,
            children: <Widget>[
              _con.loadCart
                  ? SizedBox(
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                      ),
                    )
                  : ShoppingCartButtonWidget(
                      iconColor: Theme.of(context).hintColor,
                      labelColor: Theme.of(context).accentColor),
              // Container(
              //   child: Text(
              //     _con.cart.,
              //     textAlign: TextAlign.center,
              //     style: Theme.of(context).textTheme.caption.merge(
              //       TextStyle(color: Theme.of(context).primaryColor, fontSize: 10),
              //     ),
              //   ),
              //   padding: EdgeInsets.all(0),
              //   decoration: BoxDecoration(color: this.widget.labelColor, borderRadius: BorderRadius.all(Radius.circular(10))),
              //   constraints: BoxConstraints(minWidth: 15, maxWidth: 15, minHeight: 15, maxHeight: 15),
              // ),
            ],
          ),
        ],
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: SvgPicture.asset(
              'assets/icons/navigate_before_200.svg',
              color: primary_700,
              width: 24,
              height: 24,
              fit: BoxFit.scaleDown,
            )),
      ),
      body: _con.product == null ||
              _con.product?.image == null ||
              _con.product?.images == null
          ? CircularLoadingWidget(height: 500)
          : RefreshIndicator(
              onRefresh: _con.refreshProduct,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 0),
                    padding: EdgeInsets.only(bottom: 0),
                    child: CustomScrollView(
                      primary: true,
                      shrinkWrap: false,
                      slivers: <Widget>[
                        SliverAppBar(
                          automaticallyImplyLeading: false,
                          backgroundColor: background,
                          expandedHeight: 220,
                          elevation: 0,
                          iconTheme: IconThemeData(
                              color: Theme.of(context).primaryColor),
                          flexibleSpace: FlexibleSpaceBar(
                            collapseMode: CollapseMode.parallax,
                            background: Stack(
                              alignment: AlignmentDirectional.bottomCenter,
                              children: <Widget>[
                                CarouselSlider(
                                  options: CarouselOptions(
                                    autoPlay: true,
                                    autoPlayInterval: Duration(seconds: 7),
                                    height: 220,
                                    viewportFraction: 1.0,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _con.current = index;
                                      });
                                    },
                                  ),
                                  items: _con.product.images.map((Media image) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return CachedNetworkImage(
                                          height: 220,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          imageUrl: image.url,
                                          placeholder: (context, url) =>
                                              Image.asset(
                                            'assets/img/loading.gif',
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: 300,
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error_outline),
                                        );
                                      },
                                    );
                                  }).toList(),
                                ),
                                Container(
                                  //margin: EdgeInsets.symmetric(vertical: 22, horizontal: 42),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children:
                                        _con.product.images.map((Media image) {
                                      return Container(
                                        width: 5.0,
                                        height: 5.0,
                                        margin: EdgeInsets.symmetric(
                                            vertical: 20.0, horizontal: 2.0),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            color: primary_50),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
                            child: Wrap(
                              runSpacing: 20,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 0, 16, 0),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ProductTagWidget(
                                            text: "-10%",
                                            tagColor: expanded_red_550,
                                            topPadding: 4,
                                            bottomPadding: 4,
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          ProductTagWidget(
                                            text: "К 1 сентября",
                                            tagColor: accent_200,
                                            topPadding: 3,
                                            bottomPadding: 5,
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          ProductTagWidget(
                                            text: "новинка",
                                            tagColor: expanded_green_dimmed_400,
                                            topPadding: 3,
                                            bottomPadding: 5,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        children: [
                                          ProductTagWidget(
                                              text: _con.product.market.name,
                                              tagColor: neutral_400,
                                              topPadding: 3,
                                              bottomPadding: 3,
                                              icon: SvgPicture.asset(
                                                'assets/icons/store_300.svg',
                                                height: 16,
                                                width: 16,
                                                color: neutral_400,
                                                fit: BoxFit.scaleDown,
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 3,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  _con.product?.name ?? '',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline2,
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        _con.product?.category
                                                                ?.name ??
                                                            '',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 2,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText2
                                                            .merge(TextStyle(
                                                                color:
                                                                    neutral_200)),
                                                      ),
                                                    ),
                                                    Row(children: [
                                                      SvgPicture.asset(
                                                        'assets/icons/grade_200_16.svg',
                                                        color: accent_200,
                                                      ),
                                                      Text(
                                                        "4.9",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText2
                                                            .merge(TextStyle(
                                                                color:
                                                                    neutral_200,
                                                                height: 1.1)),
                                                      )
                                                    ])
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 16,
                                                ),
                                                Text(
                                                  'Состав',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1,
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  extractParagraph(_con.product
                                                          ?.description) ??
                                                      '',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                          color: neutral_200)),
                                                ),
                                                // SizedBox(
                                                //   height: 16,
                                                // ),
                                                // Column(
                                                //   crossAxisAlignment:
                                                //       CrossAxisAlignment.start,
                                                //   children: [
                                                //     Text(
                                                //       'Размер',
                                                //       style: Theme.of(context)
                                                //           .textTheme
                                                //           .subtitle1,
                                                //     ),
                                                //     SizedBox(
                                                //       height: 8,
                                                //     ),
                                                //     Column(
                                                //       crossAxisAlignment:
                                                //           CrossAxisAlignment
                                                //               .start,
                                                //       children: [
                                                //         Row(
                                                //           children: [
                                                //             Image.asset(
                                                //                 'assets/img/bouquet_size.png'),
                                                //             SizedBox(
                                                //               width: 2,
                                                //             ),
                                                //             Row(
                                                //               children: [
                                                //                 SvgPicture.asset(
                                                //                     'assets/icons/ruler_vertical.svg'),
                                                //                 SizedBox(
                                                //                   width: 2,
                                                //                 ),
                                                //                 Text(
                                                //                   "34 см",
                                                //                   style: Theme.of(
                                                //                           context)
                                                //                       .textTheme
                                                //                       .overline
                                                //                       .merge(TextStyle(
                                                //                           color:
                                                //                               neutral_500)),
                                                //                 ),
                                                //               ],
                                                //             ),
                                                //           ],
                                                //         ),
                                                //         SizedBox(
                                                //           height: 2,
                                                //         ),
                                                //         Column(
                                                //           children: [
                                                //             SvgPicture.asset(
                                                //                 'assets/icons/ruler_horizontal.svg'),
                                                //             SizedBox(
                                                //               height: 4,
                                                //             ),
                                                //             Text(
                                                //               "52.6 см",
                                                //               style: Theme.of(
                                                //                       context)
                                                //                   .textTheme
                                                //                   .overline
                                                //                   .merge(TextStyle(
                                                //                       color:
                                                //                           neutral_500)),
                                                //             ),
                                                //           ],
                                                //         ),
                                                //       ],
                                                //     ),
                                                //   ],
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 0, 16, 0),
                                  child: Divider(
                                    color: expanded_light_neutral_100,
                                    height: 1.5,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          16,
                                          0,
                                          16,
                                          _con.product.category.name == "Розы"
                                              ? 8
                                              : 0),
                                      child: Text(
                                        'Количество',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                    ),

                                    /// если выбраны розы
                                    _con.product.category.name == "Розы"
                                        ? SizedBox(
                                            height: 42,
                                            child: ListView.builder(
                                              itemCount: roses.length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder:
                                                  (context, int index) {
                                                return Row(
                                                  children: [
                                                    index == 0
                                                        ? SizedBox(
                                                            width: 16,
                                                          )
                                                        : SizedBox(),
                                                    InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          selectedIndex = index;
                                                        });
                                                        _setSum();
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: 42,
                                                        height: 42,
                                                        decoration: BoxDecoration(
                                                            border: selectedIndex ==
                                                                    index
                                                                ? Border.all(
                                                                    style:
                                                                        BorderStyle
                                                                            .none)
                                                                : Border.all(
                                                                    color:
                                                                        accent_200,
                                                                    width: 1.5),
                                                            color:
                                                                selectedIndex ==
                                                                        index
                                                                    ? accent_200
                                                                    : background,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0)),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal: 8,
                                                                  vertical: 9),
                                                          child: Text(
                                                              roses[index]
                                                                  .toString(),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .button
                                                                  .merge(TextStyle(
                                                                      height:
                                                                          1.2,
                                                                      fontSize:
                                                                          17.07,
                                                                      color: selectedIndex ==
                                                                              index
                                                                          ? background
                                                                          : accent_200))),
                                                        ),
                                                      ),
                                                    ),
                                                    index != roses.length - 1
                                                        ? SizedBox(
                                                            width: 8,
                                                          )
                                                        : SizedBox(),
                                                    index == roses.length - 1
                                                        ? SizedBox(
                                                            width: 16,
                                                          )
                                                        : SizedBox(),
                                                  ],
                                                );
                                              },
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Counter(
                                              counter: 1,
                                            ),
                                          ),
                                  ],
                                ),

                                // Padding(
                                //   padding: EdgeInsets.symmetric(horizontal: 16),
                                //   child: Column(
                                //     crossAxisAlignment:
                                //         CrossAxisAlignment.start,
                                //     children: [
                                //       Text(
                                //         'Цвет',
                                //         style: Theme.of(context)
                                //             .textTheme
                                //             .subtitle1,
                                //       ),
                                //       SizedBox(
                                //         height: 8,
                                //       ),
                                //       Row(
                                //         children: [
                                //           Container(
                                //             width: 36,
                                //             height: 36,
                                //             decoration: BoxDecoration(
                                //                 color: Color.fromRGBO(
                                //                     86, 98, 144, 1.0),
                                //                 borderRadius: BorderRadius.all(
                                //                     Radius.circular(10)),
                                //                 border: Border.all(
                                //                     width: 1.0,
                                //                     color: primary_700)),
                                //           ),
                                //           SizedBox(
                                //             width: 6,
                                //           ),
                                //           Container(
                                //             width: 36,
                                //             height: 36,
                                //             decoration: BoxDecoration(
                                //                 color: Color.fromRGBO(
                                //                     232, 150, 177, 1.0),
                                //                 borderRadius: BorderRadius.all(
                                //                     Radius.circular(10))),
                                //           ),
                                //           SizedBox(
                                //             width: 6,
                                //           ),
                                //           Container(
                                //             width: 36,
                                //             height: 36,
                                //             decoration: BoxDecoration(
                                //                 color: Color.fromRGBO(
                                //                     242, 247, 250, 1.0),
                                //                 borderRadius: BorderRadius.all(
                                //                     Radius.circular(10)),
                                //                 border: Border.all(
                                //                     width: 1.0,
                                //                     color: neutral_100)),
                                //           ),
                                //         ],
                                //       ),
                                //     ],
                                //   ),
                                // ),

                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 0, 16, 0),
                                  child: Divider(
                                    color: expanded_light_neutral_100,
                                    height: 1.5,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 0, 16, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'В подарок вы получите',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      SizedBox(
                                        height: 116,
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: [
                                            Column(
                                              children: [
                                                ProductSet(
                                                  icon: false,
                                                  imgName: 'set',
                                                  setName: 'Открытка',
                                                  small: true,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Column(
                                              children: [
                                                ProductSet(
                                                  icon: false,
                                                  imgName: 'set',
                                                  setName:
                                                      'Инструкция по уходу',
                                                  small: true,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Column(
                                              children: [
                                                ProductSet(
                                                  icon: false,
                                                  imgName: 'set',
                                                  setName:
                                                      'Средство для подкормки',
                                                  small: true,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 0, 16, 0),
                                  child: Divider(
                                    color: expanded_light_neutral_100,
                                    height: 1.5,
                                  ),
                                ),
                                // Column(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: [
                                //     Padding(
                                //       padding: const EdgeInsets.fromLTRB(
                                //           16, 0, 16, 0),
                                //       child: Text(
                                //         'Рекомендуем вам',
                                //         style: Theme.of(context)
                                //             .textTheme
                                //             .subtitle1,
                                //       ),
                                //     ),
                                //     SizedBox(
                                //       height: 8,
                                //     ),
                                //     Container(
                                //       height: 230,
                                //       child: ListView(
                                //         scrollDirection: Axis.horizontal,
                                //         children: [
                                //           SizedBox(
                                //             width: 16,
                                //           ),
                                //           SizedBox(
                                //             width: 8,
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // Row(
                                //   children: <Widget>[
                                //     Container(
                                //       padding: EdgeInsets.symmetric(
                                //           horizontal: 12, vertical: 3),
                                //       decoration: BoxDecoration(
                                //           color: Helper.canDelivery(
                                //                       _con.product.market) &&
                                //                   _con.product.deliverable
                                //               ? Colors.green
                                //               : Colors.orange,
                                //           borderRadius:
                                //               BorderRadius.circular(24)),
                                //       child: Helper.canDelivery(
                                //                   _con.product.market) &&
                                //               _con.product.deliverable
                                //           ? Text(
                                //               S.of(context).deliverable,
                                //               style: Theme.of(context)
                                //                   .textTheme
                                //                   .caption
                                //                   .merge(TextStyle(
                                //                       color: Theme.of(context)
                                //                           .primaryColor)),
                                //             )
                                //           : Text(
                                //               S.of(context).not_deliverable,
                                //               style: Theme.of(context)
                                //                   .textTheme
                                //                   .caption
                                //                   .merge(TextStyle(
                                //                       color: Theme.of(context)
                                //                           .primaryColor)),
                                //             ),
                                //     ),
                                //   ],
                                // ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 0, 16, 0),
                                  child: Divider(
                                    color: expanded_light_neutral_100,
                                    height: 1.5,
                                  ),
                                ),
                                // if (_con.product.optionGroups.isNotEmpty)
                                //   ListTile(
                                //     dense: true,
                                //     contentPadding:
                                //         EdgeInsets.symmetric(vertical: 10),
                                //     leading: Icon(
                                //       Icons.add_circle_outline,
                                //       color: Theme.of(context).hintColor,
                                //     ),
                                //     title: Text(
                                //       S.of(context).options,
                                //       style:
                                //           Theme.of(context).textTheme.subtitle1,
                                //     ),
                                //     subtitle: Text(
                                //       S
                                //           .of(context)
                                //           .select_options_to_add_them_on_the_product,
                                //       style:
                                //           Theme.of(context).textTheme.caption,
                                //     ),
                                //   ),
                                // _con.product.optionGroups?.isNotEmpty ?? false
                                //     ? CircularLoadingWidget(height: 100)
                                //     : ListView.separated(
                                //         padding: EdgeInsets.all(0),
                                //         itemBuilder:
                                //             (context, optionGroupIndex) {
                                //           var optionGroup = _con
                                //               .product.optionGroups
                                //               .elementAt(optionGroupIndex);
                                //           return Wrap(
                                //             children: <Widget>[
                                //               ListTile(
                                //                 dense: true,
                                //                 contentPadding:
                                //                     EdgeInsets.symmetric(
                                //                         vertical: 0),
                                //                 leading: Icon(
                                //                   Icons.add_circle_outline,
                                //                   color: Theme.of(context)
                                //                       .hintColor,
                                //                 ),
                                //                 title: Text(
                                //                   optionGroup.name,
                                //                   style: Theme.of(context)
                                //                       .textTheme
                                //                       .subtitle1,
                                //                 ),
                                //               ),
                                //               ListView.separated(
                                //                 padding: EdgeInsets.all(0),
                                //                 itemBuilder:
                                //                     (context, optionIndex) {
                                //                   return OptionItemWidget(
                                //                     option: _con.product.options
                                //                         .where((option) =>
                                //                             option
                                //                                 .optionGroupId ==
                                //                             optionGroup.id)
                                //                         .elementAt(optionIndex),
                                //                     onChanged:
                                //                         _con.calculateTotal,
                                //                   );
                                //                 },
                                //                 separatorBuilder:
                                //                     (context, index) {
                                //                   return SizedBox(height: 20);
                                //                 },
                                //                 itemCount: _con.product.options
                                //                     .where((option) =>
                                //                         option.optionGroupId ==
                                //                         optionGroup.id)
                                //                     .length,
                                //                 primary: false,
                                //                 shrinkWrap: true,
                                //               ),
                                //             ],
                                //           );
                                //         },
                                //         separatorBuilder: (context, index) {
                                //           return SizedBox(height: 20);
                                //         },
                                //         itemCount:
                                //             _con.product.optionGroups.length,
                                //         primary: false,
                                //         shrinkWrap: true,
                                //       ),
                                // Column(
                                //   children: [
                                //     Padding(
                                //       padding: const EdgeInsets.symmetric(
                                //           horizontal: 16),
                                //       child: Row(
                                //         children: [
                                //           Expanded(
                                //             child: Text(
                                //               S.of(context).reviews,
                                //               style: Theme.of(context)
                                //                   .textTheme
                                //                   .subtitle1,
                                //             ),
                                //           ),
                                //           GestureDetector(
                                //             onTap: () => Navigator.of(context)
                                //                 .pushNamed('/Reviews'),
                                //             child: Text(
                                //               S.of(context).show_all,
                                //               style: Theme.of(context)
                                //                   .textTheme
                                //                   .caption
                                //                   .merge(TextStyle(
                                //                       color: neutral_500)),
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //     SizedBox(
                                //       height: 8,
                                //     ),
                                //     SizedBox(
                                //         height: 62,
                                //         child: ListView(
                                //             scrollDirection: Axis.horizontal,
                                //             children: [
                                //               SizedBox(
                                //                 width: 16,
                                //               ),
                                //               ProductReviewWidget(
                                //                 show_all: false,
                                //               ),
                                //               SizedBox(
                                //                 width: 8,
                                //               ),
                                //               ProductReviewWidget(
                                //                 show_all: false,
                                //               ),
                                //               SizedBox(
                                //                 width: 8,
                                //               ),
                                //               ProductReviewWidget(
                                //                 show_all: false,
                                //               ),
                                //               SizedBox(
                                //                 width: 16,
                                //               ),
                                //             ])),
                                //   ],
                                // ),

                                // if (_con.product.productReviews.isEmpty)
                                //   Container(
                                //       padding: const EdgeInsets.only(bottom: 8),
                                //       //color: Colors.red,
                                //       child: SizedBox(
                                //         child: Text(
                                //             "Пользователи не оценивали данный товар"),
                                //       ))
                                // else
                                //   Padding(
                                //     padding: const EdgeInsets.only(bottom: 8),
                                //     child: ReviewsListWidget(
                                //       reviewsList: _con.product.productReviews,
                                //     ),
                                //   ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Positioned(
                  //   top: 32,
                  //   right: 20,
                  //   child: _con.loadCart
                  //       ? SizedBox(
                  //           width: 60,
                  //           height: 60,
                  //           child: RefreshProgressIndicator(),
                  //         )
                  //       : ShoppingCartFloatButtonWidget(
                  //           iconColor: Theme.of(context).primaryColor,
                  //           labelColor: Theme.of(context).hintColor,
                  //           routeArgument: RouteArgument(param: '/Product', id: _con.product.id),
                  //         ),
                  // ),
                  // Positioned(
                  //   bottom: 0,
                  // child: Container(
                  //   height: 80,
                  //   padding:
                  //       EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  //   decoration: BoxDecoration(
                  //       color: primary_50,
                  //       boxShadow: [
                  // BoxShadow(
                  //     color: Theme.of(context)
                  //         .focusColor
                  //         .withOpacity(0.15),
                  //     offset: Offset(0, -2),
                  //     blurRadius: 5.0)
                  //       ]
                  //     ),
                  // child: SizedBox(
                  //   width: MediaQuery.of(context).size.width - 16 ,
                  //   child: Container(
                  //     color: Colors.indigo,
                  //     child: Row(
                  //       // mainAxisSize: MainAxisSize.max,
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         Expanded(
                  //           flex:1,
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               Row(
                  //                 crossAxisAlignment: CrossAxisAlignment.end,
                  //
                  //                 children: [
                  //                   Text(
                  //                     '2000',
                  //                     style:
                  //                     Theme.of(context).textTheme.subtitle1.merge(TextStyle(height: 1.1, fontWeight: FontWeight.w300)),
                  //                   ),
                  //                   SizedBox(
                  //                     width: 1,
                  //                   ),
                  //                   Text(
                  //                     '₽',
                  //                     style: Theme.of(context)
                  //                         .textTheme
                  //                         .bodyText2
                  //                         .merge(TextStyle(color: primary_700,height: 1.1,fontWeight: FontWeight.w300)),
                  //                   ),
                  //                 ],
                  //               ),
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
                  //             ],
                  //           ),
                  //         ),
                  //         SizedBox(width: 6,),
                  //         SvgPicture.asset(
                  //           'assets/icons/favorite_filled_false.svg',
                  //           color: expanded_red_450,
                  //           width: 32,height: 32,fit: BoxFit.contain,
                  //         ),
                  //         SizedBox(width: 12,),
                  //         PrimaryButton(
                  //           icon: null,
                  //           small: false,
                  //           text: "В корзину",
                  //           onPressed: () {},
                  //           min_width: 176,
                  //           min_height: 48,
                  //           left_padding: 0,
                  //           right_padding: 0,
                  //           top_padding: 14,
                  //           bottom_padding: 14,
                  //           border_radius: 5,
                  //           buttonText: true,
                  //         ),
                  //
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width - 40,
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     mainAxisSize: MainAxisSize.max,
                  //     children: <Widget>[

                  // SizedBox(height: 10),
                  // Row(
                  //   children: <Widget>[
                  // Expanded(
                  //   child: _con.favorite?.id != null
                  //       ? OutlineButton(
                  //           onPressed: () {
                  //             _con.removeFromFavorite(
                  //                 _con.favorite);
                  //           },
                  //           padding: EdgeInsets.symmetric(
                  //               vertical: 14),
                  //           color: Theme.of(context).primaryColor,
                  //           shape: StadiumBorder(),
                  //           borderSide: BorderSide(
                  //               color: Theme.of(context)
                  //                   .accentColor),
                  //           child: Icon(
                  //             Icons.favorite,
                  //             color:
                  //                 Theme.of(context).accentColor,
                  //           ))
                  //       : MaterialButton(
                  //           elevation: 0,
                  //           onPressed: () {
                  //             if (currentUser.value.apiToken ==
                  //                 null) {
                  //               Navigator.of(context)
                  //                   .pushNamed("/Login");
                  //             } else {
                  //               _con.addToFavorite(_con.product);
                  //             }
                  //           },
                  //           padding: EdgeInsets.symmetric(
                  //               vertical: 14),
                  //           color: Theme.of(context).accentColor,
                  //           shape: StadiumBorder(),
                  //           child: Icon(
                  //             Icons.favorite_outline,
                  //             color:
                  //                 Theme.of(context).primaryColor,
                  //           )),
                  // ),

                  // Stack(
                  //   fit: StackFit.loose,
                  //   alignment: AlignmentDirectional.centerEnd,
                  //   children: <Widget>[
                  //     SizedBox(
                  //       width: MediaQuery.of(context).size.width -
                  //           110,
                  //       child: MaterialButton(
                  //         elevation: 0,
                  //         onPressed: () {
                  //           if (currentUser.value.apiToken ==
                  //               null) {
                  //             Navigator.of(context)
                  //                 .pushNamed("/Login");
                  //           } else {
                  //             if (_con
                  //                 .isSameMarkets(_con.product)) {
                  //               _con.addToCart(_con.product);
                  //             } else {
                  //               showDialog(
                  //                 context: context,
                  //                 builder:
                  //                     (BuildContext context) {
                  //                   // return object of type Dialog
                  //                   return AddToCartAlertDialogWidget(
                  //                       oldProduct: _con.carts
                  //                           .elementAt(0)
                  //                           ?.product,
                  //                       newProduct: _con.product,
                  //                       onPressed: (product,
                  //                           {reset: true}) {
                  //                         return _con.addToCart(
                  //                             _con.product,
                  //                             reset: true);
                  //                       });
                  //                 },
                  //               );
                  //             }
                  //           }
                  //         },
                  //         padding:
                  //             EdgeInsets.symmetric(vertical: 14),
                  //         color: Theme.of(context).accentColor,
                  //         shape: StadiumBorder(),
                  //         child: Container(
                  //           width: double.infinity,
                  //           padding: const EdgeInsets.symmetric(
                  //               horizontal: 20),
                  //           child: Text(
                  //             S.of(context).add_to_cart,
                  //             textAlign: TextAlign.start,
                  //             style: TextStyle(
                  //                 color: Theme.of(context)
                  //                     .primaryColor),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.symmetric(
                  //           horizontal: 20),
                  //       child: Helper.getPrice(
                  //         _con.total,
                  //         context,
                  //         style: Theme.of(context)
                  //             .textTheme
                  //             .headline4
                  //             .merge(TextStyle(
                  //                 color: Theme.of(context)
                  //                     .primaryColor)),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  //       ],
                  //     ),
                  //     SizedBox(height: 10),
                  //   ],
                  //   ]),
                  // ),
                  // ),
                  // )
                ],
              ),
            ),
    );
  }
}
