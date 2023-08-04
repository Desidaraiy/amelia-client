import 'dart:io';

import 'package:flutter/material.dart';
import 'package:markets/src/models/cart.dart';
// import '../models/address.dart';
import 'package:markets/src/models/order.dart';
import 'package:sberbank_acquiring/sberbank_acquiring_ui.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../generated/l10n.dart';
import '../models/address.dart' as model;
import '../models/payment_method.dart';
import '../repository/settings_repository.dart' as settingRepo;
import '../repository/user_repository.dart' as userRepo;
import '../repository/market_repository.dart' as marketRepo;
import 'cart_controller.dart';
import 'package:intl/intl.dart';

class DeliveryPickupController extends CartController {
  GlobalKey<ScaffoldState> scaffoldKey;

  PaymentMethodList list;
  WebViewController webViewController;
  // завод заказов

  Order order;

  void setOrder(_order) {
    order = _order;
  }

  // шаг 0, выбираем опцию доставки, которая будет определять цену и метод доставки
  List<dynamic> schedules = [];
  int cartDeliveryOption = 0;
  void initDeliveryPickupFromCart(option) async {
    deliveryOrPickup = option[0] == 1 ? 0 : 1;
    setState(() {});
    await getDeliveryTimeSchedules(option[1]);
  }

  Future<void> getDeliveryTimeSchedules(marketId) async {
    schedules = await marketRepo.getSchedulesOfMarket(marketId);
    setState(() {});
  }

  bool multiplied = false;

  int get getCartDeliveryOption => cartDeliveryOption;

  // первый шаг
  String myName = '';
  String myPhone = '';
  String receiverName = '';
  String receiverPhone = '';
  String receiverLetter = '';
  bool isReceiverFieldsEqualsToMine = false;
  bool isMyNameCorrect = true;
  bool isMyPhoneCorrect = true;
  bool isReceiverNameCorrect = true;
  bool isReceiverPhoneCorrect = true;
  bool isReceiverLetterCorrect = true;

  String get getReceiverName =>
      isReceiverFieldsEqualsToMine ? myName : receiverName;
  String get getReceiverPhone =>
      isReceiverFieldsEqualsToMine ? myPhone : receiverPhone;

  // второй шаг
  // 0 - доставка, 1 - самовывоз
  model.Address deliveryAddress;
  model.Address get getDeliveryAddress => deliveryAddress;
  int deliveryOrPickup = 0;
  String deliveryOrPickupAddress = '';
  String deliveryRegion = '';
  String deliveryPrice = '';
  String get getDeliveryOrPickupString =>
      deliveryOrPickup == 1 ? 'Самовывоз' : 'Курьер';
  int get getDeliveryOrPickup => deliveryOrPickup;
  String get getDeliveryRegion => deliveryRegion;
  String get getDeliveryPrice => deliveryPrice;
  bool deliveryRegionCorrect = true;
  bool deliveryOrPickupAddressCorrect = true;
  String deliveryHint = "";
  bool deliveryIsPrivate = false;

  // третий шаг
  String deliveryDate = '';
  bool isDateFromCalendar = false;
  String deliveryTime = '';

  bool deliveryDateCorrect = true;
  bool deliveryTimeCorrect = true;

  String get getDeliveryDate {
    DateTime _tempDateTime =
        DateTime.parse(deliveryDate.split('.').reversed.join('-'));
    return DateFormat('EEEE, d MMMM, ' 'yyyy', 'ru_RU').format(_tempDateTime);
  }

  String get getDeliveryTime {
    if (deliveryTime.isEmpty) return '';
    if (deliveryTime.split(' - ').length == 2) return deliveryTime;
    List<String> _temp = deliveryTime.split(':');
    int _tempInt = int.parse(_temp[0]);
    String _tempString;
    _tempInt += 1;
    _tempString = _tempInt < 10 ? "0${_tempInt}" : "${_tempInt}";
    return "${deliveryTime} - ${_tempString}:00";
  }

