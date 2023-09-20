import 'dart:async';

import 'package:flutter/material.dart';
import 'package:markets/src/models/Product.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../helpers/helper.dart';
import '../models/cart.dart';
import '../models/coupon.dart';
import '../models/present.dart';
import '../repository/cart_repository.dart';
import '../repository/coupon_repository.dart';
import '../repository/settings_repository.dart';
import '../repository/user_repository.dart';
import '../repository/product_repository.dart' as prodRepo;

class CartController extends ControllerMVC {
  List<Cart> carts = <Cart>[];
  List<CartPresentModel> presents = <CartPresentModel>[];
  bool presentsLoading = false;
  List<Product> related = <Product>[];
  bool relatedLoading = false;
  bool cartsLoading = false;
  bool get getCartsLoading => cartsLoading;
  double taxAmount = 0.0;
  double deliveryFee = 0.0;
  int cartCount = 0;
  double subTotal = 0.0;
  double total = 0.0;
  // StreamController<double> totalStreamController =
  //     StreamController<double>.broadcast();
  // Stream<double> totalStream = totalStreamController.stream;
  StreamController<double> totalStreamController;
  Stream<double> totalStream;
  List<Cart> selectedForBouquet = [];

  @override
  void dispose() {
    totalStreamController.close();
    super.dispose();
  }

