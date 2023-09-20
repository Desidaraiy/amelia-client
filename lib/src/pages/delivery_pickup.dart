import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:markets/src/components/ModalBottomSheetWidget.dart';
import 'package:markets/src/components/PersonalDataFormWidget.dart';
import 'package:markets/src/components/ShippingWidget.dart';
import 'package:markets/src/components/CheckoutButtonsWidget.dart';
import 'package:markets/src/components/OrderPaymentWidget.dart';
import 'package:markets/src/components/OrderReviewWidget.dart';
import 'package:markets/src/components/DateTimeShippingWidget.dart';
import 'package:markets/src/components/UserOrderWidget.dart';
import 'package:markets/src/controllers/cart_controller.dart';
import 'package:markets/src/helpers/colors.dart';
import 'package:markets/src/models/cart.dart';
import 'package:markets/src/models/order.dart';
import 'package:markets/src/models/order_status.dart';
import 'package:markets/src/models/payment.dart';
import 'package:markets/src/models/user.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../controllers/checkout_controller.dart';
import '../elements/DeliveryTimeWidget.dart';
import '../elements/DeliveryDateWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../pages/add_bank_card.dart';
import '../repository/settings_repository.dart' as settingRepo;
import '../repository/user_repository.dart' as userRepo;
import '../../generated/l10n.dart';
import '../controllers/delivery_pickup_controller.dart';
import '../elements/CartBottomDetailsWidget.dart';
import '../elements/DeliveryAddressDialog.dart';
import '../elements/DeliveryAddressesItemWidget.dart';
import '../elements/NotDeliverableAddressesItemWidget.dart';
import '../elements/PickUpMethodItemWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../helpers/helper.dart';
import '../models/address.dart';
import '../models/payment_method.dart';
import '../models/payment.dart';
import '../models/route_argument.dart';

class Pages extends StatelessWidget {
  final text;
  Pages({this.text});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ]),
    );
  }
}

class DeliveryPickupWidget extends StatefulWidget {
  final RouteArgument routeArgument;

  DeliveryPickupWidget({
    Key key,
    this.routeArgument,
  }) : super(key: key);

  @override
  _DeliveryPickupWidgetState createState() => _DeliveryPickupWidgetState();
}

class _DeliveryPickupWidgetState extends StateMVC<DeliveryPickupWidget> {
  DeliveryPickupController _con;

  List<Widget> orderSteps;

  DateTime date;
  TimeOfDay time;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _tapped = false;

  _DeliveryPickupWidgetState() : super(DeliveryPickupController()) {
    _con = controller;
  }

  Future<void> _handleOrder(context) async {
    CheckoutController _checkoutCon = CheckoutController();
    int status = 0;
    Order order = new Order();
    order.receiver_name = _con.getReceiverName;
    order.receiver_phone = _con.getReceiverPhone;
    order.sms_after_delivery = _con.receiverLetter;
    order.hint = _con.deliveryHint;
    order.comment = 'default';
    order.delivery_timestamp = _con.getDeliveryTimestamp;
    OrderStatus orderStatus = new OrderStatus();
    orderStatus.id = '1';
    order.orderStatus = orderStatus;
    order.delivery_price = 0.0;
    if (_con.deliveryOrPickup != 1) {
      order.delivery_price = int.parse(_con.deliveryPrice).toDouble();
    }

    Payment payment = Payment(_con.getPaymentMethodString);
    Address deliveryAddress = Address();
    deliveryAddress.address = _con.deliveryOrPickupAddress;
    order.delivery_address = deliveryAddress;

    User _user = userRepo.currentUser.value;
    if (_user.name == 'Клиент') {
      _user.name = _con.myName;
    }
    order.user = _user;
    if (_con.getPaymentMethodCashOrCard) {
      status = await _con.webViewPayment(context);
      orderStatus.id = status.toString();
    } else {
      status = 1;
    }
    setState(() {
      _tapped = false;
    });
    if (status != null && status != 0) {
      _checkoutCon
          .addOrder(_con.carts, order, payment, _con.myName)
          .then((value) {
        _con.setOrder(value);

        Navigator.of(context).pushReplacementNamed('/PlacedOrder',
            arguments: RouteArgument(param: _con));
      });
    }
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _con.initDeliveryPickupFromCart(widget.routeArgument.param);
    super.initState();
  }

