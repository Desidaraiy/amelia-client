import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/components/AlertDialogWidget.dart';
import 'package:markets/src/components/CartItemWidget.dart';
import 'package:markets/src/components/CategoryWidget.dart';
import 'package:markets/src/components/DeleteLabelWidget.dart';
import 'package:markets/src/components/ProductListWidget.dart';
import 'package:markets/src/components/SetWidget.dart';
import 'package:markets/src/components/TextInputWidget.dart';
import 'package:markets/src/components/CreateBouquetBottomSheetWidget.dart';
import 'package:markets/src/elements/CartPresent.dart';
import 'package:markets/src/helpers/colors.dart';
import 'package:markets/src/models/cart.dart';
import 'package:markets/src/models/Product.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/cart_controller.dart';
import '../elements/CartBottomDetailsWidget.dart';
import '../elements/CartItemWidget.dart';
import '../elements/EmptyCartWidget.dart';
import '../helpers/helper.dart';
import '../models/route_argument.dart';
import '../repository/settings_repository.dart';

class CartWidget extends StatefulWidget {
  final RouteArgument routeArgument;

  CartWidget({Key key, this.routeArgument}) : super(key: key);

  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends StateMVC<CartWidget> {
  CartController _con;
  int selectedIndex;
  List<Cart> _bouquetList = [];
  int selectedDeliveryIndex = 0;

  _CartWidgetState() : super(CartController()) {
    _con = controller;
  }

  Future<bool> handleClearCart() async {
    bool _deleted = await _con.clearCartCont();
    return _deleted;
  }

  void _handleBouquetSheet(_context) async {
    if (_bouquetList.length > 1) {
      showModalBottomSheet(
          isScrollControlled: true,
          context: _context,
          backgroundColor: Colors.transparent,
          builder: (_) {
            return Container(
              height: 65,
              decoration: BoxDecoration(
                  color: primary_50,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),
              child: CreateBouquetBottomSheet(),
            );
          }).then((value) {
        if (value == 'create') {
          _con.mergeCarts();
          setState(() {});
          // for (Cart cart in _con.carts) {
          //   print('Product ID: ${cart.product.id}, Merged: ${cart.merged}');

          // }
        }
      });
    }
  }

  @override
  void initState() {
    _con.listenForCarts();
    _con.getPresents();
    _con.getRelated();
    _bouquetList = _con.selectedForBouquet;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: Helper.of(context).onWillPop,
        child: Scaffold(
          backgroundColor: background,
          key: _con.scaffoldKey,
          bottomNavigationBar: _con.carts.isNotEmpty
              ? CartBottomDetailsWidget(
                  cartController: _con, deliveryOption: selectedDeliveryIndex)
              : Container(height: 0),
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
              S.of(context).cart,
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          body: RefreshIndicator(
              onRefresh: _con.refreshCarts,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: _con.carts.isEmpty
                      ? EmptyCartWidget(controller: _con)
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 16,
                            ),
                            Row(children: [
                              SvgPicture.asset('assets/icons/touch_app.svg'),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Text(
                                  // S.of(context).tap_to_create_bouquet,
                                  "Нажмите на изображение товара, чтобы выбрать цветы для создания букета. (используйте эту функцию если вы выбрали цветы из раздела «цветы в ассортименте»)",
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              )
                            ]),
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "${_con.carts.length.toString()} товаров",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialogWidget(
                                      title: "Очистить корзину?",
                                      onYes: "Удалить",
                                      onYesCallBack: () async {
                                        bool _deleted = await handleClearCart();
                                        String _snack = _deleted
                                            ? 'Корзина успешно очищена.'
                                            : 'Ошибка очистки корзины. Авторизуйтесь.';
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(_snack),
                                        ));
                                        Navigator.pop(context, "Удалить");
                                      },
                                    ),
                                  ),
                                  child: DeleteLabel(
                                      small: true, title: "Очистить корзину"),
                                )
                              ],
                            ),
                            // SizedBox(
                            //   height: 8,
                            // ),
                            // ListView(
                            //     physics: NeverScrollableScrollPhysics(),
                            //     scrollDirection: Axis.vertical,
                            //     shrinkWrap: true,
                            //     children: [
                            //       GestureDetector(
                            //         onTap: () => showModalBottomSheet(
                            //             isScrollControlled: true,
                            //             context: context,
                            //             backgroundColor: Colors.transparent,
                            //             builder: (_) {
                            //               return Container(
                            //                 height: 116,
                            //                 decoration: BoxDecoration(
                            //                     color: primary_50,
                            //                     borderRadius: BorderRadius.only(
                            //                         topRight: Radius.circular(20),
                            //                         topLeft:
                            //                             Radius.circular(20))),
                            //                 child: CreateBouquetBottomSheet(),
                            //               );
                            //             }),
                            //         child: CartItem(
                            //           counter: 4,
                            //           imgSize: 50,
                            //           cardHeight: 62,
                            //           topLeft: 5.0,
                            //           topRight: 5.0,
                            //           bottomLeft: 5.0,
                            //           bottomRight: 5.0,
                            //           in_stock: true,
                            //           title: "Поцелуй лета",
                            //           category: "Авторский букет",
                            //           sale: true,
                            //           price: "5000",
                            //           newPrice: "3930",
                            //           shade: true,
                            //           itemShade: Color.fromRGBO(56, 64, 46, 1.0),
                            //           itemStroke:
                            //               Color.fromRGBO(142, 190, 170, 1.0),
                            //         ),
                            //       ),
                            //       SizedBox(
                            //         height: 8,
                            //       ),
                            //       CartItem(
                            //         new_product: true,
                            //         counter: 1,
                            //         imgSize: 50,
                            //         cardHeight: 62,
                            //         topLeft: 5.0,
                            //         topRight: 5.0,
                            //         in_stock: true,
                            //         bottomLeft: 5.0,
                            //         bottomRight: 5.0,
                            //         title: "Поцелуй лета",
                            //         category: "Авторский букет",
                            //         sale: false,
                            //         newPrice: "3930",
                            //       ),
                            //     ]),
                            // SizedBox(
                            //   height: 8,
                            // ),
                            // ListView(
                            //     scrollDirection: Axis.vertical,
                            //     shrinkWrap: true,
                            //     children: [
                            //       CartItem(
                            //         counter: 4,
                            //         imgSize: 50,
                            //         cardHeight: 62,
                            //         topLeft: 5.0,
                            //         topRight: 5.0,
                            //         bottomLeft: 0.0,
                            //         bottomRight: 0.0,
                            //         title: "Поцелуй лета",
                            //         category: "Авторский букет",
                            //         sale: true,
                            //         price: "5000",
                            //         in_stock: true,
                            //         newPrice: "3930",
                            //         shade: true,
                            //         itemShade: Color.fromRGBO(56, 64, 46, 1.0),
                            //         itemStroke:
                            //             Color.fromRGBO(142, 190, 170, 1.0),
                            //       ),
                            //       CartItem(
                            //         in_stock: true,
                            //         new_product: true,
                            //         counter: 1,
                            //         imgSize: 50,
                            //         cardHeight: 62,
                            //         topLeft: 0.0,
                            //         topRight: 0.0,
                            //         bottomLeft: 5.0,
                            //         bottomRight: 5.0,
                            //         title: "Поцелуй лета",
                            //         category: "Авторский букет",
                            //         sale: false,
                            //         newPrice: "3930",
                            //       ),
                            //     ]),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: _con.carts.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: _con.carts[index].merged != null
                                          ? _con.carts[index].merged
                                              ? 0
                                              : 4
                                          : 4),
                                  child: CartItem(
                                    in_stock: true,
                                    new_product: false,
                                    counter: _con.carts[index].quantity.toInt(),
                                    productId: _con.carts[index].product.id,
                                    product: _con.carts[index].product,
                                    cart: _con.carts[index],
                                    onChangeSelection: (val) async {
                                      if (val) {
                                        _con.addToSelectedForBouquet(
                                            _con.carts[index]);
                                      } else {
                                        _con.removeFromSelectedForBouquet(
                                            _con.carts[index]);
                                      }
                                      setState(() {
                                        _bouquetList =
                                            _con.getSelectedForBouquet;
                                      });
                                      _handleBouquetSheet(context);
                                    },
                                    handleDeletion: (cart) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialogWidget(
                                          title:
                                              'Подтвердите удаление "${cart.product.name}"',
                                          onYes: "Удалить",
                                          onYesCallBack: () async {
                                            await _con.removeFromCart(cart);
                                            bool _removed = true;
                                            String _snack = _removed
                                                ? 'Позиция удалена.'
                                                : 'Ошибка удаления.';
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(_snack),
                                            ));
                                            Navigator.pop(context, "Удалить");
                                          },
                                        ),
                                      );
                                    },
                                    handleCounter: (counter) {
                                      if (counter >
                                          _con.carts[index].quantity.toInt()) {
                                        _con.incrementQuantity(
                                            _con.carts[index]);
                                      } else {
                                        _con.decrementQuantity(
                                            _con.carts[index]);
                                      }
                                    },
                                    sale: false,
                                    // newPrice: "3930",
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            //для примера
                            // PropertyInput(
                            //   textController: TextEditingController(),
                            //   personal: false,
                            //   small: false,
                            //   maxLines: 1,
                            //   maxLength: 100,
                            //   keyboardType: TextInputType.text,
                            //   labelText: "Промокод",
                            //   // helperText: "Промокод приеменен!",
                            // ),
                            // SizedBox(
                            //   height: 20,
                            // ),

                            (_con.presentsLoading == false &&
                                    _con.presents.isNotEmpty)
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Divider(
                                        color: expanded_light_neutral_100,
                                        height: 1.5,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'В подарок вы получите',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      !_con.presentsLoading
                                          ? SizedBox(
                                              height: 134,
                                              child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount:
                                                      _con.presents.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return CartPresent(
                                                        present: _con
                                                            .presents[index]);
                                                  }),
                                            )
                                          : SizedBox(
                                              height: 134,
                                              child: Center(
                                                  child:
                                                      CircularProgressIndicator())),
                                    ],
                                  )
                                : SizedBox(height: 0),
                            (_con.relatedLoading == false &&
                                    _con.related.isNotEmpty)
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Divider(
                                        color: expanded_light_neutral_100,
                                        height: 1.5,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Вам может понадобиться',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      ProductListWidget(
                                        productsList: _con.related,
                                        heroTag: 'home_product_carousel',
                                        inCart: true,
                                        addedCallback: () async {
                                          await Future.delayed(
                                              Duration(milliseconds: 700));
                                          _con.listenForCarts();
                                          setState(() {});
                                        },
                                      ),
                                    ],
                                  )
                                : SizedBox(height: 0),
                            // SizedBox(
                            //   height: 134,
                            //   child: ListView(
                            //     scrollDirection: Axis.horizontal,
                            //     children: [
                            //       Column(
                            //         children: [
                            //           ProductSet(
                            //             icon: false,
                            //             imgName: 'set',
                            //             setName: 'Открытка',
                            //             small: true,
                            //           ),
                            //           SizedBox(
                            //             height: 2,
                            //           ),
                            //           Row(
                            //             crossAxisAlignment:
                            //                 CrossAxisAlignment.end,
                            //             children: [
                            //               Text(
                            //                 "0",
                            //                 style: Theme.of(context)
                            //                     .textTheme
                            //                     .bodyText1,
                            //               ),
                            //               SizedBox(
                            //                 width: 1,
                            //               ),
                            //               Text(
                            //                 '₽',
                            //                 style: Theme.of(context)
                            //                     .textTheme
                            //                     .overline
                            //                     .merge(TextStyle(
                            //                         color: primary_700)),
                            //               ),
                            //             ],
                            //           ),
                            //         ],
                            //       ),
                            //       SizedBox(
                            //         width: 8,
                            //       ),
                            //       Column(
                            //         children: [
                            //           ProductSet(
                            //             icon: false,
                            //             imgName: 'set',
                            //             setName: 'Инструкция по уходу',
                            //             small: true,
                            //           ),
                            //           SizedBox(
                            //             height: 2,
                            //           ),
                            //           Row(
                            //             crossAxisAlignment:
                            //                 CrossAxisAlignment.end,
                            //             children: [
                            //               Text(
                            //                 "0",
                            //                 style: Theme.of(context)
                            //                     .textTheme
                            //                     .bodyText1,
                            //               ),
                            //               SizedBox(
                            //                 width: 1,
                            //               ),
                            //               Text(
                            //                 '₽',
                            //                 style: Theme.of(context)
                            //                     .textTheme
                            //                     .overline
                            //                     .merge(TextStyle(
                            //                         color: primary_700)),
                            //               ),
                            //             ],
                            //           ),
                            //         ],
                            //       ),
                            //       SizedBox(
                            //         width: 8,
                            //       ),
                            //       Column(
                            //         children: [
                            //           ProductSet(
                            //             icon: false,
                            //             imgName: 'set',
                            //             setName: 'Средство для подкормки',
                            //             small: true,
                            //           ),
                            //           SizedBox(
                            //             height: 2,
                            //           ),
                            //           Row(
                            //             crossAxisAlignment:
                            //                 CrossAxisAlignment.end,
                            //             children: [
                            //               Text(
                            //                 "0",
                            //                 style: Theme.of(context)
                            //                     .textTheme
                            //                     .bodyText1,
                            //               ),
                            //               SizedBox(
                            //                 width: 1,
                            //               ),
                            //               Text(
                            //                 '₽',
                            //                 style: Theme.of(context)
                            //                     .textTheme
                            //                     .overline
                            //                     .merge(TextStyle(
                            //                         color: primary_700)),
                            //               ),
                            //             ],
                            //           ),
                            //         ],
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            SizedBox(
                              height: 20,
                            ),
                            Divider(
                              color: expanded_light_neutral_100,
                              height: 1.5,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Товары',
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${_con.total}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          .merge(TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: neutral_500)),
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
                            // SizedBox(
                            //   height: 10,
                            // ),
                            // Row(
                            //   children: [
                            //     Expanded(
                            //       child: Text(
                            //         'Скидка',
                            //         style:
                            //             Theme.of(context).textTheme.subtitle1,
                            //       ),
                            //     ),
                            //     Row(
                            //       crossAxisAlignment: CrossAxisAlignment.end,
                            //       children: [
                            //         Text(
                            //           "–550",
                            //           style: Theme.of(context)
                            //               .textTheme
                            //               .subtitle1
                            //               .merge(TextStyle(
                            //                   fontWeight: FontWeight.w500,
                            //                   color: expanded_red_450)),
                            //         ),
                            //         SizedBox(
                            //           width: 1,
                            //         ),
                            //         Text(
                            //           '₽',
                            //           style: Theme.of(context)
                            //               .textTheme
                            //               .bodyText2
                            //               .merge(TextStyle(
                            //                   color: expanded_red_450)),
                            //         ),
                            //       ],
                            //     ),
                            //   ],
                            // ),
                            SizedBox(
                              height: 20,
                            ),
                            Divider(
                              color: expanded_light_neutral_100,
                              height: 1.5,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 82,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: List.generate(2, (index) {
                                  final bool isTapped =
                                      index == selectedDeliveryIndex;
                                  return Container(
                                    margin: EdgeInsets.only(left: 16),
                                    child: CustomCategory(
                                      price: index == 1 ? "250" : "250",
                                      onTap: () {
                                        setState(() {
                                          selectedDeliveryIndex = index;
                                        });
                                      },
                                      free: index == 0,
                                      title:
                                          index == 0 ? 'Самовывоз' : 'Доставка',
                                      categoryPhoto: index > 0
                                          ? SvgPicture.asset(
                                              'assets/icons/delivery_200.svg',
                                              color: neutral_500,
                                              fit: BoxFit.cover,
                                            )
                                          : SvgPicture.asset(
                                              'assets/icons/store_200.svg',
                                              color: neutral_500,
                                              fit: BoxFit.cover,
                                            ),
                                      enableBorder: isTapped,
                                    ),
                                  );
                                }),
                              ),
                            ),
                            // SizedBox(
                            //   height: 82,
                            //   child: ListView(
                            //     scrollDirection: Axis.horizontal,
                            //     children: [
                            //       CustomCategory(
                            //         price: "0",
                            //         onTap: () {},
                            //         free: true,
                            //         title: 'Самовывоз',
                            //         categoryPhoto: SvgPicture.asset(
                            //           'assets/icons/store_200.svg',
                            //           color: neutral_500,
                            //           fit: BoxFit.cover,
                            //         ),
                            //         enableBorder: true,
                            //       ),
                            //       SizedBox(
                            //         width: 8,
                            //       ),
                            //       CustomCategory(
                            //         price: "0",
                            //         onTap: () {},
                            //         free: false,
                            //         enableBorder: false,
                            //         title: 'Дневная доставка',
                            //         categoryPhoto: SvgPicture.asset(
                            //           'assets/icons/delivery_200.svg',
                            //           color: neutral_500,
                            //           fit: BoxFit.cover,
                            //         ),
                            //       ),
                            //       SizedBox(
                            //         width: 8,
                            //       ),
                            //       CustomCategory(
                            //         price: "500",
                            //         onTap: () {},
                            //         free: false,
                            //         title: 'Ночная доставка',
                            //         categoryPhoto: SvgPicture.asset(
                            //           'assets/icons/delivery_200.svg',
                            //           color: neutral_500,
                            //           fit: BoxFit.cover,
                            //         ),
                            //         enableBorder: false,
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            SizedBox(
                              height: 20,
                            ),
                            Divider(
                              color: expanded_light_neutral_100,
                              height: 1.5,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // Text(
                            //   'Временно нет в наличии',
                            //   style: Theme.of(context)
                            //       .textTheme
                            //       .subtitle1
                            //       .merge(TextStyle(color: semantic_error)),
                            // ),
                            // SizedBox(
                            //   height: 8,
                            // ),
                            // CartItem(
                            //   in_stock: false,
                            //   new_product: true,
                            //   counter: 1,
                            //   imgSize: 50,
                            //   cardHeight: 62,
                            //   topLeft: 5.0,
                            //   topRight: 5.0,
                            //   bottomLeft: 5.0,
                            //   bottomRight: 5.0,
                            //   title: "Поцелуй лета",
                            //   category: "Авторский букет",
                            //   sale: false,
                            //   newPrice: "3930",
                            // ),
                          ],
                        ),
                ),
              )

              // Stack(
              //         alignment: AlignmentDirectional.bottomCenter,
              //         children: [
              //           ListView(
              //             primary: true,
              //             children: <Widget>[
              //               Padding(
              //                 padding: const EdgeInsets.only(left: 20, right: 10),
              //                 child: ListTile(
              //                   contentPadding: EdgeInsets.symmetric(vertical: 0),
              //                   title: Text(
              //                     S.of(context).shopping_cart,
              //                     maxLines: 1,
              //                     overflow: TextOverflow.ellipsis,
              //                     style: Theme.of(context).textTheme.headline4,
              //                   ),
              //                   subtitle: Text(
              //                     S.of(context).verify_your_quantity_and_click_checkout,
              //                     maxLines: 1,
              //                     overflow: TextOverflow.ellipsis,
              //                     style: Theme.of(context).textTheme.caption,
              //                   ),
              //                 ),
              //               ),
              //               ListView.separated(
              //                 padding: EdgeInsets.only(top: 15, bottom: 120),
              //                 scrollDirection: Axis.vertical,
              //                 shrinkWrap: true,
              //                 primary: false,
              //                 itemCount: _con.carts.length,
              //                 separatorBuilder: (context, index) {
              //                   return SizedBox(height: 15);
              //                 },
              //                 itemBuilder: (context, index) {
              //                   return CartItemWidget(
              //                     cart: _con.carts.elementAt(index),
              //                     heroTag: 'cart',
              //                     increment: () {
              //                       _con.incrementQuantity(_con.carts.elementAt(index));
              //                     },
              //                     decrement: () {
              //                       _con.decrementQuantity(_con.carts.elementAt(index));
              //                     },
              //                     onDismissed: () {
              //                       _con.removeFromCart(_con.carts.elementAt(index));
              //                     },
              //                   );
              //                 },
              //               ),
              //             ],
              //           ),
              //           Container(
              //             padding: const EdgeInsets.all(18),
              //             margin: EdgeInsets.only(bottom: 15),
              //             decoration: BoxDecoration(
              //                 color: Theme.of(context).primaryColor,
              //                 borderRadius: BorderRadius.all(Radius.circular(20)),
              //                 boxShadow: [BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.15), offset: Offset(0, 2), blurRadius: 5.0)]),
              //             child: TextField(
              //               keyboardType: TextInputType.text,
              //               onSubmitted: (String value) {
              //                 _con.doApplyCoupon(value);
              //               },
              //               cursorColor: Theme.of(context).accentColor,
              //               controller: TextEditingController()..text = coupon?.code ?? '',
              //               decoration: InputDecoration(
              //                 contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              //                 floatingLabelBehavior: FloatingLabelBehavior.always,
              //                 hintStyle: Theme.of(context).textTheme.bodyText1,
              //                 suffixText: coupon?.valid == null ? '' : (coupon.valid ? S.of(context).validCouponCode : S.of(context).invalidCouponCode),
              //                 suffixStyle: Theme.of(context).textTheme.caption.merge(TextStyle(color: _con.getCouponIconColor())),
              //                 suffixIcon: Padding(
              //                   padding: const EdgeInsets.symmetric(horizontal: 15),
              //                   child: Icon(
              //                     Icons.confirmation_number_outlined,
              //                     color: _con.getCouponIconColor(),
              //                     size: 28,
              //                   ),
              //                 ),
              //                 hintText: S.of(context).haveCouponCode,
              //                 border: OutlineInputBorder(
              //                     borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
              //                 focusedBorder: OutlineInputBorder(
              //                     borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
              //                 enabledBorder: OutlineInputBorder(
              //                     borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              ),
        ));
  }
}
