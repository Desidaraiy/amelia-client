import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:markets/src/components/ChooseDeliveryRegion.dart';
import 'package:markets/src/helpers/colors.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';
import '../controllers/delivery_pickup_controller.dart';
import 'ShippingMethodWidget.dart';
import 'UserOrderWidget.dart';
import 'ModalBottomSheetWidget.dart';
import 'AddDeliveryAddressWidget.dart';
import 'SavedUsersDeliveryAddressesWidget.dart';
import 'ChoosePickUpAddressWidget.dart';

class ShippingWidget extends StatefulWidget {
  const ShippingWidget({Key key, this.userOrder, this.controller})
      : super(key: key);
  final bool userOrder;
  final DeliveryPickupController controller;

  @override
  _ShippingWidgetState createState() => _ShippingWidgetState();
}

class _ShippingWidgetState extends StateMVC<ShippingWidget> {
  int selectedIndex = 0;
  String _address = '';
  String _deliveryRegion = '';
  String _deliveryPrice = '';
  String _hint = '';
  bool _isPrivate = false;
  DeliveryPickupController _con;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   setState(() {
  //     _con = widget.controller;
  //     selectedIndex = _con.getDeliveryOrPickup;
  //     _address = _con.deliveryOrPickupAddress;
  //     _deliveryRegion = _con.getDeliveryRegion;
  //     _deliveryPrice = _con.getDeliveryPrice;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    setState(() {
      _con = widget.controller;
      selectedIndex = _con.getDeliveryOrPickup;
      _address = _con.deliveryOrPickupAddress;
      _hint = _con.deliveryHint;
      _isPrivate = _con.deliveryIsPrivate;
      _deliveryRegion = _con.getDeliveryRegion;
      _deliveryPrice = _con.getDeliveryPrice;
    });
  }

  void _handleStep() {
    String _deliveryHint = '';
    if (selectedIndex == 1) {
      _deliveryPrice = '';
      _deliveryRegion = '';
    }
    _con.handleSecondStepInput(
        _address, _deliveryRegion, _deliveryPrice, _hint, _isPrivate);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).shipping_method,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  ShippingMethodWidget(
                    onTapDelivery: () {
                      setState(() {
                        selectedIndex = 0;
                        _address = '';
                        _con.handleSecondStepType(0);
                      });
                    },
                    onTapPickUp: () {
                      setState(() {
                        selectedIndex = 1;
                        _address = '';
                        _con.handleSecondStepType(1);
                      });
                    },
                    selectedIndex: selectedIndex,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    selectedIndex == 0
                        ? S.of(context).delivery_address
                        : S.of(context).pickup_address,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  InkWell(
                    onTap: () {
                      if (selectedIndex == 0) {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (_) {
                              return ModalBottomSheetWidget(
                                reset: false,
                                initialChildSize: 0.50,
                                widget: AddDeliveryAddressWidget(
                                  onPop: (value) {
                                    // print('vibrannyu adres ${value}');
                                    setState(() {
                                      _address = value['address'];
                                      _hint = value['hint'];
                                      _isPrivate = value['isPrivate'];
                                    });
                                    _handleStep();
                                  },
                                ),
                                title: S.of(context).add_address,
                                showAll: false,
                              );
                            });
                      } else {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (_) {
                              return ModalBottomSheetWidget(
                                reset: false,
                                initialChildSize: 0.80,
                                widget: ChoosePickUpAddressWidget(
                                  onPop: (value) {
                                    setState(() {
                                      _address = value;
                                    });
                                    _handleStep();
                                  },
                                ),
                                title: S.of(context).place_of_pickup_address,
                                showAll: false,
                              );
                            });
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              selectedIndex == 0
                                  ? SvgPicture.asset(
                                      'assets/icons/location.svg',
                                      color: neutral_500)
                                  : SvgPicture.asset(
                                      'assets/icons/store_200.svg',
                                      color: neutral_500),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Text(
                                  selectedIndex == 0
                                      ? _address.isEmpty
                                          ? S
                                              .of(context)
                                              .click_to_set_delivery_address
                                          : _address
                                      : selectedIndex == 1
                                          ? _address.isEmpty
                                              ? S
                                                  .of(context)
                                                  .click_to_set_pickup_address
                                              : _address
                                          : '',
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .button
                                      .merge(TextStyle(
                                          height: 1.2,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                          color:
                                              _con.deliveryOrPickupAddressCorrect
                                                  ? neutral_500
                                                  : semantic_error)),
                                ),
                              )
                            ],
                          ),
                        ),

                        ///Не указан адрес доставки
                        // Padding(padding: EdgeInsets.only(left: 32),child: Text("Укажите адрес доставки товаров", style: Theme.of(context).textTheme.caption.merge(TextStyle(color: semantic_error)),),),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 32, top: 6, bottom: 14),
                          child: Row(
                            mainAxisAlignment: selectedIndex == 0
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: InkWell(
                                  child: Text(S.of(context).change,
                                      style: Theme.of(context)
                                          .textTheme
                                          .button
                                          .merge(TextStyle(
                                              height: 1.2,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                              color: neutral_400))),
                                ),
                              ),
                              // selectedIndex == 0
                              //     ? InkWell(
                              //         onTap: () => showModalBottomSheet(
                              //             isScrollControlled: true,
                              //             context: context,
                              //             backgroundColor: Colors.transparent,
                              //             builder: (_) {
                              //               return ModalBottomSheetWidget(
                              //                 reset: false,
                              //                 initialChildSize: 0.60,
                              //                 widget:
                              //                     SavedUsersDeliveryAddressesWidget(),
                              //                 title: S
                              //                     .of(context)
                              //                     .delivery_addresses,
                              //                 showAll: false,
                              //               );
                              //             }),
                              //         child: Text(
                              //             S.of(context).delivery_addresses,
                              //             style: Theme.of(context)
                              //                 .textTheme
                              //                 .button
                              //                 .merge(TextStyle(
                              //                     height: 1.2,
                              //                     fontWeight: FontWeight.w400,
                              //                     fontSize: 15,
                              //                     color: neutral_400))),
                              //       )
                              //     : SizedBox(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  selectedIndex == 0
                      ? Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                'Район доставки',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      backgroundColor: Colors.transparent,
                                      builder: (_) {
                                        return ModalBottomSheetWidget(
                                          reset: false,
                                          initialChildSize: 0.80,
                                          widget: ChooseDeliveryRegionWidget(
                                            onPop: (value, price) {
                                              setState(() {
                                                _deliveryRegion = value;
                                                _deliveryPrice = price;
                                              });
                                              _handleStep();
                                            },
                                          ),
                                          title: S
                                              .of(context)
                                              .place_of_pickup_address,
                                          showAll: false,
                                        );
                                      });
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                              'assets/icons/location.svg',
                                              color: neutral_500),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                            child: Text(
                                              _con.getDeliveryRegion.isEmpty
                                                  ? 'Нажмите, чтобы уточнить район доставки'
                                                  : '$_deliveryRegion, $_deliveryPrice ₽',
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .button
                                                  .merge(TextStyle(
                                                      height: 1.2,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 15,
                                                      color: _con
                                                              .deliveryRegionCorrect
                                                          ? neutral_500
                                                          : semantic_error)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 32, top: 6, bottom: 14),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              child: Text(S.of(context).change,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .button
                                                      .merge(TextStyle(
                                                          height: 1.2,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 15,
                                                          color: neutral_400))),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : SizedBox(height: 0),
                  widget.userOrder
                      ? Column(
                          children: [
                            // SizedBox(
                            //   height: 20,
                            // ),
                            Divider(
                              color: expanded_light_neutral_100,
                              height: 1.5,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        )
                      : SizedBox(),
                ],
              ),
            ),
            // widget.userOrder
            //     ? UserOrderWidget(
            //         price: true,
            //       )
            //     : SizedBox(),
          ],
        ),
      ),
    );
  }
}
