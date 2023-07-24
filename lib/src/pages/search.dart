import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:google_map_location_picker/generated/l10n.dart';
import 'package:markets/src/components/AlertDialogWidget.dart';
import 'package:markets/src/components/DeleteLabelWidget.dart';
import 'package:markets/src/components/TextInputWidget.dart';
import 'package:markets/src/helpers/colors.dart';
import 'package:markets/src/models/Product.dart';
import 'package:markets/src/models/route_argument.dart';
import 'package:markets/src/components/SearchItemWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../controllers/common_controller.dart';
import '../repository/settings_repository.dart' as settingsRepo;

class Search extends StatefulWidget {
  const Search({Key key, this.routeArgument}) : super(key: key);
  final RouteArgument routeArgument;

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends StateMVC<Search> {
  CommonController _con;

  _SearchState() : super(CommonController()) {
    _con = controller;
  }

  Timer _searchTimer;

  List<Product> _popular;
  List<Product> _recentLocal;
  List<Product> _foundList;
  bool _isSearching = false;
  String _searchQuery = '';
  TextEditingController _searchController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _foundList = _con.foundProductsByQuery;
      _popular = _con.trendingProducts;
      _recentLocal = _con.recentlySearchedProducts;
      _isSearching = _con.isSearching;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primary_50,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            if (widget.routeArgument != null) {
              Navigator.of(context).pushReplacementNamed(
                  widget.routeArgument.param,
                  arguments: RouteArgument(id: widget.routeArgument.id));
            } else {
              Navigator.of(context)
                  .pushReplacementNamed('/Pages', arguments: 0);
            }
          },
          icon: SvgPicture.asset(
            'assets/icons/navigate_before_200.svg',
            color: primary_700,
          ),
        ),
        title: ValueListenableBuilder(
          valueListenable: settingsRepo.setting,
          builder: (context, value, child) {
            return Text(
              value.appName,
              style: Theme.of(context).textTheme.headline2,
            );
          },
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              PropertyInput(
                  textController: _searchController,
                  personal: false,
                  small: false,
                  hintText: 'Название товара',
                  maxLines: 1,
                  maxLength: 100,
                  keyboardType: TextInputType.text,
                  onChange: (String input) {
                    setState(() {
                      if (_searchQuery.isEmpty) {
                        _searchQuery = _searchController.text;
                      }
                      if (_searchController.text.isEmpty) {
                        _searchQuery = '';
                      }
                      if (_searchTimer != null && _searchTimer.isActive) {
                        _searchTimer.cancel();
                      }
                      _con.isSearching = true;
                      _searchTimer = Timer(Duration(seconds: 3), () {
                        _con.letsSearch(_searchController.text);
                      });
                    });
                  },
                  suffixIcon: SvgPicture.asset(
                    'assets/icons/close_24.svg',
                    height: 24,
                    width: 24,
                    fit: BoxFit.scaleDown,
                  ),
                  prefixIcon: SvgPicture.asset(
                    'assets/icons/search_200.svg',
                    height: 24,
                    width: 24,
                    fit: BoxFit.scaleDown,
                  )),
              SizedBox(
                height: 20,
              ),
              _searchQuery.isEmpty
                  // ? Row(
                  //     children: [
                  //       Expanded(
                  //         flex: 2,
                  //         child: Text(
                  //           'Недавние',
                  //           style: Theme.of(context).textTheme.subtitle1,
                  //         ),
                  //       ),
                  //       GestureDetector(
                  //           onTap: () => showDialog(
                  //               context: context,
                  //               builder: (BuildContext context) =>
                  //                   AlertDialogWidget(
                  //                     title: "Очистить историю поиска?",
                  //                     onYes: "Очистить",
                  //                   )),
                  //           child: DeleteLabel(
                  //               small: true, title: "Очистить историю поиска"))
                  //     ],
                  //   )
                  ? Container()
                  : Row(children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Найдено',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      )
                    ]),
              // SizedBox(
              //   height: 8,
              // ),
              _searchQuery.isEmpty
                  ?
                  // ListView(
                  //     scrollDirection: Axis.vertical,
                  //     shrinkWrap: true,
                  //     children: [
                  //       SearchItem(
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
                  //         newPrice: "3930",
                  //       ),
                  //       Divider(
                  //         color: expanded_light_neutral_100,
                  //         height: 1.5,
                  //       ),
                  //       SearchItem(
                  //         imgSize: 50,
                  //         cardHeight: 62,
                  //         bottomLeft: 5.0,
                  //         bottomRight: 5.0,
                  //         topRight: 0.0,
                  //         topLeft: 0.0,
                  //         title: "Осенние гвоздики",
                  //         category: "Букет",
                  //         sale: false,
                  //         price: "5000",
                  //         newPrice: "3930",
                  //       ),
                  //     ],
                  //   )
                  Container(
                      height: 55,
                      child: Center(
                          child: Text('Начните поиск...',
                              style: Theme.of(context).textTheme.subtitle1)),
                    )
                  // Container()
                  : !_con.isSearching
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: _con.foundProductsByQuery.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                InkWell(
                                  child: SearchItem(
                                    imgSize: 68,
                                    cardHeight: 80,
                                    topLeft: 5.0,
                                    topRight: 5.0,
                                    bottomLeft: 0.0,
                                    bottomRight: 0.0,
                                    imageUrl: _con
                                        .foundProductsByQuery[index].imageurl,
                                    title: _con.foundProductsByQuery[index].name
                                        .toString(),
                                    category: _con.foundProductsByQuery[index]
                                        .category.name
                                        .toString(),
                                    sale: _con.foundProductsByQuery[index]
                                            .discountPrice !=
                                        0.0,
                                    price: _con
                                        .foundProductsByQuery[index].price
                                        .toInt()
                                        .toString(),
                                    newPrice: _con.foundProductsByQuery[index]
                                        .discountPrice
                                        .toInt()
                                        .toString(),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pushNamed('/Product',
                                        arguments: RouteArgument(
                                            id: _con
                                                .foundProductsByQuery[index].id,
                                            heroTag: 'home_product_carousel'));
                                  },
                                ),
                              ],
                            );
                          })
                      : Center(child: CircularProgressIndicator()),
              SizedBox(
                height: 20,
              ),
              Text(
                'Популярные запросы',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(
                height: 8,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _popular.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        child: SearchItem(
                          imgSize: 68,
                          cardHeight: 80,
                          topLeft: 5.0,
                          topRight: 5.0,
                          bottomLeft: 0.0,
                          bottomRight: 0.0,
                          imageUrl: _popular[index].imageurl,
                          title: _popular[index].name.toString(),
                          category: _popular[index].category.name.toString(),
                          sale: _popular[index].discountPrice != 0.0,
                          price: _popular[index].price.toInt().toString(),
                          newPrice:
                              _popular[index].discountPrice.toInt().toString(),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed('/Product',
                              arguments: RouteArgument(
                                  id: _popular[index].id,
                                  heroTag: 'home_product_carousel'));
                        },
                      ),
                      Divider(
                        color: expanded_light_neutral_100,
                        height: 1.5,
                      ),
                    ],
                  );
                },
              ),
              // ListView(
              //   scrollDirection: Axis.vertical,
              //   shrinkWrap: true,
              //   children: [
              //     SearchItem(
              //       imgSize: 68,
              //       cardHeight: 80,
              //       topLeft: 5.0,
              //       topRight: 5.0,
              //       bottomLeft: 0.0,
              //       bottomRight: 0.0,
              //       title: "Поцелуй лета",
              //       category: "Авторский букет",
              //       sale: true,
              //       price: "5000",
              //       newPrice: "3930",
              //     ),
              //     Divider(
              //       color: expanded_light_neutral_100,
              //       height: 1.5,
              //     ),
              //     SearchItem(
              //       imgSize: 68,
              //       cardHeight: 80,
              //       topLeft: 0.0,
              //       topRight: 0.0,
              //       bottomLeft: 0.0,
              //       bottomRight: 0.0,
              //       title: "Поцелуй лета",
              //       category: "Композиция в крафтовой сумочке",
              //       sale: true,
              //       price: "5000",
              //       newPrice: "3930",
              //     ),
              //     Divider(
              //       color: expanded_light_neutral_100,
              //       height: 1.5,
              //     ),
              //     SearchItem(
              //       imgSize: 68,
              //       cardHeight: 80,
              //       bottomLeft: 5.0,
              //       bottomRight: 5.0,
              //       topRight: 0.0,
              //       topLeft: 0.0,
              //       title: "Осенние гвоздики",
              //       category: "Букет",
              //       sale: false,
              //       price: "5000",
              //       newPrice: "3930",
              //     ),
              //   ],
              // ),
              // ListView(
              //   scrollDirection: Axis.vertical,
              //   shrinkWrap: true,
              //   children: [
              //     SearchItem(
              //       imgSize: 68,
              //       cardHeight: 80,
              //       topLeft: 5.0,
              //       topRight: 5.0,
              //       bottomLeft: 0.0,
              //       bottomRight: 0.0,
              //       title: "Поцелуй лета",
              //       category: "Авторский букет",
              //       sale: true,
              //       price: "5000",
              //       newPrice: "3930",
              //     ),
              //     Divider(
              //       color: expanded_light_neutral_100,
              //       height: 1.5,
              //     ),
              //     SearchItem(
              //       imgSize: 68,
              //       cardHeight: 80,
              //       topLeft: 0.0,
              //       topRight: 0.0,
              //       bottomLeft: 0.0,
              //       bottomRight: 0.0,
              //       title: "Поцелуй лета",
              //       category: "Композиция в крафтовой сумочке",
              //       sale: true,
              //       price: "5000",
              //       newPrice: "3930",
              //     ),
              //     Divider(
              //       color: expanded_light_neutral_100,
              //       height: 1.5,
              //     ),
              //     SearchItem(
              //       imgSize: 68,
              //       cardHeight: 80,
              //       bottomLeft: 5.0,
              //       bottomRight: 5.0,
              //       topRight: 0.0,
              //       topLeft: 0.0,
              //       title: "Осенние гвоздики",
              //       category: "Букет",
              //       sale: false,
              //       price: "5000",
              //       newPrice: "3930",
              //     ),
              //   ],
              // )
            ],
          ),
        ],
      ),
    );
  }
}