  int currentPage = 0;
  ScrollController _scrollController;
  PageController pageController = PageController(initialPage: 0);

  @override
  dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      orderSteps = <Widget>[
        ListView(
          children: [
            PersonalDataFormWidget(userOrder: true, controller: _con),
            UserOrderWidget(price: true, controller: _con)
          ],
        ),
        ListView(children: [
          ShippingWidget(userOrder: true, controller: _con),
          UserOrderWidget(price: true, controller: _con)
        ]),
        ListView(children: [
          DateTimeShippingWidget(
            userOrder: true,
            controller: _con,
          ),
          UserOrderWidget(price: true, controller: _con)
        ]),
        ListView(children: [
          OrderPaymentWidget(
            userOrder: true,
            controller: _con,
          ),
          UserOrderWidget(price: true, controller: _con)
        ]),
        ListView(
          children: [
            OrderReviewWidget(
              userOrder: true,
              controller: _con,
            ),
            UserOrderWidget(price: true, controller: _con)
          ],
        ),
      ];
    });

    if (_con.list == null) {
      _con.list = new PaymentMethodList(context);
    }
    return Scaffold(
      bottomNavigationBar: CheckoutButtonsWidget(
        cartController: _con,
        status: "",
        isLoading: _tapped,
        next: currentPage == 4
            ? !_con.getPaymentMethodCashOrCard
                ? 'Готово'
                : S.of(context).place_order
            : S.of(context).continue_step,
        onTapBack: () {
          pageController.animateToPage(currentPage - 1,
              duration: Duration(microseconds: 250), curve: Curves.bounceInOut);
          if (currentPage == 0) {
            Navigator.of(context).pushNamed('/Pages', arguments: 2);
          }
        },
        onTapNext: () {
          if (currentPage == 0) {
            if (_con.checkFirstStep()) {
              pageController.animateToPage(currentPage + 1,
                  duration: Duration(microseconds: 250),
                  curve: Curves.bounceInOut);
            }
          }

          if (currentPage == 1) {
            if (_con.checkSecondStep()) {
              pageController.animateToPage(currentPage + 1,
                  duration: Duration(microseconds: 250),
                  curve: Curves.bounceInOut);
            }
          }

          if (currentPage == 2) {
            if (_con.checkThirdStep()) {
              pageController.animateToPage(currentPage + 1,
                  duration: Duration(microseconds: 250),
                  curve: Curves.bounceInOut);
            }
          }

          if (currentPage == 3) {
            if (_con.checkFourthStep()) {
              pageController.animateToPage(currentPage + 1,
                  duration: Duration(microseconds: 250),
                  curve: Curves.bounceInOut);
            }
          }

          if (currentPage == 4) {
            if (_tapped) {
              return;
            } else {
              _handleOrder(context);
            }
            setState(() {
              _tapped = true;
            });
          }
          // if (currentPage == 3) {
          //   showModalBottomSheet(
          //       isScrollControlled: true,
          //       context: context,
          //       backgroundColor: Colors.transparent,
          //       builder: (_) {
          //         return ModalBottomSheetWidget(
          //           reset: false,
          //           initialChildSize: 0.80,
          //           widget: AddBankCardWidget(),
          //           title: S.of(context).add_card,
          //           showAll: false,
          //         );
          //       });
          // }
          // pageController.animateToPage(currentPage + 1,
          //     duration: Duration(microseconds: 250), curve: Curves.bounceInOut);
        },
      ),
      key: _con.scaffoldKey,
      backgroundColor: background,
      body: Form(
        key: _formKey,
        child: NestedScrollView(
          floatHeaderSlivers: true,
          scrollDirection: Axis.vertical,
          controller: _scrollController,
          body: PageView(
            reverse: true,
            physics: NeverScrollableScrollPhysics(),
            controller: pageController,
            children: orderSteps,
            onPageChanged: (num) {
              setState(() {
                currentPage = num;
              });
            },
          ),
          // body: Column(
          //   children: [
          //     Expanded(
          //       child: PageView(
          //         reverse: true,
          //         physics: NeverScrollableScrollPhysics(),
          //         controller: pageController,
          //         children: orderSteps,
          //         onPageChanged: (num) {
          //           setState(() {
          //             currentPage = num;
          //           });
          //         },
          //       ),
          //     ),
          //     Container(
          //         child: UserOrderWidget(
          //             price: true, carts: _con.carts, total: _con.total))
          //   ],
          // ),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                shadowColor: expanded_light_neutral_100.withOpacity(0.2),
                pinned: true,
                floating: true,
                automaticallyImplyLeading: false,
                collapsedHeight: 98,
                backgroundColor: primary_50,
                expandedHeight: 98,
                flexibleSpace: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              currentPage == 0
                                  ? S.of(context).personal_data
                                  : currentPage == 1
                                      ? S.of(context).shipping_method
                                      : currentPage == 2
                                          ? S.of(context).shipping_datetime
                                          : currentPage == 3
                                              ? S.of(context).payment
                                              : S.of(context).review,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .merge(
                                      TextStyle(fontWeight: FontWeight.w500)),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Row(
                              children: [
                                Text(
                                  S.of(context).next + ":",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      .merge(TextStyle(color: neutral_500)),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  currentPage == 0
                                      ? S.of(context).shipping_method
                                      : currentPage == 1
                                          ? S.of(context).shipping_datetime
                                          : currentPage == 2
                                              ? S.of(context).payment
                                              : currentPage == 3
                                                  ? S.of(context).review
                                                  : S.of(context).placed_order,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      .merge(TextStyle(
                                          color: neutral_500,
                                          fontWeight: FontWeight.w400)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      CircularPercentIndicator(
                        lineWidth: 7,
                        progressColor: secondary_300,
                        backgroundColor: expanded_light_neutral_100,
                        percent: currentPage == 0
                            ? 0.2
                            : currentPage == 1
                                ? 0.4
                                : currentPage == 2
                                    ? 0.6
                                    : currentPage == 3
                                        ? 0.8
                                        : 1.0,
                        circularStrokeCap: CircularStrokeCap.round,
                        center: currentPage == 0
                            ? SizedBox(
                                width: 35,
                                child: Text(
                                  "1/5",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      .merge(TextStyle(
                                          color: primary_700,
                                          fontWeight: FontWeight.w400)),
                                ),
                              )
                            : currentPage == 1
                                ? SizedBox(
                                    width: 35,
                                    child: Text(
                                      "2/5",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4
                                          .merge(TextStyle(
                                              color: primary_700,
                                              fontWeight: FontWeight.w400)),
                                    ),
                                  )
                                : currentPage == 2
                                    ? SizedBox(
                                        width: 35,
                                        child: Text(
                                          "3/5",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4
                                              .merge(TextStyle(
                                                  color: primary_700,
                                                  fontWeight: FontWeight.w400)),
                                        ),
                                      )
                                    : currentPage == 3
                                        ? SizedBox(
                                            width: 35,
                                            child: Text(
                                              "4/5",
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4
                                                  .merge(TextStyle(
                                                      color: primary_700,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                            ),
                                          )
                                        : SizedBox(
                                            width: 35,
                                            child: Text(
                                              "5/5",
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4
                                                  .merge(TextStyle(
                                                      color: primary_700,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                            ),
                                          ),
                        radius: 74,
                      )
                    ],
                  ),
                ),
              )
            ];
          },
        ),
      ),
    );
  }
}

