import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/components/FilterFormWidget.dart';
import 'package:markets/src/components/ModalBottomSheetWidget.dart';
import 'package:markets/src/components/ProductListItemWidget.dart';
import 'package:markets/src/components/SecondaryButtonWidget.dart';
import 'package:markets/src/components/SortFormWidget.dart';
import 'package:markets/src/components/TextInputWidget.dart';
import 'package:markets/src/helpers/colors.dart';
import 'package:markets/src/pages/pages.dart';
import 'package:markets/src/repository/settings_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/category_controller.dart';
import '../elements/AddToCartAlertDialog.dart';
import '../elements/CircularLoadingWidget.dart';
import '../elements/DrawerWidget.dart';
import '../elements/FilterWidget.dart';
import '../elements/ProductGridItemWidget.dart';
import '../elements/SearchBarWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../models/route_argument.dart';
import '../repository/user_repository.dart';

class CategoryWidget extends StatefulWidget {
  final RouteArgument routeArgument;
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  CategoryWidget({Key key, this.routeArgument, this.parentScaffoldKey})
      : super(key: key);

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends StateMVC<CategoryWidget> {
  // TODO add layout in configuration file
  String layout = 'grid';

  CategoryController _con;

  _CategoryWidgetState() : super(CategoryController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForProductsByCategory(id: widget.routeArgument.id);
    _con.listenForCategory(id: widget.routeArgument.id);
    _con.listenForCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      drawer: DrawerWidget(),
      // endDrawer: FilterWidget(onFilter: (filter) {
      //   Navigator.of(context).pushReplacementNamed('/Pages', arguments:2 );
      // }),
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
          onPressed: () => _con.scaffoldKey?.currentState?.openDrawer(),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: primary_50,
        elevation: 0,
        centerTitle: true,
        title: Text(
          _con.category?.name ?? '',
          style: Theme.of(context).textTheme.headline2,
        ),
        // actions: <Widget>[
        //   _con.loadCart
        //       ? SizedBox(
        //         width: 24,
        //         child: CircularProgressIndicator(
        //           strokeWidth: 2.5,
        //         ),
        //       )
        //       : ShoppingCartButtonWidget(iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
        // ],
      ),
      body: RefreshIndicator(
        backgroundColor: background,
        onRefresh: _con.refreshCategory,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: PropertyInput(
                        textController: TextEditingController(),
                        personal: false,
                        small: false,
                        hintText: 'Название товара',
                        maxLines: 1,
                        maxLength: 100,
                        keyboardType: TextInputType.text,
                        prefixIcon: SvgPicture.asset(
                          'assets/icons/search_200.svg',
                          height: 24,
                          width: 24,
                          fit: BoxFit.scaleDown,
                        )),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16),
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       Expanded(
                  //         child: SecondaryButton(
                  //           small: false,
                  //           text: S.of(context).sort,
                  //           btn_icon: SvgPicture.asset(
                  //             'assets/icons/sort.svg',
                  //             color: primary_700,
                  //           ),
                  //           onPressed: () => showModalBottomSheet(
                  //               isScrollControlled: true,
                  //               context: context,
                  //               backgroundColor: Colors.transparent,
                  //               builder: (_) {
                  //                 return ModalBottomSheetWidget(
                  //                   initialChildSize: 0.60,
                  //                   // minChildSize: 0.95,
                  //                   maxChildSize: null,
                  //                   widget: SortFormWidget(),
                  //                   title: S.of(context).sort,
                  //                   showAll: false,
                  //                   reset: false,
                  //                 );
                  //               }),
                  //         ),
                  //       ),
                  //       SizedBox(width: 8),
                  //       Expanded(
                  //         child: SecondaryButton(
                  //           small: false,
                  //           text: S.of(context).filter,
                  //           btn_icon: SvgPicture.asset('assets/icons/tune.svg',
                  //               color: primary_700),
                  //           onPressed: () => showModalBottomSheet(
                  //               isScrollControlled: true,
                  //               context: context,
                  //               backgroundColor: Colors.transparent,
                  //               builder: (_) {
                  //                 return ModalBottomSheetWidget(
                  //                   reset: true,
                  //                   initialChildSize: 0.95,
                  //                   maxChildSize: null,
                  //                   widget: FilterFormWidget(),
                  //                   title: S.of(context).filter,
                  //                   showAll: false,
                  //                 );
                  //               }),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 20, right: 10),
              //   child: ListTile(
              //     contentPadding: EdgeInsets.symmetric(vertical: 0),
              //
              //     title: Text(
              //       _con.category?.name ?? '',
              //       maxLines: 1,
              //       overflow: TextOverflow.ellipsis,
              //       style: Theme.of(context).textTheme.headline4,
              //     ),
              //     trailing: Row(
              //       mainAxisSize: MainAxisSize.min,
              //       children: <Widget>[
              //         IconButton(
              //           onPressed: () {
              //             setState(() {
              //               this.layout = 'list';
              //             });
              //           },
              //           icon: Icon(
              //             Icons.format_list_bulleted,
              //             color: this.layout == 'list' ? Theme.of(context).accentColor : Theme.of(context).focusColor,
              //           ),
              //         ),
              //         IconButton(
              //           onPressed: () {
              //             setState(() {
              //               this.layout = 'grid';
              //             });
              //           },
              //           icon: Icon(
              //             Icons.apps,
              //             color: this.layout == 'grid' ? Theme.of(context).accentColor : Theme.of(context).focusColor,
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),

              _con.products.isEmpty
                  ? CircularLoadingWidget(height: 500)
                  : ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                      itemCount: _con.products.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ProductListItemWidget(
                            onPressed: () {
                              if (currentUser.value.apiToken == null) {
                                Navigator.of(context).pushNamed('/Login');
                              } else {
                                if (_con.isSameMarkets(
                                    _con.products.elementAt(index))) {
                                  _con.addToCart(
                                      _con.products.elementAt(index));
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      // return object of type Dialog
                                      return AddToCartAlertDialogWidget(
                                          oldProduct:
                                              _con.carts.elementAt(0)?.product,
                                          newProduct:
                                              _con.products.elementAt(index),
                                          onPressed: (product, {reset: true}) {
                                            return _con.addToCart(
                                                _con.products.elementAt(index),
                                                reset: true);
                                          });
                                    },
                                  );
                                }
                              }
                            },
                            buttonText: false,
                            horizontal: true,
                            sale: true,
                            new_product: false,
                            review: false,
                            heroTag: 'favorites_list',
                            product: _con.products.elementAt(index),
                            product_category: _con.category.name,
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 8,
                        );
                      },
                    ),
              // _con.products.isEmpty
              //     ? CircularLoadingWidget(height: 500)
              //     : Offstage(
              //         offstage: this.layout != 'grid',
              //         child: GridView.count(
              //           scrollDirection: Axis.vertical,
              //           shrinkWrap: true,
              //           primary: false,
              //           crossAxisSpacing: 10,
              //           mainAxisSpacing: 20,
              //           padding: EdgeInsets.symmetric(horizontal: 20),
              //           // Create a grid with 2 columns. If you change the scrollDirection to
              //           // horizontal, this produces 2 rows.
              //           crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 4,
              //           // Generate 100 widgets that display their index in the List.
              //           children: List.generate(_con.products.length, (index) {
              //             return ProductGridItemWidget(
              //                 heroTag: 'category_grid',
              //                 product: _con.products.elementAt(index),
              //                 onPressed: () {
              //                   if (currentUser.value.apiToken == null) {
              //                     Navigator.of(context).pushNamed('/Login');
              //                   } else {
              //                     if (_con.isSameMarkets(_con.products.elementAt(index))) {
              //                       _con.addToCart(_con.products.elementAt(index));
              //                     } else {
              //                       showDialog(
              //                         context: context,
              //                         builder: (BuildContext context) {
              //                           // return object of type Dialog
              //                           return AddToCartAlertDialogWidget(
              //                               oldProduct: _con.carts.elementAt(0)?.product,
              //                               newProduct: _con.products.elementAt(index),
              //                               onPressed: (product, {reset: true}) {
              //                                 return _con.addToCart(_con.products.elementAt(index), reset: true);
              //                               });
              //                         },
              //                       );
              //                     }
              //                   }
              //                 });
              //           }),
              //         ),
              //       )
            ],
          ),
        ),
      ),
    );
  }
}
