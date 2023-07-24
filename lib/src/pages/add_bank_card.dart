import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/components/CheckBoxWidget.dart';
import 'package:markets/src/components/DateTimeShippingWidget.dart';
import 'package:markets/src/components/PrimaryButtonWidget.dart';
import 'package:markets/src/components/TextInputWidget.dart';
import 'package:markets/src/helpers/colors.dart';
import 'package:markets/src/helpers/helper.dart';
import 'package:markets/src/pages/delivery_pickup.dart';
import '../../generated/l10n.dart';

class AddBankCardWidget extends StatelessWidget {
  const AddBankCardWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            height: 206,
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            decoration: BoxDecoration(
                color: primary_50, borderRadius: BorderRadius.circular(20.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).card_number,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(
                  height: 4,
                ),
                PropertyInput(     textController: TextEditingController(),
                  personal: false,
                  small: true,
                  onSaved: (input) {},
                  onChange: (input) {},
                  hintText: '1234 5678 9012 3456',
                  maxLines: 1,
                  maxLength: 19,
                  inputFormatters: [TextInputMask(mask: '9999 9999 9999 9999')],
                  keyboardType: TextInputType.number,
                  // labelText: "Город, улица, дом",
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).exp_date,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          SizedBox(
                            width: 86,
                            child: PropertyInput(     textController: TextEditingController(),
                              personal: false,
                              small: true,
                              onSaved: (input) {},
                              onChange: (input) {},
                              hintText: 'MM/YY',
                              maxLines: 1,
                              maxLength: 5,
                              inputFormatters: [TextInputMask(mask: '9X/999')],
                              keyboardType: TextInputType.number,
                              // labelText: "Город, улица, дом",
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          S.of(context).cvv_cvc,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        SizedBox(
                          width: 60,
                          child: PropertyInput(     textController: TextEditingController(),
                            personal: false,
                            small: true,
                            onSaved: (input) {},
                            onChange: (input) {},
                            hintText: '123',
                            maxLines: 1,
                            maxLength: 3,
                            inputFormatters: [TextInputMask(mask: '999')],
                            keyboardType: TextInputType.number,
                            // labelText: "Город, улица, дом",
                          ),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        'assets/img/mir.png',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          CheckBoxWidget(
            checkboxTextFirst: Text(
              'Сохранить карту',
              style: Theme.of(context)
                  .textTheme
                  .overline
                  .merge(TextStyle(
                  color:
                  neutral_500,
                  height: 1.1)),
            ),
            checkboxTextSecond: Row(
              children: [
                Text(
                  'Сохраняя карту, вы соглашаетесь с условиями ',
                  overflow: TextOverflow
                      .ellipsis,
                  maxLines: 10,
                  style: Theme.of(
                      context)
                      .textTheme
                      .overline
                      .merge(TextStyle(
                    color:
                    neutral_400,
                    height: 1.1,
                  )),
                ),
                Text(
                  'привязки карты',
                  overflow: TextOverflow
                      .ellipsis,
                  maxLines: 10,
                  style: Theme.of(
                      context)
                      .textTheme
                      .overline
                      .merge(TextStyle(
                      color:
                      neutral_400,
                      height: 1.1,
                      decoration:
                      TextDecoration
                          .underline)),
                )
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          PrimaryButton(
            icon: null,
            small: false,
            text: "Сохранить",
            min_width: 176,
            min_height: 48,
            left_padding: 0,
            right_padding: 0,
            top_padding: 14,
            bottom_padding: 14,
            border_radius: 5,
            buttonText: true,
            onPressed: ()=>Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }
}
