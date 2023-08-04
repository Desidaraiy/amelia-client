import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:markets/src/helpers/colors.dart';
import 'package:markets/src/models/cart.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';
import '../controllers/delivery_pickup_controller.dart';
import 'CheckBoxWidget.dart';
import 'TextInputWidget.dart';
import 'UserOrderWidget.dart';

class PersonalDataFormWidget extends StatefulWidget {
  const PersonalDataFormWidget(
      {Key key, this.userOrder, this.total, this.carts, this.controller})
      : super(key: key);
  final bool userOrder;
  final double total;
  final DeliveryPickupController controller;
  final List<Cart> carts;

  @override
  _PersonalDataFormWidgetState createState() => _PersonalDataFormWidgetState();
}

class _PersonalDataFormWidgetState extends StateMVC<PersonalDataFormWidget> {
  DeliveryPickupController _con;

  TextEditingController _myNameController = TextEditingController();
  TextEditingController _myPhoneController = TextEditingController();
  TextEditingController _receiverNameController = TextEditingController();
  TextEditingController _receiverPhoneController = TextEditingController();
  TextEditingController _receiverLetterController = TextEditingController();

  bool _isReceiverFieldsEqualsToMine = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      _con = widget.controller;
      _myNameController.text = _con.myName;
      _myPhoneController.text = _con.myPhone;
      _receiverNameController.text = _con.receiverName;
      _receiverPhoneController.text = _con.receiverPhone;
      _receiverLetterController.text = _con.receiverLetter;
      _isReceiverFieldsEqualsToMine = _con.isReceiverFieldsEqualsToMine;
    });
  }

  void _handleInput(st1, st2, st3, st4, st5) {
    _con.handleFirstStepInput(st1, st2, st3, st4, st5);
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
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _con.deliveryOrPickup == 0
                      ? Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  S.of(context).sender_data,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                SizedBox(
                                  width: 1,
                                ),
                                Text(
                                  "*",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .merge(
                                          TextStyle(color: expanded_red_450)),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            PropertyInput(
                              textController: _myNameController,
                              personal: false,
                              small: false,
                              propertyInvalid: !_con.isMyNameCorrect,
                              errorText: 'Введите фамилию и имя',
                              onSaved: (input) {},
                              onChange: (input) {
                                _con.isMyNameCorrect = true;
                                _handleInput(
                                    _myNameController.text,
                                    _myPhoneController.text,
                                    _receiverNameController.text,
                                    _receiverPhoneController.text,
                                    _receiverLetterController.text);
                              },
                              hintText: 'Имя и фамилия',
                              maxLines: 1,
                              maxLength: 100,
                              keyboardType: TextInputType.text,
                              labelText: "Имя и фамилия",
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            PropertyInput(
                                textController: _myPhoneController,
                                personal: false,
                                small: false,
                                propertyInvalid: !_con.isMyPhoneCorrect,
                                errorText: 'Введите корректный номер телефона',
                                onSaved: (input) {},
                                onChange: (input) {
                                  _handleInput(
                                      _myNameController.text,
                                      _myPhoneController.text,
                                      _receiverNameController.text,
                                      _receiverPhoneController.text,
                                      _receiverLetterController.text);
                                },
                                hintText: '999 999-99-99',
                                maxLines: 1,
                                maxLength: 100,
                                inputFormatters: [
                                  TextInputMask(mask: '\999 999-99-99')
                                ],
                                keyboardType: TextInputType.number,
                                prefixIcon: Container(
                                  width: 48,
                                  height: 48,
                                  padding: EdgeInsets.only(top: 4),
                                  alignment: Alignment.center,
                                  child: Text(
                                    S.of(context).country_code,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        .merge(TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: primary_700)),
                                  ),
                                )),
                            SizedBox(
                              height: 16,
                            ),
                          ],
                        )
                      : Container(height: 0),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            S.of(context).recipient_data,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          SizedBox(
                            width: 1,
                          ),
                          Text(
                            "*",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .merge(TextStyle(color: expanded_red_450)),
                          )
                        ],
                      ),
                      _con.deliveryOrPickup == 0
                          ? CheckBoxWidget(
                              value: _isReceiverFieldsEqualsToMine,
                              onChange: (value) {
                                setState(() {
                                  _isReceiverFieldsEqualsToMine = value;
                                  _con.handleFirstStepCheckBox(value);
                                  _con.isReceiverNameCorrect = true;
                                  _con.isReceiverPhoneCorrect = true;
                                });
                              },
                              checkboxTextFirst: Text(
                                "Совпадают с данными отправителя",
                                style: Theme.of(context)
                                    .textTheme
                                    .overline
                                    .merge(TextStyle(
                                        color: neutral_500, height: 1.1)),
                              ),
                            )
                          : Container(height: 0),
                      PropertyInput(
                        disabled: _isReceiverFieldsEqualsToMine,
                        textController: _receiverNameController,
                        personal: false,
                        small: false,
                        propertyInvalid: !_con.isReceiverNameCorrect,
                        errorText: 'Введите фамилию и имя',
                        onSaved: (input) {},
                        onChange: (input) {
                          _handleInput(
                              _myNameController.text,
                              _myPhoneController.text,
                              _receiverNameController.text,
                              _receiverPhoneController.text,
                              _receiverLetterController.text);
                        },
                        hintText: 'Имя и фамилия',
                        maxLines: 1,
                        maxLength: 100,
                        keyboardType: TextInputType.text,
                        labelText: "Имя и фамилия",
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      PropertyInput(
                          textController: _receiverPhoneController,
                          disabled: _isReceiverFieldsEqualsToMine,
                          personal: false,
                          small: false,
                          propertyInvalid: !_con.isReceiverPhoneCorrect,
                          errorText: 'Введите корректный номер телефона',
                          onSaved: (input) {},
                          onChange: (input) {
                            _handleInput(
                                _myNameController.text,
                                _myPhoneController.text,
                                _receiverNameController.text,
                                _receiverPhoneController.text,
                                _receiverLetterController.text);
                          },
                          hintText: '999 999-99-99',
                          maxLines: 1,
                          maxLength: 100,
                          inputFormatters: [
                            TextInputMask(mask: '\999 999-99-99')
                          ],
                          keyboardType: TextInputType.number,
                          prefixIcon: Container(
                            width: 48,
                            height: 48,
                            padding: EdgeInsets.only(top: 4),
                            alignment: Alignment.center,
                            child: Text(
                              S.of(context).country_code,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .merge(TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: primary_700)),
                            ),
                          )),
                      SizedBox(
                        height: 8,
                      ),
                      PropertyInput(
                        textController: _receiverLetterController,
                        personal: false,
                        small: false,
                        onSaved: (input) {},
                        onChange: (input) {
                          _handleInput(
                              _myNameController.text,
                              _myPhoneController.text,
                              _receiverNameController.text,
                              _receiverPhoneController.text,
                              _receiverLetterController.text);
                        },
                        hintText: 'Текст записки (необязательно)',
                        maxLines: 1,
                        maxLength: 100,
                        keyboardType: TextInputType.text,
                        labelText: "Текст записки (необязательно)",
                      ),
                    ],
                  ),
                  widget.userOrder
                      ? Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
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
            // userOrder
            //     ? UserOrderWidget(price: true, total: total, carts: carts)
            //     : SizedBox(),
          ],
        ),
      ),
    );
  }
}
