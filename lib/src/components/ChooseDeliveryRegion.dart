import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/helpers/colors.dart';

import '../../generated/l10n.dart';
import 'PrimaryButtonWidget.dart';

class ChooseDeliveryRegionWidget extends StatefulWidget {
  const ChooseDeliveryRegionWidget({this.onPop});
  final Function(String, String) onPop;
  @override
  State<ChooseDeliveryRegionWidget> createState() =>
      _ChooseDeliveryRegionWidgetState();
}

class _ChooseDeliveryRegionWidgetState
    extends State<ChooseDeliveryRegionWidget> {
  List addresses = [
    "Бронница",
    "Новоселицы, Борки, Горное",
    "р. Морено, Ильмень",
    "Чечулено, Божонка, Губарево",
    "Савино,Кречевицы",
    "Старое Ракомо, Ермолино, Хутынь, Трубичино 2",
    "Деревяницы 2, Шолохово, Волот, Плетниха",
    "В черте города"
  ];
  List km = ["750", "600", "600", "550", "400", "350", "300", "250"];
  int selectedPrice;
  int selectedIndex;

  String _address = '';
  String _price = '';

  _handleAddress() {
    _address = addresses[selectedIndex];
    _price = km[selectedPrice];
    widget.onPop(_address, _price);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                        selectedPrice = index;
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
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              '${km[index]} ₽',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .merge(
                                      TextStyle(fontWeight: FontWeight.w500)),
                            ),
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