  GlobalKey<ScaffoldState> scaffoldKey;
  CartController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    this.totalStreamController = StreamController<double>.broadcast(
      onListen: () => totalStreamController.add(total),
    );
    this.totalStream = totalStreamController.stream;
  }

  List<Cart> get getSelectedForBouquet => selectedForBouquet;

  Future<void> getPresents() async {
    presentsLoading = true;
    setState(() {});
    presents = await prodRepo.getPresents();
    presentsLoading = false;
    setState(() {});
  }

  Future<void> getRelated() async {
    relatedLoading = true;
    setState(() {});
    related = await prodRepo.getRelated();
    relatedLoading = false;
    setState(() {});
  }

  void addToSelectedForBouquet(Cart item) {
    selectedForBouquet.add(item);
    // setState(() {});
  }

  void removeFromSelectedForBouquet(Cart item) {
    selectedForBouquet
        .removeWhere((element) => element.product.id == item.product.id);
    // setState(() {});
  }

  Future<bool> mergeCarts() async {
    for (Cart cart in carts) {
      if (selectedForBouquet.contains(cart)) {
        cart.merged = true;
      }
    }
    return true;
  }

  Future<bool> clearCartCont() async {
    final bool deleted = await clearCart();
    if (deleted) {
      setState(() {
        carts = [];
      });
    }
    return deleted;
  }

  Future<bool> isInFavorite(String productId) async {
    final ret = await prodRepo.isInFavs(productId);
    return ret;
  }

  void listenForCarts({String message}) async {
    carts.clear();
    cartsLoading = true;
    setState(() {});
    final Stream<Cart> stream = await getCart();
    stream.listen((Cart _cart) {
      if (!carts.contains(_cart)) {
        setState(() {
          coupon = _cart.product?.applyCoupon(coupon);
          carts.add(_cart);
        });
      }
    }, onError: (a) {
      print(a);
      ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
        content: Text(S.of(state.context).verify_your_internet_connection),
      ));
    }, onDone: () {
      if (carts.isNotEmpty) {
        calculateSubtotal();
      }
      if (message != null) {
        ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
      cartsLoading = false;
      onLoadingCartDone();
      setState(() {});
    });
  }

  void onLoadingCartDone() {}

  void listenForCartsCount({String message}) async {
    final Stream<int> stream = await getCartCount();
    stream.listen((int _count) {
      setState(() {
        this.cartCount = _count;
      });
    }, onError: (a) {
      print(a);
      ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
        content: Text(S.of(state.context).verify_your_internet_connection),
      ));
    });
  }

  Future<void> refreshCarts() async {
    setState(() {
      carts = [];
    });
    listenForCarts(message: S.of(state.context).carts_refreshed_successfuly);
  }

  void removeFromCart(Cart _cart) async {
    setState(() {
      this.carts.remove(_cart);
    });
    removeCart(_cart).then((value) {
      calculateSubtotal();
      ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
        content: Text(S
            .of(state.context)
            .the_product_was_removed_from_your_cart(_cart.product.name)),
      ));
    });
  }

  void calculateSubtotal() async {
    double cartPrice = 0;
    subTotal = 0;
    if (carts.isEmpty) {
      listenForCarts();
    }

    carts.forEach((cart) {
      // print('cart.product.price is ${cart.product.price}');
      cartPrice = cart.product.price;
      cart.options.forEach((element) {
        cartPrice += element.price;
      });
      cartPrice *= cart.quantity;
      subTotal += cartPrice;
    });
    // if (Helper.canDelivery(carts[0].product.market, carts: carts)) {
    //   deliveryFee = carts[0].product.market.deliveryFee;
    // }
    // taxAmount =
    //     (subTotal + deliveryFee) * carts[0].product.market.defaultTax / 100;

    setState(() {
      total = subTotal + taxAmount + deliveryFee;
      totalStreamController.add(total);
    });
  }

  void doApplyCoupon(String code, {String message}) async {
    coupon = new Coupon.fromJSON({"code": code, "valid": null});
    final Stream<Coupon> stream = await verifyCoupon(code);
    stream.listen((Coupon _coupon) async {
      coupon = _coupon;
    }, onError: (a) {
      print(a);
      ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
        content: Text(S.of(state.context).verify_your_internet_connection),
      ));
    }, onDone: () {
      listenForCarts();
    });
  }

  incrementQuantity(Cart cart) async {
    setState(() {
      totalStreamController.add(0.9);
    });
    if (cart.quantity <= 99) {
      ++cart.quantity;
      int index = carts.indexWhere((element) => element.id == cart.id);
      Cart updatedCart = await updateCart(cart);
      if (index != -1) {
        setState(() {
          carts[index].quantity = updatedCart.quantity;
        });
      }
      calculateSubtotal();
    }
  }

  decrementQuantity(Cart cart) async {
    setState(() {
      totalStreamController.add(0.9);
    });
    if (cart.quantity > 1) {
      --cart.quantity;
      int index = carts.indexWhere((element) => element.id == cart.id);
      Cart updatedCart = await updateCart(cart);
      if (index != -1) {
        setState(() {
          carts[index].quantity = updatedCart.quantity;
        });
      }
      calculateSubtotal();
    }
  }

  void goCheckout(BuildContext context, int deliveryOption) {
    print("user");
    print(currentUser.value);
    if (!currentUser.value.profileCompleted()) {
      // ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
      //   content: Text(S.of(state.context).completeYourProfileDetailsToContinue),
      //   action: SnackBarAction(
      //     label: S.of(state.context).settings,
      //     textColor: Theme.of(state.context).accentColor,
      //     onPressed: () {
      //       Navigator.of(state.context).pushNamed('/Pages', arguments: 4);
      //     },
      //   ),
      // ));
      List<dynamic> _initiator = [deliveryOption, carts[0].product.market.id];
      Navigator.of(state.context)
          .pushNamed('/DeliveryPickup', arguments: _initiator);
    } else {
      if (carts[0].product.market.closed) {
        ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
          content: Text(S.of(state.context).this_market_is_closed_),
        ));
      } else {
        Navigator.of(state.context).pushNamed('/DeliveryPickup');
      }
    }
  }

  Color getCouponIconColor() {
    if (coupon?.valid == true) {
      return Colors.green;
    } else if (coupon?.valid == false) {
      return Colors.redAccent;
    }
    return Theme.of(state.context).focusColor.withOpacity(0.7);
  }
}