///Validation
/*
 if (_formKey.currentState.validate()) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Processing Data')),
                                );
                              }
                               */
///Код формы
/*
Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 10),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  // leading: Icon(
                  //   Icons.domain,
                  //   color: Theme.of(context).hintColor,
                  // ),
                  title: Text(
                    S.of(context).pickup,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  subtitle: Text(
                    S.of(context).pickup_your_product_from_the_market,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              ),
              PickUpMethodItem(
                  paymentMethod: _con.getPickUpMethod(),
                  onPressed: (paymentMethod) {
                    _con.togglePickUp();
                  }),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 10, left: 20, right: 10),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      // leading: Icon(
                      //   Icons.map_outlined,
                      //   color: Theme.of(context).hintColor,
                      // ),
                      title: Text(
                        S.of(context).delivery,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      subtitle: _con.carts.isNotEmpty &&
                              Helper.canDelivery(_con.carts[0].product.market,
                                  carts: _con.carts)
                          ? Text(
                              S
                                  .of(context)
                                  .click_to_confirm_your_address_and_pay_or_long_press,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.caption,
                            )
                          : Text(
                              S.of(context).deliveryMethodNotAllowed,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.caption,
                            ),
                    ),
                  ),
                  if (_con.carts.isNotEmpty &&
                      Helper.canDelivery(_con.carts[0].product.market,
                          carts: _con.carts)) ...[
                    DeliveryAddressesItemWidget(
                      paymentMethod: _con.getDeliveryMethod(),
                      address: _con.deliveryAddress,
                      onPressed: (Address _address) {
                        if (_con.deliveryAddress.id == null ||
                            _con.deliveryAddress.id == 'null') {
                          DeliveryAddressDialog(
                            context: context,
                            address: _address,
                            onChanged: (Address _address) {
                              _con.addAddress(_address);
                            },
                          );
                        } else {
                          _con.toggleDelivery();
                        }
                      },
                      onLongPress: (Address _address) {
                        DeliveryAddressDialog(
                          context: context,
                          address: _address,
                          onChanged: (Address _address) {
                            _con.updateAddress(_address);
                          },
                        );
                      },
                    ),
                  ] else
                    NotDeliverableAddressesItemWidget(),
                  Text("${_con.deliveryAddress.address}"),
                  if (_con.deliveryAddress.address !=null)
                    Container(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 20),
                              child: Text(
                                S.of(context).customer_info,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              // onSaved: (input) => _con.user.name = input,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.length < 3) {
                                  return S
                                      .of(context)
                                      .should_be_more_than_3_letters;
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                // errorText:S.of(context).should_be_more_than_3_letters ,
                                labelText: S.of(context).receiver_name,
                                labelStyle: TextStyle(
                                    color: Theme.of(context).accentColor),
                                contentPadding: EdgeInsets.all(12),
                                hintText: S.of(context).receiver_name_mock,
                                hintStyle: TextStyle(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.7)),
                                prefixIcon: Icon(Icons.person_outline,
                                    color: Theme.of(context).accentColor),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .focusColor
                                            .withOpacity(0.2))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .focusColor
                                            .withOpacity(0.5))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .focusColor
                                            .withOpacity(0.2))),
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                TextInputMask(mask: '\\+9 (999) 999-99-99')
                              ],
                              // onSaved: (input) => _con.user.name = input,
                              validator: (input) => !input.startsWith('\+') &&
                                      !input.startsWith('00')
                                  ? S.of(context).should_be_more_than_3_letters
                                  : null,
                              decoration: InputDecoration(
                                // errorText:S.of(context).should_be_more_than_3_letters ,
                                labelText: S.of(context).phoneNumber,
                                labelStyle: TextStyle(
                                    color: Theme.of(context).accentColor),
                                contentPadding: EdgeInsets.all(12),
                                hintText: S.of(context).receiver_phone_mock,
                                hintStyle: TextStyle(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.7)),
                                prefixIcon: Icon(Icons.phone_android,
                                    color: Theme.of(context).accentColor),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .focusColor
                                            .withOpacity(0.2))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .focusColor
                                            .withOpacity(0.5))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .focusColor
                                            .withOpacity(0.2))),
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              S.of(context).delivery_date,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            DeliveryDateWidget(
                              calendarText: "Дата доставки",
                              onPress: () async {
                                final initDate = DateTime.now();

                                final DateTime newDate = await showDatePicker(
                                  initialDatePickerMode: DatePickerMode.day,
                                  initialEntryMode:
                                      DatePickerEntryMode.calendar,
                                  builder:
                                      (BuildContext context, Widget child) {
                                    return Theme(
                                      data: ThemeData.light().copyWith(
                                        focusColor:
                                            Theme.of(context).accentColor,
                                        colorScheme: ColorScheme.light(
                                          primary:
                                              Theme.of(context).accentColor,
                                          // onSecondary: Theme.of(context).accentColor,
                                          secondary:
                                              Theme.of(context).accentColor,
                                          onPrimary: Colors.white,
                                          surface: Theme.of(context)
                                              .accentColor
                                              .withOpacity(0.1),
                                          onSurface:
                                              Theme.of(context).accentColor,
                                        ),
                                        dialogBackgroundColor: Colors.white,
                                        // textTheme: TextTheme(headline1: Theme.of(context).textTheme.headline1)
                                      ),
                                      child: child,
                                    );
                                  },
                                  locale: Locale('ru', 'RU'),
                                  cancelText: "Отмена",
                                  confirmText: "Выбрать",
                                  helpText: "Дата доставки заказа",
                                  context: context,
                                  initialDate: initDate,
                                  firstDate: DateTime.now()
                                      .subtract(Duration(days: 0)),
                                  lastDate: DateTime(DateTime.now().year + 5),
                                );

                                // if 'Cancel' => null
                                if (newDate == null) return;
                                //of Ok =>DateTime
                                setState(() {
                                  date = newDate;

                                  final delivery_date = DateTime(
                                    date.year,
                                    date.month,
                                    date.day,
                                    // DateTime.now().hour,
                                    // DateTime.now().minute,
                                    // DateTime.now().second,
                                    // DateTime.now().millisecond,
                                    // DateTime.now().microsecond,
                                  );
                                  print("delivery date ${delivery_date}");
                                });
                              },
                              date: date,
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              S.of(context).delivery_time,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            DeliveryTimeWidget(
                              calendarText: "Время доставки",
                              onPress: () async {
                                final initDate = DateTime.now();

                                final TimeOfDay newTime = await showTimePicker(
                                  builder:
                                      (BuildContext context, Widget child) {
                                    MediaQuery.of(context)
                                        .copyWith(alwaysUse24HourFormat: true);
                                    return Theme(
                                      data: ThemeData.light().copyWith(
                                        focusColor:
                                            Theme.of(context).accentColor,
                                        colorScheme: ColorScheme.light(
                                          primary:
                                              Theme.of(context).accentColor,
                                          // onSecondary: Theme.of(context).accentColor,
                                          secondary:
                                              Theme.of(context).accentColor,
                                          onPrimary: Colors.white,
                                          surface: Colors.white,
                                          onSurface:
                                              Theme.of(context).accentColor,
                                        ),
                                        dialogBackgroundColor: Colors.white,
                                        // textTheme: TextTheme(headline1: Theme.of(context).textTheme.headline1)
                                      ),
                                      child: child,
                                    );
                                  },
                                  initialTime: TimeOfDay.now(),
                                  context: context,
                                );

                                // if 'Cancel' => null
                                if (newTime == null) return;
                                //of Ok =>DateTime
                                setState(() {
                                  time = newTime;

                                  final delivery_time = DateTime(
                                    // date.year,
                                    // date.month,
                                    // date.day,
                                    date.hour,
                                    date.minute,
                                    // DateTime.now().second,
                                  );
                                  print("delivery time ${time}");
                                });
                              },
                              time: time,
                            )
                          ],
                        ))
                ],
              )
            ],
          ),
*/
