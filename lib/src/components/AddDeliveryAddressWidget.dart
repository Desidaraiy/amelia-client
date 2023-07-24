import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/helpers/colors.dart';

import '../../generated/l10n.dart';
import 'PrimaryButtonWidget.dart';
import 'TextInputWidget.dart';
import 'CheckBoxWidget.dart';

class AddDeliveryAddressWidget extends StatefulWidget {
  const AddDeliveryAddressWidget({this.onPop});

  final Function(String) onPop;

  @override
  State<AddDeliveryAddressWidget> createState() =>
      _AddDeliveryAddressWidgetState();
}

class _AddDeliveryAddressWidgetState extends State<AddDeliveryAddressWidget> {
  TextEditingController _addressCont = TextEditingController();
  TextEditingController _entranceCont = TextEditingController();
  TextEditingController _floorCont = TextEditingController();
  TextEditingController _apartmentCont = TextEditingController();

  String _fullAddress;

  void _handleAddress(context) {
    if (_addressCont.text.isEmpty ||
        _entranceCont.text.isEmpty ||
        _floorCont.text.isEmpty ||
        _apartmentCont.text.isEmpty) {
      return;
    }
    _fullAddress =
        "${_addressCont.text}, подъезд ${_entranceCont.text}, этаж ${_floorCont.text}, квартира ${_apartmentCont.text}";
    widget.onPop(_fullAddress);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          S.of(context).delivery_address,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        SizedBox(
          height: 8,
        ),
        PropertyInput(
          small: false,
          textController: _addressCont,
          personal: false,
          onSaved: (input) {},
          onChange: (input) {},
          hintText: 'Город, улица, дом',
          maxLines: 5,
          maxLength: 300,
          keyboardType: TextInputType.text,
          labelText: "Город, улица, дом",
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Expanded(
              child: PropertyInput(
                small: false,
                textController: _entranceCont,
                personal: false,
                onSaved: (input) {},
                onChange: (input) {},
                hintText: 'Подъезд',
                maxLines: 1,
                maxLength: 5,
                keyboardType: TextInputType.number,
                labelText: "Подъезд",
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: PropertyInput(
                small: false,
                textController: _floorCont,
                personal: false,
                onSaved: (input) {},
                onChange: (input) {},
                hintText: 'Этаж',
                maxLines: 1,
                maxLength: 5,
                prefixIcon: null,
                keyboardType: TextInputType.number,
                labelText: "Этаж",
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: PropertyInput(
                small: false,
                textController: _apartmentCont,
                personal: false,
                onSaved: (input) {},
                onChange: (input) {},
                hintText: 'Квартира/офис',
                maxLines: 1,
                maxLength: 100,
                keyboardType: TextInputType.text,
                labelText: "Квартира/офис",
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        PropertyInput(
          small: false,
          textController: TextEditingController(),
          personal: false,
          onSaved: (input) {},
          onChange: (input) {},
          hintText: 'Комментарий курьеру (необязательно)',
          maxLines: 5,
          maxLength: 300,
          keyboardType: TextInputType.text,
          labelText: "Комментарий курьеру (необязательно)",
        ),
        CheckBoxWidget(
          value: false,
          onChange: (value) {},
          checkboxTextFirst: Text(
            "Частный дом, организация и т.п",
            style: Theme.of(context)
                .textTheme
                .overline
                .merge(TextStyle(color: neutral_500, height: 1.1)),
          ),
        ),
        PrimaryButton(
          icon: null,
          small: false,
          text: "Добавить адрес",
          onPressed: () {
            // Navigator.of(context).pop();
            _handleAddress(context);
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
      ]),
    );
  }
}