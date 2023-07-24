import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/helpers/colors.dart';

import '../../generated/l10n.dart';
import 'PrimaryButtonWidget.dart';
import 'ModalBottomSheetWidget.dart';
import 'RatingWidget.dart';

class FilterFormWidget extends StatefulWidget {
  const FilterFormWidget({Key key}) : super(key: key);

  @override
  _FilterFormWidgetState createState() => _FilterFormWidgetState();
}

enum ProductRating {
  highest,
  average,
  lowest,
}

class _FilterFormWidgetState extends State<FilterFormWidget> {
  int selectedIndex;
  int selectedIndexVariety;

  int selectedIndexRecipients;
  int selectedIndexColors;
  double minPrice = 250;
  double maxPrice = 7560;
  RangeValues _currentRangeValues = RangeValues(250, 7560);

  List<String> occasions = [
    "Просто так",
    "День рождения",
    "Свадьба",
    "Свидание",
  ];
  List<String> variety = ["Розы", "Лилии", "Ирисы", "Хризантемы", "Подсолнухи"];

  List<String> recipients = [
    "Маме",
    "Любимой",
    "Женщине",
    "Бизнес партнеру",
    "Учителю"
  ];

  List<String> colors = [
    "Белый",
    "Розовый",
    "Голубой",
    "Синий",
  ];

  List<Color> colorHex = [
    Color(0xFFECE2E2),
    Color(0xFFFAA69B),
    Color(0xFF82B6EE),
    Color(0xFF3167B9),
  ];

  List<Color> borderHex = [
    Color(0xFFB0CAE4),
    Color(0xFFFFFF),
    Color(0xFFFFFF),
    Color(0xFFFFFF),
  ];

  int selectedRating;
  int selectedIndexVarietyAll;
  List<String> varietyAll = [
    "Герберы",
    "Гортензии",
    "Альстромерии",
    "Каллы",
    "Розы",
    "Лилии",
    "Ирисы",
    "Хризантемы",
    "Подсолнухи",
  ];
  List<String> selectedVariety = [];

