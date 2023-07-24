import 'package:flutter_svg/svg.dart';
import 'package:markets/src/helpers/colors.dart';

import '../../generated/l10n.dart';
import 'package:flutter/material.dart';

import 'AlertDialogWidget.dart';
import 'DeleteLabelWidget.dart';
import 'PrimaryButtonWidget.dart';

class SavedUsersDeliveryAddressesWidget extends StatefulWidget {
  const SavedUsersDeliveryAddressesWidget({Key key}) : super(key: key);

  @override
  _SavedUsersDeliveryAddressesWidgetState createState() =>
      _SavedUsersDeliveryAddressesWidgetState();
}

class _SavedUsersDeliveryAddressesWidgetState
    extends State<SavedUsersDeliveryAddressesWidget> {
  List addresses = [
    "г. Великий Новгород, улица Космонавтов, 36, подъезд 2, этаж 6, квартира 21",
    "г. Великий Новгород, улица Ломоносова, 39, подъезд 1, этаж 3, квартира 14",
    "г. Великий Новгород, улица Химиков, 14к1, подъезд 3, этаж 1, квартира 40"
  ];
  int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  '3 адреса доставки',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              GestureDetector(
                  onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialogWidget(
                            title: "Удалить все адреса?",
                            onYes: "Удалить",
                          )),
                  child: DeleteLabel(small: true, title: "Удалить все"))
            ],
          ),
          SizedBox(
            height: 8,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
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
                            child: Text(
                          addresses[index],
                          style: Theme.of(context).textTheme.bodyText2,
                        )),
                        SvgPicture.asset(
                          'assets/icons/close_24.svg',
                          color: neutral_150,
                          width: 24,
                          height: 24,
                          fit: BoxFit.scaleDown,
                        )
                      ],
                    ),
                  ),
                  index == addresses.length-1
                      ? SizedBox(

                        )
                      : SizedBox(height: 8,)
                ],
              );
            },
          ),
          SizedBox(height: 16,),
          PrimaryButton(
            icon: null,
            small: false,
            text: "Выбрать",
            onPressed: () {
              Navigator.of(context)
                  .pop();
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
