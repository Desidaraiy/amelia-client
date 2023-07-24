import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/helpers/colors.dart';

import '../../generated/l10n.dart';
import 'PrimaryButtonWidget.dart';

class ChoosePickUpAddressWidget extends StatefulWidget {
  const ChoosePickUpAddressWidget({this.onPop});
  final Function(String) onPop;
  @override
  State<ChoosePickUpAddressWidget> createState() =>
      _ChoosePickUpAddressWidgetState();
}

class _ChoosePickUpAddressWidgetState extends State<ChoosePickUpAddressWidget> {
  List addresses = [
    "Магазин “Амелия\"" "\nВеликий Новгород, ул. Московская, 7",
    "Магазин “Амелия\"" "\nВеликий Новгород, ул. Псковская, 28",
    "Магазин “Амелия\"" "\nВеликий Новгород, ул. Б.Московская, 160к2",
    "Магазин “Амелия\"" "\nВеликий Новгород, ул. Людогоща, 8",
    "Магазин “Амелия\"" "\nВеликий Новгород, ул. Б.Московская 63 к1",
    'Магазин “Амелия\"' '\nВеликий Новгород, ул. Великая 22, ТЦ "Лента"',
    "Магазин “Амелия\"" "\nВеликий Новгород, ул. Псковская 44 к1",
    'Магазин “Амелия\"' '\nВеликий Новгород, ул. А.Корсунова 14а, "Славянский"',
    'Магазин “Амелия\"' '\nВеликий Новгород, ул.Кочетова д.4',
    'Магазин “Амелия\"' '\nВеликий Новгород, Ул. Щусева д.7',
    'Магазин “Амелия\"' '\nВеликий Новгород, Ул. Б. Московская д.124',
  ];
  // List km = ["1.82 км", "4.5 км", "1.22 км", "12.5 км"];
  int selectedIndex;

  String _address = '';

  _handleAddress() {
    _address = addresses[selectedIndex];
    widget.onPop(_address);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   '4 магазина для получения заказа',
          //   style: Theme.of(context).textTheme.subtitle1,
          // ),
          SizedBox(
            height: 8,
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: addresses.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, int index) {
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                      _handleAddress();
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          child: selectedIndex == index
                              ? SvgPicture.asset(
                                  'assets/icons/radio_button_checked.svg',
                                  color: neutral_500,
                                  width: 24,
                                  height: 24,
                                  fit: BoxFit.scaleDown,
                                )
                              : SvgPicture.asset(
                                  'assets/icons/radio_button_unchecked.svg',
                                  color: neutral_500,
                                  width: 24,
                                  height: 24,
                                  fit: BoxFit.scaleDown,
                                ),
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              addresses[index],
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            // SizedBox(
                            //   height: 6,
                            // ),
                            // Text(
                            //   km[index],
                            //   style: Theme.of(context)
                            //       .textTheme
                            //       .bodyText2
                            //       .merge(
                            //           TextStyle(fontWeight: FontWeight.w500)),
                            // ),
                          ],
                        )),
                      ],
                    ),
                  ),
                  index == addresses.length - 1
                      ? SizedBox()
                      : SizedBox(
                          height: 8,
                        )
                ],
              );
            },
          ),
          SizedBox(
            height: 16,
          ),
          PrimaryButton(
            icon: null,
            small: false,
            text: "Выбрать",
            onPressed: () {
              Navigator.of(context).pop();
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
        ],
      ),
    );
  }
}
