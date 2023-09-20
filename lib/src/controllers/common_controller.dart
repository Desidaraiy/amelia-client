import 'package:flutter/cupertino.dart';
import 'package:markets/src/repository/field_repository.dart';
import '../models/field.dart';
import '../models/filter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import '../models/cart.dart';
import '../models/category.dart';
import '../models/market.dart';
import '../models/Product.dart';
import '../models/review.dart';
import '../models/slide.dart';
import '../repository/category_repository.dart';
import '../repository/market_repository.dart';
import '../repository/product_repository.dart';
import '../repository/settings_repository.dart';
import '../repository/slider_repository.dart';

class CommonController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  List<Field> fields = [];
  Filter filter;
  Cart cart;
  bool isSearching = false;
  List<Category> categories = <Category>[];
  List<Slide> slides = <Slide>[];
  List<Market> topMarkets = <Market>[];
  List<Market> popularMarkets = <Market>[];
  List<Review> recentReviews = <Review>[];
  List<Product> trendingProducts = <Product>[];
  List<Product> newInStockProducts = <Product>[];
  List<Product> recentlySearchedProducts = <Product>[];
  List<Product> popularSearchedProducts = <Product>[];
  List<Product> foundProductsByQuery = <Product>[];
  List<Product> productSets = <Product>[];

  // Future<void> main() async{
  //   await listenForTopMarkets();
  //   await listenForSlides();
  //   await listenForTrendingProducts();
  //   await listenForCategories();
  //   await listenForPopularMarkets();
  //   await listenForRecentReviews();
  // }

  CommonController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForFilter().whenComplete(() {
      listenForFields();
    });
    listenForTopMarkets();
    listenForSlides();
    listenForTrendingProducts();
    listenForCategories();
    listenForPopularMarkets();
    listenForRecentReviews();
    listenForNewInStockProducts();
    listenForPopularSearchedProducts();
    listenForProductSets();
  }

  void reInitCon() {
    listenForFilter().whenComplete(() {
      listenForFields();
    });
    listenForTopMarkets();
    listenForSlides();
    listenForTrendingProducts();
    listenForCategories();
    listenForPopularMarkets();
    listenForRecentReviews();
    listenForNewInStockProducts();
    // listenForRecentlySearchedProducts();
    listenForPopularSearchedProducts();
    listenForProductSets();
  }

  // !завод поиска

  void letsSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        foundProductsByQuery = [];
      });
    } else {
      listenForSearchPageProducts(query);
    }
  }

  // Future<void> listenForSearchPageProducts(String query) async {
  //   final Stream<Product> stream = await getProductsByQuery(query);
  //   stream.listen((Product _product) {
  //     setState(() {
  //       if (foundProductsByQuery.isNotEmpty) {
  //         if (foundProductsByQuery.last.name != _product.name) {
  //           foundProductsByQuery.add(_product);
  //         }
  //       } else {
  //         foundProductsByQuery.add(_product);
  //       }
  //     });
  //   }, onError: (a) {
  //     print(a);
  //   }, onDone: () {});
  // }

  Future<void> listenForSearchPageProducts(String query) async {
    setState(() {
      foundProductsByQuery = [];
      isSearching = true;
    });
    try {
      List<Product> products = await getProductsByQuery(query);
      setState(() {
        foundProductsByQuery = products;
        isSearching = false;
      });
    } catch (e) {
      print(e);
    }
  }

  // !!!

  Future<void> listenForPopularSearchedProducts() async {}

  Future<void> listenForSlides() async {
    final Stream<Slide> stream = await getSlides();
    stream.listen((Slide _slide) {
      setState(() => slides.add(_slide));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  Future<void> listenForCategories() async {
    final Stream<Category> stream = await getCategories();
    stream.listen((Category _category) {
      setState(() => categories.add(_category));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  Future<void> listenForTopMarkets() async {
    final Stream<Market> stream =
        await getNearMarkets(deliveryAddress.value, deliveryAddress.value);
    stream.listen((Market _market) {
      setState(() => topMarkets.add(_market));
    }, onError: (a) {}, onDone: () {});
  }

  Future<void> listenForPopularMarkets() async {
    final Stream<Market> stream =
        await getPopularMarkets(deliveryAddress.value);
    stream.listen((Market _market) {
      setState(() => popularMarkets.add(_market));
    }, onError: (a) {}, onDone: () {});
  }

  Future<void> listenForRecentReviews() async {
    final Stream<Review> stream = await getRecentReviews();
    stream.listen((Review _review) {
      setState(() => recentReviews.add(_review));
    }, onError: (a) {}, onDone: () {});
  }

  // Future<void> listenForTrendingProducts() async {
  //   final Stream<Product> stream =
  //       await getTrendingProducts(deliveryAddress.value);
  //   stream.listen((Product _product) {
  //     setState(() => trendingProducts.add(_product));
  //   }, onError: (a) {
  //     print(a);
  //   }, onDone: () {});
  // }

  Future<void> listenForTrendingProducts() async {
    final Stream<Product> stream = await getTrendingProducts();
    stream.listen((Product _product) {
      setState(() => trendingProducts.add(_product));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  Future<void> listenForProductSets() async {
    final Stream<Product> stream = await getSetsOfProducts();
    stream.listen((Product _product) {
      setState(() => productSets.add(_product));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  Future<void> listenForNewInStockProducts() async {
    final Stream<Product> stream = await getNewInStockProducts();
    stream.listen((Product _product) {
      setState(() => newInStockProducts.add(_product));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  // void requestForCurrentLocation(BuildContext context) {
  //   OverlayEntry loader = Helper.overlayLoader(state.context);
  //   Overlay.of(state.context).insert(loader);
  //   setCurrentLocation().then((_address) async {
  //     deliveryAddress.value = _address;
  //     await refreshHome();
  //     loader.remove();
  //   }).catchError((e) {
  //     loader.remove();
  //   });
  // }

  Future<void> refreshHome() async {
    setState(() {
      slides = <Slide>[];
      categories = <Category>[];
      topMarkets = <Market>[];
      popularMarkets = <Market>[];
      recentReviews = <Review>[];
      trendingProducts = <Product>[];
    });
    await listenForSlides();
    await listenForTopMarkets();
    await listenForTrendingProducts();
    await listenForCategories();
    await listenForPopularMarkets();
    await listenForRecentReviews();
  }

  Future<void> listenForFilter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      filter = Filter.fromJSON(json.decode(prefs.getString('filter') ?? '{}'));
    });
  }

  Future<void> saveFilter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    filter.fields = this.fields.where((_f) {
      print(filter.delivery);
      return _f.selected;
    }).toList();
    prefs.setString('filter', json.encode(filter.toMap()));
  }

  void listenForFields({String message}) async {
    fields.add(new Field.fromJSON(
        {'id': '0', 'name': S.of(state.context).all, 'selected': true}));
    final Stream<Field> stream = await getFields();
    stream.listen((Field _field) {
      setState(() {
        if (filter.fields.contains(_field)) {
          _field.selected = true;
          fields.elementAt(0).selected = false;
        }
        fields.add(_field);
      });
    }, onError: (a) {
      print(a);
      ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
        content: Text(S.of(state.context).verify_your_internet_connection),
      ));
    }, onDone: () {
      if (message != null) {
        ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }

  Future<void> refreshFields() async {
    fields.clear();
    listenForFields(
        message: S.of(state.context).addresses_refreshed_successfuly);
  }

  void clearFilter() {
    setState(() {
      filter.open = false;
      filter.delivery = false;
      resetFields();
    });
  }

  void resetFields() {
    filter.fields = [];
    fields.forEach((Field _f) {
      _f.selected = false;
    });
    fields.elementAt(0).selected = true;
  }

  void onChangeFieldsFilter(int index) {
    if (index == 0) {
      // all
      setState(() {
        resetFields();
      });
    } else {
      setState(() {
        fields.elementAt(index).selected = !fields.elementAt(index).selected;
        fields.elementAt(0).selected = false;
      });
    }
  }
}
