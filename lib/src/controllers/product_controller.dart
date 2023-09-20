import 'package:flutter/material.dart';
import 'package:markets/src/models/present.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../models/cart.dart';
import '../models/favorite.dart';
import '../models/option.dart';
import '../models/Product.dart';
import '../repository/cart_repository.dart';
import '../repository/product_repository.dart';
import '../repository/user_repository.dart';
import '../repository/product_repository.dart' as prodRepo;

class ProductController extends ControllerMVC {
  Product product;
  double quantity = 1;
  double total = 0;
  List<CartPresentModel> presents = <CartPresentModel>[];
  bool presentsLoading = false;
  List<Cart> carts = [];
  Favorite favorite;
  bool favoriteBool;
  bool loadCart = false;
  int current = 0;
  GlobalKey<ScaffoldState> scaffoldKey;

  ProductController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    // listenForCart();
  }

  Future<void> getPresents() async {
    presentsLoading = true;
    setState(() {});
    presents = await prodRepo.getPresents();
    presentsLoading = false;
    setState(() {});
  }

  void listenForProduct({String productId, String message}) async {
    final Stream<Product> stream = await getProduct(productId);
    stream.listen((Product _product) {
      setState(() => product = _product);
    }, onError: (a) {
      ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
        content: Text(S.of(state.context).verify_your_internet_connection),
      ));
    }, onDone: () {
      calculateTotal();
      if (message != null) {
        ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }

  void listenForFavorite({String productId}) async {
    final Stream<Favorite> stream = await isFavoriteProduct(productId);
    stream.listen((Favorite _favorite) {
      setState(() => favorite = _favorite);
    }, onError: (a) {
      print(a);
    });
  }

  Future<bool> isInFavorite(String productId) async {
    final ret = await isInFavs(productId);
    setState(() => favoriteBool = ret);
    return ret;
  }

  Future<bool> isInCart(String productId) async {
    bool ret = false;
    for (final _cart in this.carts) {
      if (_cart.product.id == productId) {
        ret = true;
      }
    }
    print('is in cart ${ret}');
    return ret;
  }

  void listenForCart() async {
    final Stream<Cart> stream = await getCart();
    stream.listen((Cart _cart) {
      carts.add(_cart);
      // print(carts.length);
    });
  }

  bool isSameMarkets(Product product) {
    if (carts.isNotEmpty) {
      return carts[0].product?.market?.id == product.market?.id;
    }
    return true;
  }

  // bool checkAuthorization() {
  //   if (currentUser.value.id == null) {
  //     return false;
  //   }
  //   return true;
  // }

  void addToCart(Product product, {bool reset = false, int quantity}) async {
    setState(() {
      this.loadCart = true;
    });

    // bool _authorized = checkAuthorization();

    // if (!_authorized) {
    //   ScaffoldMessenger.of(scaffoldKey.currentContext).showSnackBar(SnackBar(
    //     content: Text('Авторизуйтесь.'),
    //   ));
    // }

    double finalQuantity =
        quantity != null ? quantity.toDouble() : this.quantity;
    var _newCart = new Cart();
    _newCart.quantity = finalQuantity;
    _newCart.product = product;
    _newCart.options =
        product.options.where((element) => element.checked).toList();

    // if product exist in the cart then increment quantity
    var _oldCart = isExistInCart(_newCart);
    if (_oldCart != null) {
      _oldCart.quantity += this.quantity;
      updateCart(_oldCart).then((value) {
        setState(() {
          this.loadCart = false;
        });
      }).whenComplete(() {
        // ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
        //   content: Text(S.of(state.context).this_product_was_added_to_cart),
        // ));
      });
    } else {
      // the product doesnt exist in the cart add new one
      addCart(_newCart, reset).then((value) {
        setState(() {
          this.loadCart = false;
          this.carts.add(value);
        });
        print(this.carts.length);
      }).whenComplete(() {
        // ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
        //   content: Text(S.of(state.context).this_product_was_added_to_cart),
        // ));
      });
    }
  }

  Cart isExistInCart(Cart _cart) {
    return carts.firstWhere((Cart oldCart) => _cart.isSame(oldCart),
        orElse: () => null);
  }

  void addToFavorite(Product product) async {
    // var _favorite = new Favorite();
    // _favorite.product = product;
    // _favorite.options = product.options.where((Option _option) {
    //   return _option.checked;
    // }).toList();
    // addFavorite(_favorite).then((value) {
    //   setState(() {
    //     this.favorite = value;
    //   });
    //   ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
    //     content: Text(S.of(state.context).thisProductWasAddedToFavorite),
    //   ));
    // });

    addFavorite(product).then((value) {
      setState(() {
        this.favoriteBool = value;
      });
      // ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
      //   content: Text(S.of(state.context).thisProductWasAddedToFavorite),
      // ));
    });
  }

  void removeFromFavorite(String productId) async {
    removeFavorite(productId).then((value) {
      setState(() {
        this.favoriteBool = value;
      });
      // ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
      //   content: Text(S.of(state.context).thisProductWasRemovedFromFavorites),
      // ));
    });
  }

  Future<void> refreshProduct() async {
    var _id = product.id;
    product = new Product();
    listenForFavorite(productId: _id);
    listenForProduct(
        productId: _id,
        message: S.of(state.context).productRefreshedSuccessfuly);
  }

  void calculateTotal() {
    total = product?.price ?? 0;
    product?.options?.forEach((option) {
      total += option.checked ? option.price : 0;
    });
    total *= quantity;
    setState(() {});
  }

  incrementQuantity() {
    if (this.quantity <= 99) {
      ++this.quantity;
      calculateTotal();
    }
  }

  decrementQuantity() {
    if (this.quantity > 1) {
      --this.quantity;
      calculateTotal();
    }
  }
}
