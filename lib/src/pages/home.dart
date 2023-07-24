import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:markets/src/components/CityDialogWidget.dart';
import 'package:markets/src/components/ProductListWidget.dart';
// import 'package:location/location.dart';
import 'package:markets/src/components/TextInputWidget.dart';
import 'package:markets/src/components/SetWidget.dart';
import 'package:markets/src/components/ModalBottomSheetWidget.dart';
import 'package:markets/src/components/FilterFormWidget.dart';
import 'package:markets/src/components/SecondaryButtonWidget.dart';
import 'package:markets/src/components/ProductListItemWidget.dart';
import 'package:markets/src/components/NotificationButtonWidget.dart';
import 'package:markets/src/components/CategoryWidget.dart';
import 'package:markets/src/components/LoadingItemWidget.dart';
import 'package:markets/src/controllers/common_controller.dart';
import 'package:markets/src/controllers/map_controller.dart';
import 'package:markets/src/elements/CardsCarouselLoaderWidget.dart';
import 'package:markets/src/helpers/colors.dart';
import 'package:markets/src/helpers/maps_util.dart';
import 'package:markets/src/models/route_argument.dart';
import 'package:markets/src/repository/user_repository.dart';
import '../models/address.dart';
import '../models/filter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../elements/CardsCarouselWidget.dart';
import '../elements/CaregoriesCarouselWidget.dart';
import '../elements/GridWidget.dart';
import '../elements/HomeSliderWidget.dart';
import '../elements/ProductsCarouselWidget.dart';

import '../elements/ReviewsListWidget.dart';
import '../elements/SearchBarWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../repository/settings_repository.dart' as settingsRepo;
import 'notifications.dart';

class HomeWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  HomeWidget({Key key, this.parentScaffoldKey, this.routeArgument})
      : super(key: key);
  final RouteArgument routeArgument;
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends StateMVC<HomeWidget> {
  Filter onFilter;
  var _markets;
  List<String> cities = settingsRepo.setting.value.activeCities;

  CommonController _con;

  _HomeWidgetState() : super(CommonController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!settingsRepo.setting.value.hasShownCityDialog) {
        _showCitySelectionDialog(context);
      } else {
        print(
            'Выбранный ранее город: ${settingsRepo.setting.value.activeCity}');
      }
    });
    _markets = markets();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _showCitySelectionDialog(context) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => CityDialogWidget(
          title: "Выберите город получения или доставки товаров",
          list: cities,
          controller: _con),
    );
  }

  Future markets() async {
    _con.topMarkets.forEach((m) {
      print(m.id);
    });
    return _con.topMarkets;
  }

  // List<double> distances() {
  //   List<double> distances = [];
  //   _con.topMarkets.forEach((market) {
  //     print("ddd ${market.distance}");
  //     distances.add(market.distance);
  //   });
  //   return distances;
  // }

  int selectedIndex = 1;
  bool selectedChoice = false;
  List choices = ["Доставка", "Самовывоз"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: background,
          elevation: 0,
          centerTitle: true,
          title: ValueListenableBuilder(
            valueListenable: settingsRepo.setting,
            builder: (context, value, child) {
              return Text(
                value.appName ?? S.of(context).home,
                style: Theme.of(context).textTheme.headline2,
              );
            },
          ),
          actions: <Widget>[
            NotificationButtonWidget(),
          ],
        ),
        body: RefreshIndicator(
            onRefresh: _con.refreshHome,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: List.generate(
                    settingsRepo.setting.value.homeSections.length, (index) {
                  String _homeSection =
                      settingsRepo.setting.value.homeSections.elementAt(index);
                  switch (_homeSection) {
                    case 'greetings':
                      return Container(
                        padding: const EdgeInsets.only(left: 20, right: 16),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentUser.value.name == null
                                  ? 'Добро пожаловать!'
                                  : 'С возвращением, ${currentUser.value.name}!',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              'Выбирайте цветы с душой и по любви',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .merge(
                                      TextStyle(fontWeight: FontWeight.w300)),
                            )
                          ],
                        ),
                      );
                    case 'slider':
                      return HomeSliderWidget(slides: _con.slides);
                    case 'search':
                      // return Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 20),
                      //   child: SearchBarWidget(
                      //       onClickFilter: (event) => showModalBottomSheet(
                      //           isScrollControlled: true,
                      //           context: context,
                      //           backgroundColor: Colors.transparent,
                      //           builder: (_) {
                      //             return ModalBottomSheetWidget(
                      //               reset: true,
                      //               initialChildSize: 0.95,
                      //               widget: FilterFormWidget(),
                      //               title: S.of(context).filter,
                      //               showAll: false,
                      //             );
                      //           })),
                      // );
                      return Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Row(
                          children: [
                            Expanded(
                                child: GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, '/Pages',
                                  arguments: 1),
                              child: PropertyInput(
                                  textController: TextEditingController(),
                                  hintText: 'Название товара',
                                  small: false,
                                  personal: false,
                                  maxLines: 1,
                                  maxLength: 100,
                                  disabled: true,
                                  keyboardType: TextInputType.text,
                                  prefixIcon: SvgPicture.asset(
                                    'assets/icons/search_200.svg',
                                    height: 24,
                                    width: 24,
                                    fit: BoxFit.scaleDown,
                                  )),
                            )),
                            // SizedBox(
                            //   width: 8,
                            // ),
                            // Container(
                            //   width: 48,
                            //   height: 48,
                            //   child: SecondaryButton(
                            //     text: '',
                            //     small: true,
                            //     btn_icon:
                            //         SvgPicture.asset('assets/icons/tune.svg'),
                            //     onPressed: () {},
                            //   ),
                            // )
                          ],
                        ),
                      );
                    case 'top_markets_heading':
                      return Padding(
                        padding: const EdgeInsets.only(
                            top: 15, left: 20, right: 20, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    S.of(context).top_markets,
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                    maxLines: 1,
                                    softWrap: false,
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                                Wrap(
                                  spacing: 5,
                                  children: [
                                    ...List.generate(choices.length, (index) {
                                      return ChipTheme(
                                        data: ChipTheme.of(context).copyWith(
                                          elevation: 0,
                                          pressElevation: 0,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5),
                                            ),
                                          ),
                                        ),
                                        child: ChoiceChip(
                                          selectedColor:
                                              Theme.of(context).accentColor,
                                          backgroundColor: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.1),
                                          label: Text(
                                            choices[index],
                                            style: TextStyle(
                                                color: index == selectedIndex
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                          selected: index == selectedIndex,
                                          onSelected: (selected) {
                                            setState(() {
                                              selectedIndex = index;
                                              selectedChoice = selected;
                                              if (selectedIndex == 0) {
                                                _con.filter?.delivery = true;
                                                _con
                                                    .saveFilter()
                                                    .whenComplete(() {
                                                  onFilter = _con.filter;
                                                });
                                                _con.topMarkets.clear();
                                                _con.listenForTopMarkets();
                                              }
                                              if (selectedIndex == 1) {
                                                _con.filter?.delivery = false;
                                                _con
                                                    .saveFilter()
                                                    .whenComplete(() {
                                                  onFilter = _con.filter;
                                                });
                                                _con.topMarkets.clear();
                                                _con.listenForTopMarkets();
                                              }
                                            });
                                          },
                                        ),
                                      );
                                    })
                                  ],
                                )
                                // InkWell(
                                //   onTap: () {
                                //     setState(() {
                                //       settingsRepo.deliveryAddress.value?.address =
                                //           null;
                                //     });
                                //     if (currentUser.value.apiToken == null) {
                                //       //  _con.requestForCurrentLocation(context);
                                //     } else {
                                //       //   var bottomSheetController = widget.parentScaffoldKey.currentState.showBottomSheet(
                                //       //     (context) => DeliveryAddressBottomSheetWidget(scaffoldKey: widget.parentScaffoldKey),
                                //       //     shape: RoundedRectangleBorder(
                                //       //       borderRadius: new BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                //       //     ),
                                //       //   );
                                //       //   bottomSheetController.closed.then((value) {
                                //       //     _con.refreshHome();
                                //       //   });
                                //       // }
                                //     }
                                //   },
                                //   child: Container(
                                //     padding: const EdgeInsets.symmetric(
                                //         vertical: 6, horizontal: 10),
                                //     decoration: BoxDecoration(
                                //       borderRadius:
                                //           BorderRadius.all(Radius.circular(5)),
                                //       color: settingsRepo
                                //                   .deliveryAddress.value?.address ==
                                //               null
                                //           ? Theme.of(context)
                                //               .focusColor
                                //               .withOpacity(0.1)
                                //           : Theme.of(context).accentColor,
                                //     ),
                                //     child: Text(
                                //       S.of(context).delivery,
                                //       style: TextStyle(
                                //           color: settingsRepo.deliveryAddress.value
                                //                       ?.address ==
                                //                   null
                                //               ? Theme.of(context).hintColor
                                //               : Theme.of(context).primaryColor),
                                //     ),
                                //   ),
                                // ),

                                // InkWell(
                                //   onTap: () {
                                //     setState(() {
                                //       settingsRepo.deliveryAddress.value?.address =
                                //           null;
                                //     });
                                //   },
                                //   child: Container(
                                //     padding: const EdgeInsets.symmetric(
                                //         vertical: 6, horizontal: 10),
                                //     decoration: BoxDecoration(
                                //       borderRadius:
                                //           BorderRadius.all(Radius.circular(5)),
                                //       color: settingsRepo
                                //                   .deliveryAddress.value?.address !=
                                //               null
                                //           ? Theme.of(context)
                                //               .focusColor
                                //               .withOpacity(0.1)
                                //           : Theme.of(context).accentColor,
                                //     ),
                                //     child: Text(
                                //       S.of(context).pickup,
                                //       style: TextStyle(
                                //           color: settingsRepo.deliveryAddress.value
                                //                       ?.address !=
                                //                   null
                                //               ? Theme.of(context).hintColor
                                //               : Theme.of(context).primaryColor),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                            if (settingsRepo.deliveryAddress.value.address !=
                                null)
                              Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: Text(
                                  S.of(context).near_to +
                                      " " +
                                      (settingsRepo
                                          .deliveryAddress.value?.address),
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ),
                          ],
                        ),
                      );
                    case 'top_markets':
                      return CardsCarouselWidget(
                          marketsList: _con.topMarkets,
                          heroTag: 'home_top_markets');
                    case 'trending_week_heading':
                      if (_con.trendingProducts.isEmpty) {
                        return SizedBox(
                          height: 0,
                        );
                      }
                      return ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        title: Text(
                          S.of(context).trending_this_week,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        subtitle: Text(
                          S
                              .of(context)
                              .clickOnTheProductToGetMoreDetailsAboutIt,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      );
                    case 'trending_week':
                      if (_con.trendingProducts.isEmpty) {
                        return SizedBox(
                          height: 0,
                        );
                      }
                      return ProductsCarouselWidget(
                          productsList: _con.trendingProducts,
                          heroTag: 'home_product_carousel');
                    case 'categories_heading':
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 0),
                          title: Text(
                            S.of(context).product_categories,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      );
                    case 'categories':
                      return CategoriesCarouselWidget(
                        categories: _con.categories,
                      );

                    case 'popular_heading':
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 8, top: 12),
                        child: ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 0),
                          title: Text(
                            S.of(context).most_popular,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      );
                    case 'popular':
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: GridWidget(
                          marketsList: _con.popularMarkets,
                          heroTag: 'home_markets',
                        ),
                      );
                    case 'recent_reviews_heading':
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 20),
                          title: Text(
                            S.of(context).recent_reviews,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      );
                    case 'recent_reviews':
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child:
                            ReviewsListWidget(reviewsList: _con.recentReviews),
                      );
                    case 'new_goods_heading':
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 20),
                          title: Text(
                            // S.of(context).our_buyers_choise,
                            "Новинки",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      );
                    case 'new_goods_content':
                      return ProductListWidget(
                          productsList: _con.newInStockProducts,
                          heroTag: 'home_product_carousel');
                    case 'our_buyers_choise_heading':
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 20),
                          title: Text(
                            S.of(context).our_buyers_choise,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      );
                    case 'our_buyers_choise':
                      return ProductListWidget(
                          productsList: _con.trendingProducts,
                          heroTag: 'home_product_carousel');
                    case 'products_sets_heading':
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 20),
                          title: Text(
                            "Подборки для вас",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      );
                    case 'products_sets':
                      return ProductListWidget(
                          productsList: _con.trendingProducts,
                          heroTag: 'home_product_carousel');
                    default:
                      return SizedBox(height: 0);
                  }
                }),

                // <Widget>[
                // Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                //   Padding(
                //     padding: const EdgeInsets.only(left: 16, right: 16),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         LoadingItem(
                //           width: 150,
                //           height: 18,
                //         ),
                //         SizedBox(
                //           height: 6,
                //         ),
                //         LoadingItem(
                //           width: 230,
                //           height: 18,
                //         ),
                //         SizedBox(
                //           height: 8,
                //         ),
                //         LoadingItem(
                //           width: double.infinity,
                //           height: 48,
                //         ),
                //         SizedBox(
                //           height: 20,
                //         ),
                //         LoadingItem(
                //           width: 150,
                //           height: 18,
                //         ),
                //         SizedBox(
                //           height: 8,
                //         ),
                //       ],
                //     ),
                //   ),
                //   SizedBox(
                //     height: 82,
                //     child: ListView(
                //       scrollDirection: Axis.horizontal,
                //       children: [
                //         SizedBox(
                //           width: 16,
                //         ),
                //         LoadingItem(
                //           width: 74,
                //           height: 82,
                //         ),
                //         SizedBox(
                //           width: 8,
                //         ),
                //         LoadingItem(
                //           width: 74,
                //           height: 82,
                //         ),
                //         SizedBox(
                //           width: 8,
                //         ),
                //         LoadingItem(
                //           width: 74,
                //           height: 82,
                //         ),
                //         SizedBox(
                //           width: 8,
                //         ),
                //         LoadingItem(
                //           width: 74,
                //           height: 82,
                //         ),
                //         SizedBox(
                //           width: 8,
                //         ),
                //         LoadingItem(
                //           width: 74,
                //           height: 82,
                //         ),
                //         SizedBox(
                //           width: 16,
                //         ),
                //       ],
                //     ),
                //   ),
                //   Padding(
                //     padding: const EdgeInsets.only(left: 16, right: 16),
                //     child: Column(
                //       children: [
                //         SizedBox(
                //           height: 20,
                //         ),
                //         LoadingItem(
                //           width: 150,
                //           height: 18,
                //         ),
                //         SizedBox(
                //           height: 8,
                //         ),
                //       ],
                //     ),
                //   ),
                //   SizedBox(
                //     height: 82,
                //     child: ListView(
                //       scrollDirection: Axis.horizontal,
                //       children: [
                //         SizedBox(
                //           width: 16,
                //         ),
                //         LoadingItem(
                //           width: 188,
                //           height: double.infinity,
                //         ),
                //         SizedBox(
                //           width: 8,
                //         ),
                //         LoadingItem(
                //           width: 188,
                //           height: 205,
                //         ),
                //         SizedBox(
                //           width: 8,
                //         ),
                //         LoadingItem(
                //           width: 188,
                //           height: 205,
                //         ),
                //         SizedBox(
                //           width: 16,
                //         ),
                //       ],
                //     ),
                //   ),
                //   Padding(
                //     padding: const EdgeInsets.only(left: 16, right: 16),
                //     child: Column(
                //       children: [
                //         SizedBox(
                //           height: 20,
                //         ),
                //         LoadingItem(
                //           width: 150,
                //           height: 18,
                //         ),
                //         SizedBox(
                //           height: 8,
                //         ),
                //       ],
                //     ),
                //   ),
                //   SizedBox(
                //     height: 82,
                //     child: ListView(
                //       scrollDirection: Axis.horizontal,
                //       children: [
                //         SizedBox(
                //           width: 16,
                //         ),
                //         LoadingItem(
                //           width: 188,
                //           height: double.infinity,
                //         ),
                //         SizedBox(
                //           width: 8,
                //         ),
                //         LoadingItem(
                //           width: 188,
                //           height: 205,
                //         ),
                //         SizedBox(
                //           width: 8,
                //         ),
                //         LoadingItem(
                //           width: 188,
                //           height: 205,
                //         ),
                //         SizedBox(
                //           width: 16,
                //         ),
                //       ],
                //     ),
                //   ),
                //   Padding(
                //     padding: const EdgeInsets.only(left: 16, right: 16),
                //     child: Column(
                //       children: [
                //         SizedBox(
                //           height: 20,
                //         ),
                //         LoadingItem(
                //           width: 150,
                //           height: 18,
                //         ),
                //         SizedBox(
                //           height: 8,
                //         ),
                //       ],
                //     ),
                //   ),
                //   SizedBox(
                //     height: 82,
                //     child: ListView(
                //       scrollDirection: Axis.horizontal,
                //       children: [
                //         SizedBox(
                //           width: 16,
                //         ),
                //         LoadingItem(
                //           width: 188,
                //           height: double.infinity,
                //         ),
                //         SizedBox(
                //           width: 8,
                //         ),
                //         LoadingItem(
                //           width: 188,
                //           height: 205,
                //         ),
                //         SizedBox(
                //           width: 8,
                //         ),
                //         LoadingItem(
                //           width: 188,
                //           height: 205,
                //         ),
                //         SizedBox(
                //           width: 16,
                //         ),
                //       ],
                //     ),
                //   ),
                //   Padding(
                //     padding: const EdgeInsets.only(left: 16, right: 16),
                //     child: Column(
                //       children: [
                //         SizedBox(
                //           height: 20,
                //         ),
                //         LoadingItem(
                //           width: 150,
                //           height: 18,
                //         ),
                //         SizedBox(
                //           height: 8,
                //         ),
                //       ],
                //     ),
                //   ),
                //   SizedBox(
                //     height: 82,
                //     child: ListView(
                //       scrollDirection: Axis.horizontal,
                //       children: [
                //         SizedBox(
                //           width: 16,
                //         ),
                //         LoadingItem(
                //           width: 188,
                //           height: double.infinity,
                //         ),
                //         SizedBox(
                //           width: 8,
                //         ),
                //         LoadingItem(
                //           width: 188,
                //           height: 205,
                //         ),
                //         SizedBox(
                //           width: 8,
                //         ),
                //         LoadingItem(
                //           width: 188,
                //           height: 205,
                //         ),
                //         SizedBox(
                //           width: 16,
                //         ),
                //       ],
                //     ),
                //   ),
                // ]),
                // Padding(
                //   padding: const EdgeInsets.only(left: 16, right: 16),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         'Добро пожаловать!',
                //         style: Theme.of(context).textTheme.subtitle1,
                //       ),
                //       SizedBox(
                //         height: 6,
                //       ),
                //       Text(
                //         'Выбирайте цветы с душой и по любви',
                //         style: Theme.of(context)
                //             .textTheme
                //             .subtitle1
                //             .merge(TextStyle(fontWeight: FontWeight.w300)),
                //       )
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 8,
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 16, right: 16),
                //   child: Row(
                //     children: [
                //       Expanded(
                //           child: PropertyInput(
                //               hintText: 'Название товара',
                //               maxLines: 1,
                //               maxLength: 100,
                //               keyboardType: TextInputType.text,
                //               prefixIcon: SvgPicture.asset(
                //                 'assets/icons/search_200.svg',
                //                 height: 24,
                //                 width: 24,
                //                 fit: BoxFit.scaleDown,
                //               ))),
                //       SizedBox(
                //         width: 8,
                //       ),
                //       Container(
                //         width: 48,
                //         height: 48,
                //         child: SecondaryButton(
                //           small: true,
                //           btn_icon: SvgPicture.asset('assets/icons/tune.svg'),
                //           onPressed: () {},
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // // PropertyInput(
                // //   hintText: 'Логин или электронная почта',
                // //   maxLines: 1,
                // //   maxLength: 100,
                // //   keyboardType: TextInputType.text,
                // //   labelText: "Логин или электронная почта",
                // // ),
                // // SizedBox(
                // //   height: 20,
                // // ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 16, right: 16),
                //   child: Text(
                //     'Категории',
                //     style: Theme.of(context).textTheme.subtitle1,
                //   ),
                // ),
                // SizedBox(
                //   height: 8,
                // ),
                // SizedBox(
                //   height: 82,
                //   child: ListView(
                //     scrollDirection: Axis.horizontal,
                //     children: [
                //       SizedBox(
                //         width: 16,
                //       ),
                //       CustomCategory(
                //         price: "",
                //         enableBorder: false,
                //         free: false,
                //         title: 'Розы',
                //         categoryPhoto: Image(
                //             image: AssetImage('assets/icons/product.png')),
                //       ),
                //       SizedBox(
                //         width: 8,
                //       ),
                //       CustomCategory(
                //         price: "",
                //         enableBorder: false,
                //         free: false,
                //         title: 'Корзины с цветами',
                //         categoryPhoto: Image(
                //             image: AssetImage('assets/icons/product.png')),
                //       ),
                //       SizedBox(
                //         width: 8,
                //       ),
                //       CustomCategory(
                //         price: "",
                //         enableBorder: false,
                //         free: false,
                //         title: 'Цветы в ассортименте',
                //         categoryPhoto: Image(
                //             image: AssetImage('assets/icons/product.png')),
                //       ),
                //       SizedBox(
                //         width: 8,
                //       ),
                //       CustomCategory(
                //         price: "",
                //         free: false,
                //         enableBorder: false,
                //         title: 'Коробки с цветами',
                //         categoryPhoto: Image(
                //             image: AssetImage('assets/icons/product.png')),
                //       ),
                //       SizedBox(
                //         width: 8,
                //       ),
                //       CustomCategory(
                //         price: "",
                //         free: false,
                //         enableBorder: false,
                //         title: 'Подарки',
                //         categoryPhoto: Image(
                //             image: AssetImage('assets/icons/product.png')),
                //       ),
                //       SizedBox(
                //         width: 8,
                //       ),
                //       CustomCategory(
                //         price: "",
                //         enableBorder: false,
                //         free: false,
                //         title: 'Вазы',
                //         categoryPhoto: Image(
                //             image: AssetImage('assets/icons/product.png')),
                //       ),
                //       SizedBox(
                //         width: 16,
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 16, right: 16),
                //   child: Text(
                //     'Новинки',
                //     style: Theme.of(context).textTheme.subtitle1,
                //   ),
                // ),
                // SizedBox(
                //   height: 8,
                // ),
                // Container(
                //   height: 205,
                //   child: ListView(
                //     scrollDirection: Axis.horizontal,
                //     children: [
                //       SizedBox(
                //         width: 16,
                //       ),
                //       Product(
                //         image_width: 188,
                //         image_height: 100,
                //         info_height: 105,
                //         info_width: 188,
                //         product_name: 'Аромат зимы',
                //         product_category: 'Шляпная коробка',
                //         sale: true,
                //         new_product: false,
                //       ),
                //       SizedBox(
                //         width: 8,
                //       ),
                //       Product(
                //         image_width: 188,
                //         image_height: 100,
                //         info_height: 105,
                //         info_width: 188,
                //         product_name: 'Нежность прикосновений весны',
                //         product_category: 'Корзина с цветами',
                //         sale: false,
                //         new_product: true,
                //         review: true,
                //       ),
                //       SizedBox(
                //         width: 8,
                //       ),
                //       Product(
                //         image_width: 188,
                //         image_height: 100,
                //         info_height: 105,
                //         info_width: 188,
                //         product_name: 'Летняя улыбка',
                //         product_category: 'Шляпная коробка',
                //         sale: false,
                //         new_product: false,
                //         review: false,
                //       ),
                //       SizedBox(
                //         width: 16,
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 16, right: 16),
                //   child: Text(
                //     'Подборки для вас',
                //     style: Theme.of(context).textTheme.subtitle1,
                //   ),
                // ),
                // SizedBox(
                //   height: 8,
                // ),
                // SizedBox(
                //   height: 180,
                //   child: ListView(
                //     scrollDirection: Axis.horizontal,
                //     children: [
                //       SizedBox(
                //         width: 16,
                //       ),
                //       ProductSet(
                //         small: false,
                //         imgName: 'set',
                //         setName: 'К 1 сентября',
                //       ),
                //       SizedBox(
                //         width: 8,
                //       ),
                //       ProductSet(
                //         small: false,
                //         imgName: 'set',
                //         setName: 'Осенние букеты',
                //       ),
                //       SizedBox(
                //         width: 8,
                //       ),
                //       ProductSet(
                //         small: false,
                //         imgName: 'set',
                //         setName: 'Приятный сюрприз для родных',
                //       ),
                //       SizedBox(
                //         width: 8,
                //       ),
                //       ProductSet(
                //         small: false,
                //         imgName: 'set',
                //         setName: 'Сказочное рождество',
                //       ),
                //       SizedBox(
                //         width: 16,
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 16, right: 16),
                //   child: Text(
                //     'Наши покупатели выбирают',
                //     style: Theme.of(context).textTheme.subtitle1,
                //   ),
                // ),
                // SizedBox(
                //   height: 8,
                // ),
                // Container(
                //   height: 205,
                //   child: ListView(
                //     scrollDirection: Axis.horizontal,
                //     children: [
                //       SizedBox(
                //         width: 16,
                //       ),
                //       Product(
                //         image_width: 188,
                //         image_height: 100,
                //         info_height: 105,
                //         info_width: 188,
                //         product_name: 'Аромат зимы',
                //         product_category: 'Шляпная коробка',
                //         sale: true,
                //         new_product: false,
                //       ),
                //       SizedBox(
                //         width: 8,
                //       ),
                //       Product(
                //         image_width: 188,
                //         image_height: 100,
                //         info_height: 105,
                //         info_width: 188,
                //         product_name: 'Нежность прикосновений весны',
                //         product_category: 'Корзина с цветами',
                //         sale: false,
                //         new_product: true,
                //         review: true,
                //       ),
                //       SizedBox(
                //         width: 8,
                //       ),
                //       Product(
                //         image_width: 188,
                //         image_height: 100,
                //         info_height: 105,
                //         info_width: 188,
                //         product_name: 'Летняя улыбка',
                //         product_category: 'Шляпная коробка',
                //         sale: false,
                //         new_product: false,
                //         review: false,
                //       ),
                //       SizedBox(
                //         width: 16,
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 16, right: 16),
                //   child: Text(
                //     'Вы недавно заказывали',
                //     style: Theme.of(context).textTheme.subtitle1,
                //   ),
                // ),
                // SizedBox(
                //   height: 8,
                // ),
                // Container(
                //   height: 205,
                //   child: ListView(
                //     scrollDirection: Axis.horizontal,
                //     children: [
                //       SizedBox(
                //         width: 16,
                //       ),
                //       Product(
                //         image_width: 188,
                //         image_height: 100,
                //         info_height: 105,
                //         info_width: 188,
                //         product_name: 'Нежность прикосновений весны',
                //         product_category: 'Корзина с цветами',
                //         sale: false,
                //         new_product: true,
                //         review: true,
                //       ),
                //       SizedBox(
                //         width: 8,
                //       ),
                //       Product(
                //         image_width: 188,
                //         image_height: 100,
                //         info_height: 105,
                //         info_width: 188,
                //         product_name: 'Аромат зимы',
                //         product_category: 'Шляпная коробка',
                //         sale: true,
                //         new_product: false,
                //       ),
                //       SizedBox(
                //         width: 8,
                //       ),
                //       Product(
                //         image_width: 188,
                //         image_height: 100,
                //         info_height: 105,
                //         info_width: 188,
                //         product_name: 'Летняя улыбка',
                //         product_category: 'Шляпная коробка',
                //         sale: false,
                //         new_product: false,
                //         review: false,
                //       ),
                //       SizedBox(
                //         width: 16,
                //       ),
                //     ],
                //   ),
                // ),

                // ],
              ),
            )));
  }
}