  bool selected = false;
  @override
  Widget build(BuildContext context) {
    // ProductRating productRating = ProductRating.highest;

    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: Column(
        children: [
          Wrap(
            runSpacing: 20,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            S.of(context).occasion,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                        Text(
                          S.of(context).show_all,
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .merge(TextStyle(color: neutral_500)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 32,
                    child: ListView.builder(
                      itemCount: occasions.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, int index) {
                        return Row(
                          children: [
                            index == 0
                                ? SizedBox(
                                    width: 16,
                                  )
                                : SizedBox(),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                  print(occasions[index]);
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: selectedIndex == index
                                        ? Border.all(color: secondary_300)
                                        : Border.all(style: BorderStyle.none),
                                    color: selectedIndex == index
                                        ? secondary_100
                                        : primary_50,
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Padding(
                                  padding: selectedIndex == index
                                      ? EdgeInsets.fromLTRB(12, 3, 12, 5)
                                      : EdgeInsets.fromLTRB(12, 3, 12, 5),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      selectedIndex == index
                                          ? Row(
                                              children: [
                                                SvgPicture.asset(
                                                    'assets/icons/done_300_24.svg',
                                                    color: secondary_300),
                                                SizedBox(
                                                  width: 8,
                                                )
                                              ],
                                            )
                                          : SizedBox(
                                              height: 24,
                                            ),
                                      Text(occasions[index],
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption
                                              .merge(TextStyle(
                                                  height: 1.3,
                                                  color: selectedIndex == index
                                                      ? secondary_300
                                                      : neutral_350)))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            index != occasions.length - 1
                                ? SizedBox(
                                    width: 8,
                                  )
                                : SizedBox(),
                            index == occasions.length - 1
                                ? SizedBox(
                                    width: 16,
                                  )
                                : SizedBox(),
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Divider(
                  color: expanded_light_neutral_100,
                  height: 1.5,
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            S.of(context).variety,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            return showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (_) {
                                  return ModalBottomSheetWidget(
                                    title: "Все цветы",
                                    showAll: true,
                                    maxChildSize: 0.75,
                                    initialChildSize: 0.45,
                                    widget: Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20.0),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16, top: 16, right: 8),
                                            child: Wrap(
                                                alignment: WrapAlignment.start,
                                                direction: Axis.horizontal,
                                                runSpacing: 8,
                                                spacing: 8,
                                                children: [
                                                  ...List.generate(
                                                    varietyAll.length,
                                                    (index) {
                                                      return StatefulBuilder(
                                                          builder: (BuildContext
                                                                  context,
                                                              StateSetter
                                                                  setState) {
                                                        return InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              selectedVariety
                                                                      .contains(
                                                                          varietyAll[
                                                                              index])
                                                                  ? selectedVariety.remove(
                                                                      varietyAll[
                                                                          index])
                                                                  : selectedVariety.add(
                                                                      varietyAll[
                                                                          index]);
                                                            });
                                                          },
                                                          child:
                                                              UnconstrainedBox(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  border: selectedVariety.contains(
                                                                          varietyAll[
                                                                              index])
                                                                      ? Border.all(
                                                                          color:
                                                                              secondary_300)
                                                                      : Border.all(
                                                                          style: BorderStyle
                                                                              .none),
                                                                  color: selectedVariety.contains(
                                                                          varietyAll[
                                                                              index])
                                                                      ? secondary_100
                                                                      : primary_50,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5.0)),
                                                              child: Padding(
                                                                padding: selectedVariety.contains(
                                                                        varietyAll[
                                                                            index])
                                                                    ? EdgeInsets
                                                                        .fromLTRB(
                                                                            12,
                                                                            3,
                                                                            12,
                                                                            5)
                                                                    : EdgeInsets
                                                                        .fromLTRB(
                                                                            12,
                                                                            3,
                                                                            12,
                                                                            5),
                                                                child: Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    selectedVariety
                                                                            .contains(varietyAll[index])
                                                                        ? Row(
                                                                            children: [
                                                                              SvgPicture.asset('assets/icons/done_300_24.svg', color: secondary_300),
                                                                              SizedBox(
                                                                                width: 8,
                                                                              )
                                                                            ],
                                                                          )
                                                                        : SizedBox(
                                                                            height:
                                                                                24,
                                                                          ),
                                                                    Text(
                                                                        varietyAll[
                                                                            index],
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .caption
                                                                            .merge(TextStyle(
                                                                                height: 1.3,
                                                                                color: selectedVariety.contains(varietyAll[index]) ? secondary_300 : neutral_350)))
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                    },
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8, bottom: 16),
                                                    child: PrimaryButton(
                                                      icon: null,
                                                      small: false,
                                                      text: "Применить",
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pushReplacementNamed(
                                                                '/Pages',
                                                                arguments: 0);
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
                                                  )
                                                ]),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Text(
                            S.of(context).show_all,
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .merge(TextStyle(color: neutral_500)),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 32,
                    child: ListView.builder(
                      itemCount: variety.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, int index) {
                        return Row(
                          children: [
                            index == 0
                                ? SizedBox(
                                    width: 16,
                                  )
                                : SizedBox(),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndexVariety = index;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: selectedIndexVariety == index
                                        ? Border.all(color: secondary_300)
                                        : Border.all(style: BorderStyle.none),
                                    color: selectedIndexVariety == index
                                        ? secondary_100
                                        : primary_50,
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Padding(
                                  padding: selectedIndexVariety == index
                                      ? EdgeInsets.fromLTRB(12, 3, 12, 5)
                                      : EdgeInsets.fromLTRB(12, 3, 12, 5),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      selectedIndexVariety == index
                                          ? Row(
                                              children: [
                                                SvgPicture.asset(
                                                    'assets/icons/done_300_24.svg',
                                                    color: secondary_300),
                                                SizedBox(
                                                  width: 8,
                                                )
                                              ],
                                            )
                                          : SizedBox(
                                              height: 24,
                                            ),
                                      Text(variety[index],
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption
                                              .merge(TextStyle(
                                                  height: 1.3,
                                                  color: selectedIndexVariety ==
                                                          index
                                                      ? secondary_300
                                                      : neutral_350)))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            index != variety.length - 1
                                ? SizedBox(
                                    width: 8,
                                  )
                                : SizedBox(),
                            index == variety.length - 1
                                ? SizedBox(
                                    width: 16,
                                  )
                                : SizedBox(),
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Divider(
                  color: expanded_light_neutral_100,
                  height: 1.5,
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            S.of(context).recipients,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                        Text(
                          S.of(context).show_all,
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .merge(TextStyle(color: neutral_500)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 32,
                    child: ListView.builder(
                      itemCount: recipients.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, int index) {
                        return Row(
                          children: [
                            index == 0
                                ? SizedBox(
                                    width: 16,
                                  )
                                : SizedBox(),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndexRecipients = index;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: selectedIndexRecipients == index
                                        ? Border.all(color: secondary_300)
                                        : Border.all(style: BorderStyle.none),
                                    color: selectedIndexRecipients == index
                                        ? secondary_100
                                        : primary_50,
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Padding(
                                  padding: selectedIndexRecipients == index
                                      ? EdgeInsets.fromLTRB(12, 3, 12, 5)
                                      : EdgeInsets.fromLTRB(12, 3, 12, 5),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      selectedIndexRecipients == index
                                          ? Row(
                                              children: [
                                                SvgPicture.asset(
                                                    'assets/icons/done_300_24.svg',
                                                    color: secondary_300),
                                                SizedBox(
                                                  width: 8,
                                                )
                                              ],
                                            )
                                          : SizedBox(
                                              height: 24,
                                            ),
                                      Text(recipients[index],
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption
                                              .merge(TextStyle(
                                                  height: 1.3,
                                                  color:
                                                      selectedIndexRecipients ==
                                                              index
                                                          ? secondary_300
                                                          : neutral_350)))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            index != recipients.length - 1
                                ? SizedBox(
                                    width: 8,
                                  )
                                : SizedBox(),
                            index == recipients.length - 1
                                ? SizedBox(
                                    width: 16,
                                  )
                                : SizedBox(),
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Divider(
                  color: expanded_light_neutral_100,
                  height: 1.5,
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            S.of(context).color,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                        Text(
                          S.of(context).show_all,
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .merge(TextStyle(color: neutral_500)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 32,
                    child: ListView.builder(
                      itemCount: colors.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, int index) {
                        return Row(
                          children: [
                            index == 0
                                ? SizedBox(
                                    width: 16,
                                  )
                                : SizedBox(),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndexColors = index;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: selectedIndexColors == index
                                        ? Border.all(color: secondary_300)
                                        : Border.all(style: BorderStyle.none),
                                    color: selectedIndexColors == index
                                        ? secondary_100
                                        : primary_50,
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Padding(
                                  padding: selectedIndexColors == index
                                      ? EdgeInsets.fromLTRB(12, 5, 12, 7)
                                      : EdgeInsets.fromLTRB(12, 5, 12, 7),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                                color: colorHex[index],
                                                borderRadius:
                                                    BorderRadius.circular(3.0),
                                                border: Border.all(
                                                    color: borderHex[index])),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          )
                                        ],
                                      ),
                                      Text(colors[index],
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption
                                              .merge(TextStyle(
                                                  height: 1.3,
                                                  color: selectedIndexColors ==
                                                          index
                                                      ? secondary_300
                                                      : neutral_350)))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            index != colors.length - 1
                                ? SizedBox(
                                    width: 8,
                                  )
                                : SizedBox(),
                            index == colors.length - 1
                                ? SizedBox(
                                    width: 16,
                                  )
                                : SizedBox(),
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Divider(
                  color: expanded_light_neutral_100,
                  height: 1.5,
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            S.of(context).price,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              minPrice.toInt().toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .merge(TextStyle(
                                      color: neutral_500,
                                      fontWeight: FontWeight.w300)),
                            ),
                            SizedBox(
                              width: 1,
                            ),
                            Text(
                              "–",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .merge(TextStyle(
                                      color: neutral_500,
                                      fontWeight: FontWeight.w300)),
                            ),
                            SizedBox(
                              width: 1,
                            ),
                            Text(
                              maxPrice.toInt().toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .merge(TextStyle(
                                      color: neutral_500,
                                      fontWeight: FontWeight.w300)),
                            ),
                            SizedBox(
                              width: 1,
                            ),
                            Text(
                              "₽",
                              style: Theme.of(context)
                                  .textTheme
                                  .overline
                                  .merge(TextStyle(color: neutral_500)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  RangeSlider(
                    min: 250,
                    inactiveColor: neutral_200,
                    activeColor: neutral_500,
                    values: _currentRangeValues,
                    max: 7560,
                    // divisions: 10,
                    labels: RangeLabels(
                      _currentRangeValues.start.round().toString(),
                      _currentRangeValues.end.round().toString(),
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        _currentRangeValues = values;
                        maxPrice = _currentRangeValues.end;
                        minPrice = _currentRangeValues.start;
                      });
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Divider(
                  color: expanded_light_neutral_100,
                  height: 1.5,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                      S.of(context).users_reviews,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 160,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: ListView.builder(
                        itemCount: ProductRating.values.length,
                        // scrollDirection: Axis.vertical,
                        itemBuilder: (context, int index) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedRating = index;
                                    print(ProductRating.values[index]);
                                  });
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: RatingWidget(
                                        stars: 4 - index,
                                      ),
                                    ),
                                    Container(
                                      width: 44,
                                      height: 44,
                                      child: selectedRating == index
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
                                  ],
                                ),
                              ),
                              index == ProductRating.values.length
                                  ? SizedBox()
                                  : SizedBox(
                                      height: 8,
                                    ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: PrimaryButton(
              icon: null,
              small: false,
              text: "Показать 5 результатов",
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed('/Pages', arguments: 0);
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
          )
        ],
      ),
    );
  }
}
