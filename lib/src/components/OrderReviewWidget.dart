import 'package:flutter_svg/svg.dart';
import 'package:markets/src/components/PrimaryButtonWidget.dart';

import '../../generated/l10n.dart';
import 'package:markets/src/helpers/colors.dart';
import 'package:flutter/material.dart';
import '../controllers/delivery_pickup_controller.dart';
import 'DateTimeShippingWidget.dart';
import 'ModalBottomSheetWidget.dart';
import 'OrderPaymentWidget.dart';
import 'PersonalDataFormWidget.dart';
import 'ReviewWidget.dart';
import 'ShippingWidget.dart';
import 'UserOrderWidget.dart';

class OrderReviewWidget extends StatefulWidget {
  const OrderReviewWidget({
    Key key,
    this.userOrder,
    this.controller,
  }) : super(key: key);
  final bool userOrder;
  final DeliveryPickupController controller;

  @override
  State<OrderReviewWidget> createState() => _OrderReviewWidgetState();
}

class _OrderReviewWidgetState extends State<OrderReviewWidget> {
  DeliveryPickupController _con;

  @override
  void initState() {
    super.initState();
    _con = widget.controller;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            ReviewWidget(
              onTap: () => showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (_) {
                    return ModalBottomSheetWidget(
                      reset: false,
                      initialChildSize: 0.81,
                      widget: Column(
                        children: [
                          PersonalDataFormWidget(
                              userOrder: false, controller: _con),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: PrimaryButton(
                              icon: null,
                              small: false,
                              text: "Сохранить изменения",
                              onPressed: () {
                                Navigator.of(context).pop();
                                setState(() {});
                              },
                              min_width: 176,
                              min_height: 48,
                              left_padding: 0,
                              right_padding: 0,
                              top_padding: 14,
                              bottom_padding: 14,
                              border_radius: 5,
                              buttonText: true,
                            ),
                          ),
                        ],
                      ),
                      title: "Мои данные",
                      showAll: false,
                    );
                  }),
              edit: true,
              sectionTitle: "Ваши данные",
              levels: 3,
              title_1_1: "Отправитель:",
              data_1_1: "${_con.myName}",
              title_1_2: "Номер телефона:",
              data_1_2: "${_con.myPhone}",
              title_2_1: "Получатель:",
              data_2_1: "${_con.getReceiverName}",
              title_2_2: "Номер телефона:",
              data_2_2: "${_con.getReceiverPhone}",
              title_3_1: "Текст записки:",
              data_3_1: "${_con.receiverLetter}",
            ),
            SizedBox(
              height: 8,
            ),
            ReviewWidget(
              onTap: () => showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (_) {
                    return ModalBottomSheetWidget(
                      reset: false,
                      initialChildSize: 0.56,
                      widget: Column(
                        children: [
                          ShippingWidget(userOrder: false, controller: _con),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: PrimaryButton(
                              icon: null,
                              small: false,
                              text: "Сохранить изменения",
                              onPressed: () {
                                Navigator.of(context).pop();
                                setState(() {});
                              },
                              min_width: 176,
                              min_height: 48,
                              left_padding: 0,
                              right_padding: 0,
                              top_padding: 14,
                              bottom_padding: 14,
                              border_radius: 5,
                              buttonText: true,
                            ),
                          ),
                        ],
                      ),
                      title: "Способ получения и адрес",
                      showAll: false,
                    );
                  }),
              edit: true,
              sectionTitle: "Способ получения и адрес",
              levels: 3,
              title_1_1: "Способ получения:",
              data_1_1: "${_con.getDeliveryOrPickupString}",
              title_1_2: "Адрес:",
              data_1_2: "${_con.deliveryOrPickupAddress}",
              title_2_1: _con.deliveryRegion != "" ? "Район доставки" : "",
              data_2_1:
                  _con.deliveryRegion != "" ? "${_con.deliveryRegion}" : "",
              title_2_2: _con.deliveryPrice != "" ? "Стоимости доставки:" : "",
              data_2_2:
                  _con.deliveryPrice != "" ? "${_con.deliveryPrice} ₽" : "",
              title_3_1: "",
              data_3_1: "",
            ),
            SizedBox(
              height: 8,
            ),
            ReviewWidget(
              onTap: () => showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (_) {
                    return ModalBottomSheetWidget(
                      reset: false,
                      initialChildSize: 0.68,
                      widget: Column(
                        children: [
                          DateTimeShippingWidget(
                              userOrder: false, controller: _con),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: PrimaryButton(
                              icon: null,
                              small: false,
                              text: "Сохранить изменения",
                              onPressed: () {
                                Navigator.of(context).pop();
                                setState(() {});
                              },
                              min_width: 176,
                              min_height: 48,
                              left_padding: 0,
                              right_padding: 0,
                              top_padding: 14,
                              bottom_padding: 14,
                              border_radius: 5,
                              buttonText: true,
                            ),
                          ),
                        ],
                      ),
                      title: "Дата и время доставки",
                      showAll: false,
                    );
                  }),
              edit: true,
              sectionTitle: "Дата и время получения",
              levels: 2,
              title_1_1: "Дата:",
              data_1_1: "${_con.getDeliveryDate}",
              title_1_2: "Время:",
              data_1_2: "${_con.getDeliveryTime}",
            ),
            SizedBox(
              height: 8,
            ),
            ReviewWidget(
              onTap: () => showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (_) {
                    return ModalBottomSheetWidget(
                      reset: false,
                      initialChildSize: 0.37,
                      widget: Column(
                        children: [
                          OrderPaymentWidget(
                              userOrder: false, controller: _con),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: PrimaryButton(
                              icon: null,
                              small: false,
                              text: "Сохранить изменения",
                              onPressed: () {
                                Navigator.of(context).pop();
                                setState(() {});
                              },
                              min_width: 176,
                              min_height: 48,
                              left_padding: 0,
                              right_padding: 0,
                              top_padding: 14,
                              bottom_padding: 14,
                              border_radius: 5,
                              buttonText: true,
                            ),
                          ),
                        ],
                      ),
                      title: "Оплата",
                      showAll: false,
                    );
                  }),
              edit: true,
              sectionTitle: "Способ оплаты",
              levels: 2,
              title_1_1: "Способ оплаты:",
              data_1_1: "${_con.paymentMethod}",
              title_1_2: "",
              data_1_2: "",
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Связь с магазином',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/call.svg',
                          color: neutral_400,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "923-500",
                          style: Theme.of(context).textTheme.bodyText1.merge(
                              TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: neutral_400,
                                  height: 1.1,
                                  decoration: TextDecoration.underline)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Divider(
                    color: expanded_light_neutral_100,
                    height: 1.5,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            // UserOrderWidget(
            //   price: true,
            // )
          ],
        ),
      ),
    );
  }
}