  DateTime get getDeliveryTimestamp {
    DateTime _temp =
        DateFormat("dd.MM.yyyy HH:mm").parse("$deliveryDate $deliveryTime");
    DateTime _formatted =
        DateTime.parse(DateFormat("yyyy-MM-dd HH:mm:ss").format(_temp));
    return _formatted;
  }

  // 4 шаг
  String paymentMethod = '';
  // геттер для отображения кнопки "оплатить" или "готово" на четвертом шаге
  bool get getPaymentMethodCashOrCard =>
      paymentMethod != 'При получении' ? true : false;
  String get getPaymentMethodString => paymentMethod == 'При получении'
      ? 'Оплата при самовывозе'
      : 'Оплачен онлайн';

  // ! завод заказов

  DeliveryPickupController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    super.listenForCarts();
    listenForDeliveryAddress();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    print(settingRepo.deliveryAddress.value.toMap());
  }

  Future<void> runJsInWebView() async {
    print('delivery or pickup? ${deliveryOrPickup}');
    print('delivery price is ${deliveryPrice.toString()}');
    print('total is ${total.toString()}');

    double _wTotal = deliveryPrice != ""
        ? double.parse(deliveryPrice) + total
        : total.toDouble();

    String output = myPhone.replaceAll(RegExp(r'\s+|-'), '');
    await webViewController.runJavascript(''' 
      var sum = document.getElementById('sum');
      if(sum){
        sum.value = '${_wTotal.toInt()}';
      }
      var phone = document.getElementById('client_phone');
      if(phone){
        phone.value = '+7${output}';
      }
      var cName = document.getElementById('clientid');
      if(cName){
        cName.value = '${myName}';
      }
    ''');
  }

  Future<int> webViewPayment(context) async {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text('Оплата'),
          ),
          body: SafeArea(
            child: WebView(
              initialUrl: 'https://amelia-app53.fvds.ru/pay/',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController controller) {
                setState(() {
                  webViewController = controller;
                });
              },
              onPageFinished: (String str) async {
                await Future.delayed(Duration(milliseconds: 400));
                runJsInWebView();
              },
              navigationDelegate: (NavigationRequest request) {
                if (request.url.contains('success.html')) {
                  Navigator.pop(context, 2);
                } else if (request.url.contains('error.html')) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Возникла ошибка при оплате')));
                  Navigator.pop(context, 0);
                }
                return NavigationDecision.navigate;
              },
            ),
          ),
        ),
      ),
    );
  }

  checkFourthStep() {
    bool _ret = true;
    if (paymentMethod.isEmpty) {
      _ret = false;
    }
    return _ret;
  }

  handleFourthStep(method) {
    paymentMethod = method;
  }

  bool checkThirdStep() {
    bool _ret = true;
    if (deliveryTime.isEmpty || deliveryDate.isEmpty) {
      _ret = false;
    }
    if (deliveryTime.isEmpty) {
      deliveryTimeCorrect = false;
    }
    if (deliveryDate.isEmpty) {
      deliveryDateCorrect = false;
    }
    setState(() {});
    return _ret;
  }

  void handleThirdStepDate(date) {
    deliveryDate = date;
    deliveryDateCorrect = true;
    // setState(() {});
  }

  void handleThirdStepTime(time, nightbool) {
    deliveryTime = time;
    if (deliveryPrice == '') return;
    if (nightbool && !multiplied) {
      deliveryPrice = (int.parse(deliveryPrice) * 2).toString();
      multiplied = true;
    } else if (!nightbool && multiplied) {
      deliveryPrice = (int.parse(deliveryPrice) ~/ 2).toString();
      multiplied = false;
    }
    deliveryTimeCorrect = true;
    setState(() {});
  }

  bool checkSecondStep() {
    bool _ret = true;
    deliveryRegionCorrect = true;
    deliveryOrPickupAddressCorrect = true;
    if (deliveryOrPickup == 0) {
      if (deliveryOrPickupAddress.isEmpty ||
          deliveryRegion.isEmpty ||
          deliveryPrice.isEmpty) {
        _ret = false;
      }
      if (deliveryRegion.isEmpty) {
        deliveryRegionCorrect = false;
      }
    } else {
      if (deliveryOrPickupAddress.isEmpty) {
        _ret = false;
      }
    }
    if (deliveryOrPickupAddress.isEmpty) {
      deliveryOrPickupAddressCorrect = false;
    }

    setState(() {});

    return _ret;
  }

  void handleSecondStepType(type) {
    deliveryOrPickupAddress = '';
    deliveryRegion = '';
    deliveryPrice = '';
    deliveryOrPickup = type;
    multiplied = false;
    deliveryTime = '';

    setState(() {});
  }

  void handleSecondStepInput(address, region, price, hint, isPrivate) {
    deliveryOrPickupAddress = address;
    deliveryRegion = region;
    deliveryPrice = price;
    multiplied = false;
    deliveryTime = '';
    deliveryRegionCorrect = true;
    deliveryOrPickupAddressCorrect = true;
    deliveryHint = hint;
    deliveryIsPrivate = isPrivate;
    setState(() {});
  }

  void handleFirstStepCheckBox(value) {
    isReceiverFieldsEqualsToMine = value;
  }

  bool checkFirstStep() {
    bool _ret = true;
    isMyNameCorrect = myName.isNotEmpty;
    isMyPhoneCorrect = myPhone.length >= 9;

    if (deliveryOrPickup == 0) {
      if (!isMyNameCorrect || !isMyPhoneCorrect) {
        _ret = false;
      }
    }

    if (!isReceiverFieldsEqualsToMine) {
      isReceiverNameCorrect = receiverName.isNotEmpty;
      isReceiverPhoneCorrect = receiverPhone.length >= 9;
      if (!isReceiverNameCorrect || !isReceiverPhoneCorrect) {
        _ret = false;
      }
    }

    setState(() {});

    return _ret;
  }

  void handleFirstStepInput(
      _myName, _myPhone, _receiverName, _receiverPhone, _receiverLetter) {
    myName = _myName;
    myPhone = _myPhone;
    receiverName = _receiverName;
    receiverPhone = _receiverPhone;
    receiverLetter = _receiverLetter;
  }

  void listenForDeliveryAddress() async {
    this.deliveryAddress = settingRepo.deliveryAddress.value;
  }

  void addAddress(model.Address address) {
    userRepo.addAddress(address).then((value) {
      setState(() {
        settingRepo.deliveryAddress.value = value;
        this.deliveryAddress = value;
      });
    }).whenComplete(() {
      ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
        content: Text(S.of(state.context).new_address_added_successfully),
      ));
    });
  }

  void updateAddress(model.Address address) {
    userRepo.updateAddress(address).then((value) {
      setState(() {
        settingRepo.deliveryAddress.value = value;
        this.deliveryAddress = value;
      });
    }).whenComplete(() {
      ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
        content: Text(S.of(state.context).the_address_updated_successfully),
      ));
    });
  }

  PaymentMethod getPickUpMethod() {
    return list.pickupList.elementAt(0);
  }

  PaymentMethod getDeliveryMethod() {
    return list.pickupList.elementAt(1);
  }

  void toggleDelivery() {
    list.pickupList.forEach((element) {
      if (element != getDeliveryMethod()) {
        element.selected = false;
      }
    });
    setState(() {
      getDeliveryMethod().selected = !getDeliveryMethod().selected;
    });
  }

  void togglePickUp() {
    list.pickupList.forEach((element) {
      if (element != getPickUpMethod()) {
        element.selected = false;
      }
    });
    setState(() {
      getPickUpMethod().selected = !getPickUpMethod().selected;
    });
  }

  PaymentMethod getSelectedMethod() {
    return list.pickupList.firstWhere((element) => element.selected);
  }

  // @override
  // void goCheckout(BuildContext context) {
  //   Navigator.of(state.context).pushNamed(getSelectedMethod().route);
  // }
}
