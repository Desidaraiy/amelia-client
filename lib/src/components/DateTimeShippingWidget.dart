import 'package:flutter/material.dart';
import 'package:markets/src/elements/DeliveryDateWidget.dart';
import 'package:markets/src/elements/DeliveryTimeWidget.dart';
import 'package:markets/src/helpers/colors.dart';
import '../../generated/l10n.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../controllers/delivery_pickup_controller.dart';
import 'UserOrderWidget.dart';

class DateTimeShippingWidget extends StatefulWidget {
  const DateTimeShippingWidget({Key key, this.userOrder, this.controller})
      : super(key: key);
  final bool userOrder;
  final DeliveryPickupController controller;
  @override
  _DateTimeShippingWidgetState createState() => _DateTimeShippingWidgetState();
}

class _DateTimeShippingWidgetState extends State<DateTimeShippingWidget> {
  DeliveryPickupController _con;
  int selectedIndex = -1;
  // int selectedIndexDay = 0;
  // int selectedIndexNight = 0;
  DateTime date;
  TimeOfDay time;
  DateTime now = DateTime.now();
  DateTime _displayInCalendar;
  DateTime _tomorrowDate;
  DateTime _dayAfterTomorrowDate;
  bool nightDelivery = false;
  // List<String> scheduleDay = [
  //   "13:00-14:00, 0₽",
  //   "14:00-15:00, 0₽",
  //   "15:00-16:00, 0₽",
  //   "16:00-17:00, 0₽",
  //   "17:00-18:00, 0₽",
  //   "18:00-19:00, 0₽",
  //   "19:00-20:00, 0₽"
  // ];
  // List<String> scheduleNight = [
  //   "23:00-00:00, 500₽",
  //   "00:00-01:00, 500₽",
  //   "01:00-02:00, 500₽"
  // ];

  bool isNightTime(DateTime dateTime) {
    final int hour = dateTime.hour;
    return hour >= 22 || hour < 6;
  }

  void _handleDateShortCuts() {
    switch (selectedIndex) {
      case 0:
        String _date = DateFormat('dd.MM.yyyy').format(now);
        _con.handleThirdStepDate(_date);
        break;
      case 1:
        String _tomorrow = DateFormat('dd.MM.yyyy').format(_tomorrowDate);
        _con.handleThirdStepDate(_tomorrow);
        break;
      case 2:
        String _dayAfterTomorrow =
            DateFormat('dd.MM.yyyy').format(_dayAfterTomorrowDate);
        _con.handleThirdStepDate(_dayAfterTomorrow);
        break;
    }
  }

  void _handleDateFromCalendar() {
    setState(() {
      selectedIndex = 3;
    });
    String _date = DateFormat('dd.MM.yyyy').format(date);
    _con.handleThirdStepDate(_date);
  }

  void _handleTimeeFromPicker(String time, bool isNight) {
    _con.handleThirdStepTime(time, isNight);
  }

  // String getStartTimeByIndex(int index, List<String> array) {
  //   String timeRange = array[index];
  //   List<String> timeParts = timeRange.split('-');
  //   String startTime = timeParts[0].trim();
  //   return startTime;
  // }

  // int findIndexByTime(List<String> array, String time) {
  //   for (int i = 0; i < array.length; i++) {
  //     var range = array[i].split(',')[0].trim();
  //     var start = range.split('-')[0].trim();
  //     if (start == time) {
  //       return i;
  //     }
  //   }
  //   return -1;
  // }

  // void _handleTimeShortCuts(int type) {
  //   List<String> array;
  //   int index;
  //   if (type == 0) {
  //     // day
  //     array = scheduleDay;
  //     index = selectedIndexDay;
  //     selectedIndexNight = -1;
  //   } else {
  //     // night
  //     array = scheduleNight;
  //     index = selectedIndexNight;
  //     selectedIndexDay = -1;
  //   }
  //   String _time = getStartTimeByIndex(index, array);
  //   _con.handleThirdStepTime(_time);
  // }

  // void _initTimeOfDelivery() {
  //   setState(() {
  //     if (_con.deliveryDate.isEmpty || _con.deliveryTime.isEmpty) {
  //       String _date = DateFormat('dd.MM.yyyy').format(now);
  //       String _time = DateFormat('kk:mm').format(now);
  //       _con.handleThirdStepDate(_date);
  //       _con.handleThirdStepTime(_time);
  //     } else {
  //       String _time = _con.deliveryTime;
  //       if (findIndexByTime(scheduleDay, _time) != -1) {
  //         selectedIndexDay = findIndexByTime(scheduleDay, _time);
  //         selectedIndexNight = -1;
  //       }
  //       if (findIndexByTime(scheduleNight, _time) != -1) {
  //         selectedIndexNight = findIndexByTime(scheduleNight, _time);
  //         selectedIndexDay = -1;
  //       }
  //     }
  //   });
  // }

  void _initTimeOfDelivery() {
    setState(() {
      String _time = _con.getDeliveryTime;
      if (_time.isNotEmpty) {
        List<String> parts = _time.split(" - ");
        int hour = int.parse(parts[0].split(':')[0]);
        int minute = int.parse(parts[0].split(':')[1]);
        TimeOfDay timeOfDay = TimeOfDay(hour: hour, minute: minute);
        nightDelivery = hour >= 22 || hour < 6;
        time = timeOfDay;
      }
    });
  }

  void _initDateOfDelivery() {
    setState(() {
      String _date = _con.deliveryDate;
      if (_date.isNotEmpty) {
        DateTime _dateToDateTime =
            DateTime.parse(_date.split('.').reversed.join('-'));
        selectedIndex = calculateDifference(_dateToDateTime);
        if (selectedIndex > 2) {
          selectedIndex = 3;
          date = _dateToDateTime;
        }
      }
    });
  }

  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      _tomorrowDate = now.add(Duration(days: 1));
      _dayAfterTomorrowDate = now.add(Duration(days: 2));
      _displayInCalendar = now;
      _con = widget.controller;
      _initTimeOfDelivery();
      _initDateOfDelivery();
    });
  }

  @override
  Widget build(BuildContext context) {
    List days = [
      S.of(context).today,
      S.of(context).tomorrow,
      S.of(context).day_after_tomorrow
    ];
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
                    S.of(context).delivery_date,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    S.of(context).choose_day,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: _con.deliveryDateCorrect
                            ? primary_700
                            : semantic_error),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 32,
                    child: ListView.builder(
                      itemCount: days.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, int index) {
                        return Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                                _handleDateShortCuts();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 32,
                                decoration: BoxDecoration(
                                    border: selectedIndex == index
                                        ? Border.all(color: secondary_300)
                                        : Border.all(style: BorderStyle.none),
                                    color: selectedIndex == index
                                        ? secondary_100
                                        : primary_50,
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 12, right: 12),
                                  child: Text(days[index],
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .merge(TextStyle(
                                              height: 1.1,
                                              color: selectedIndex == index
                                                  ? secondary_300
                                                  : neutral_350))),
                                ),
                              ),
                            ),
                            index != days.length - 1
                                ? SizedBox(
                                    width: 8,
                                  )
                                : SizedBox(),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    S.of(context).or_use_calendar,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: _con.deliveryDateCorrect
                            ? primary_700
                            : semantic_error),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  DeliveryDateWidget(
                    active: selectedIndex == 3,
                    calendarText: DateFormat('EEEE, d MMMM, ' 'yyyy', 'ru_RU')
                        .format(_displayInCalendar),
                    onPress: () async {
                      final initDate = DateTime.now();
                      final DateTime newDate = await showDatePicker(
                        initialDatePickerMode: DatePickerMode.day,
                        initialEntryMode: DatePickerEntryMode.calendar,
                        builder: (BuildContext context, Widget child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                              textTheme: TextTheme(
                                ///Месяц
                                subtitle2: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Jost',
                                    fontWeight: FontWeight.w400,
                                    height: 1.2),

                                ///Кнопки
                                button: TextStyle(
                                    fontSize: 17.1,
                                    fontFamily: 'Jost',
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                    height: 1.2),

                                ///Название дня недели и число
                                headline4: TextStyle(
                                    fontSize: 18.22,
                                    fontFamily: 'Jost',
                                    fontWeight: FontWeight.w500,
                                    height: 1.2),

                                ///Дата доставки заказа
                                overline: TextStyle(
                                    fontSize: 12.34,
                                    fontFamily: 'Jost',
                                    height: 1.2,
                                    letterSpacing: 0.2,
                                    fontWeight: FontWeight.w400),

                                ///Числа
                                caption: TextStyle(
                                    fontSize: 14.05,
                                    fontFamily: 'Jost',
                                    height: 1.3,
                                    fontWeight: FontWeight.w400),
                              ),
                              // focusColor: Colors.orange,
                              colorScheme: ColorScheme.light(
                                primary: primary_700,
                                // onSecondary: Colors.indigo,
                                secondary: primary_700,
                                onPrimary: primary_50,
                                surface: primary_700,
                                onSurface: primary_700,
                              ),
                              dialogBackgroundColor: primary_50,
                            ),
                            child: child,
                          );
                        },
                        locale: Locale('ru', 'RU'),
                        cancelText: "Отмена",
                        confirmText: "Выбрать",
                        helpText: "Выберите день доставки",
                        context: context,
                        initialDate: initDate,
                        firstDate: DateTime.now().subtract(Duration(days: 0)),
                        lastDate: DateTime(DateTime.now().year + 1),
                      );

                      // if 'Cancel' => null
                      if (newDate == null) return;

                      setState(() {
                        date = newDate;
                        _handleDateFromCalendar();
                      });
                    },
                    date: date,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    // S.of(context).delivery_time,
                    "Время получения",
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: _con.deliveryTimeCorrect
                            ? primary_700
                            : semantic_error),
                  ),

                  ///Время получения заказа
                  // Text(
                  //   S.of(context).pickup_time,
                  //   style: Theme.of(context).textTheme.subtitle1,
                  // ),

                  // SizedBox(
                  //   height: 4,
                  // ),
                  // Text(
                  //   S.of(context).available_time_from +
                  //       " 16:34 " +
                  //       S.of(context).available_time_to +
                  //       " 23:00",
                  //   style: Theme.of(context).textTheme.bodyText2,
                  // ),
                  SizedBox(
                    height: 8,
                  ),

                  ///Часы
                  // DeliveryTimeWidget(
                  //   calendarText: "Время доставки",
                  //   onPress: () async {
                  //     final initDate = DateTime.now();
                  //
                  //     final TimeOfDay newTime = await showTimePicker(
                  //       cancelText: "Отмена",
                  //       confirmText: "Выбрать",
                  //       helpText: "Время получения заказа",
                  //       builder: (BuildContext context, Widget child) {
                  //         return MediaQuery(
                  //             data: MediaQuery.of(context)
                  //                 .copyWith(alwaysUse24HourFormat: true),
                  //             child: Theme(
                  //               data: ThemeData.light().copyWith(
                  //                   textTheme: TextTheme(
                  //                       bodyText1: TextStyle(
                  //                           color: primary_700,
                  //                           fontSize: 14.05,
                  //                           fontFamily: 'Jost',
                  //                           height: 1.1,
                  //                           fontWeight: FontWeight.w400)),
                  //                   textButtonTheme: TextButtonThemeData(
                  //                       style: ButtonStyle(
                  //                           foregroundColor:
                  //                               MaterialStateColor.resolveWith(
                  //                                   (states) => primary_700),
                  //                           textStyle: MaterialStateProperty
                  //                               .resolveWith((states) =>
                  //                                   Theme.of(context)
                  //                                       .textTheme
                  //                                       .button))),
                  //                   timePickerTheme: TimePickerThemeData(
                  //                     backgroundColor: primary_50,
                  //                     hourMinuteColor:
                  //                         MaterialStateColor.resolveWith(
                  //                             (states) => states.contains(
                  //                                     MaterialState.selected)
                  //                                 ? primary_700
                  //                                     .withOpacity(0.20)
                  //                                 : primary_700
                  //                                     .withOpacity(0.15)),
                  //                     hourMinuteTextColor:
                  //                         MaterialStateColor.resolveWith(
                  //                             (states) => states.contains(
                  //                                     MaterialState.selected)
                  //                                 ? primary_700
                  //                                 : primary_700
                  //                                     .withOpacity(0.80)),
                  //                     dialHandColor: primary_700,
                  //                     dialBackgroundColor:
                  //                         primary_700.withOpacity(0.20),
                  //                     hourMinuteTextStyle: TextStyle(
                  //                         fontSize: 57,
                  //                         fontFamily: 'Jost',
                  //                         fontWeight: FontWeight.w400,
                  //                         height: 1.2),
                  //                     helpTextStyle: TextStyle(
                  //                         fontSize: 12.34,
                  //                         color: primary_700,
                  //                         fontFamily: 'Jost',
                  //                         height: 1.2,
                  //                         letterSpacing: 0.2,
                  //                         fontWeight: FontWeight.w400),
                  //                     dialTextColor:
                  //                         MaterialStateColor.resolveWith(
                  //                             (states) => states.contains(
                  //                                     MaterialState.selected)
                  //                                 ? primary_50
                  //                                 : primary_700),
                  //                     entryModeIconColor: primary_700,
                  //                   )),
                  //               child: child,
                  //             ));
                  //       },
                  //       initialTime: TimeOfDay.now(),
                  //       context: context,
                  //     );
                  //
                  //     // if 'Cancel' => null
                  //     if (newTime == null) return;
                  //     //of Ok =>DateTime
                  //     setState(() {
                  //       time = newTime;
                  //
                  //       // final delivery_time = DateTime(
                  //       //   // date.year,
                  //       //   // date.month,
                  //       //   // date.day,
                  //       //   time.hour,time.minute
                  //       //   // DateTime.now().second,
                  //       // );
                  //       print("delivery time ${time}");
                  //     });
                  //   },
                  //   time: time,
                  // ),
                  // SizedBox(
                  //   height: 4,
                  // ),
                  ///Если не выбрано время самовывоза
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16),
                  //   child: Text(
                  //     S.of(context).choose_pickup_time,
                  //     style: Theme.of(context)
                  //         .textTheme
                  //         .caption
                  //         .merge(TextStyle(color: semantic_error)),
                  //   ),
                  // ),
                  DeliveryTimeWidget(
                    onPress: () async {
                      DatePicker.showTimePicker(context,
                          showTitleActions: true,
                          showSecondsColumn: false,
                          theme: DatePickerTheme(
                              doneStyle: TextStyle(
                                  color: secondary_300, fontSize: 18.0)),
                          locale: LocaleType.ru, onConfirm: (date) {
                        String _hour =
                            date.hour < 10 ? '0${date.hour}' : '${date.hour}';
                        String _minute = date.minute < 10
                            ? '0${date.minute}'
                            : '${date.minute}';
                        String _time = "$_hour:$_minute";
                        bool isNight = isNightTime(date);
                        setState(() {
                          nightDelivery = isNight;
                          time = TimeOfDay.fromDateTime(date);
                          _handleTimeeFromPicker(_time, isNight);
                        });
                      }, currentTime: date);

                      // if 'Cancel' => null
                      // if (newDate == null) return;

                      // setState(() {
                      //   date = newDate;
                      //   _handleDateFromCalendar();
                      // });
                    },
                    time: time,
                  ),
                ],
              ),
            ),
            nightDelivery
                ? Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, top: 16.0, right: 16.0),
                    child: Text(
                      'Выбрана ночная доставка, цена на доставку повышена в 2 раза',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  )
                : Container(),
            // SizedBox(
            //   height: 32,
            //   child: ListView.builder(
            //     itemCount: scheduleDay.length,
            //     scrollDirection: Axis.horizontal,
            //     itemBuilder: (context, int index) {
            //       return Row(
            //         children: [
            //           index == 0
            //               ? SizedBox(
            //                   width: 16,
            //                 )
            //               : SizedBox(),
            //           InkWell(
            //             onTap: () {
            //               setState(() {
            //                 selectedIndexDay = index;
            //                 _handleTimeShortCuts(0);
            //               });
            //             },
            //             child: Container(
            //               alignment: Alignment.center,
            //               height: 32,
            //               decoration: BoxDecoration(
            //                   border: selectedIndexDay == index
            //                       ? Border.all(color: secondary_300)
            //                       : Border.all(style: BorderStyle.none),
            //                   color: selectedIndexDay == index
            //                       ? secondary_100
            //                       : primary_50,
            //                   borderRadius: BorderRadius.circular(5.0)),
            //               child: Padding(
            //                 padding: EdgeInsets.only(left: 12, right: 12),
            //                 child: Text(scheduleDay[index],
            //                     style: Theme.of(context)
            //                         .textTheme
            //                         .caption
            //                         .merge(TextStyle(
            //                             height: 1.25,
            //                             color: selectedIndexDay == index
            //                                 ? secondary_300
            //                                 : neutral_350))),
            //               ),
            //             ),
            //           ),
            //           index != scheduleDay.length - 1
            //               ? SizedBox(
            //                   width: 8,
            //                 )
            //               : SizedBox(),
            //           index == scheduleDay.length - 1
            //               ? SizedBox(
            //                   width: 16,
            //                 )
            //               : SizedBox(),
            //         ],
            //       );
            //     },
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       SizedBox(
            //         height: 8,
            //       ),
            //       Text(
            //         S.of(context).available_time_from +
            //             " 23:00 " +
            //             S.of(context).available_time_to +
            //             " 7:00",
            //         style: Theme.of(context).textTheme.bodyText2,
            //       ),
            //       SizedBox(
            //         height: 8,
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 32,
            //   child: ListView.builder(
            //     itemCount: scheduleNight.length,
            //     scrollDirection: Axis.horizontal,
            //     itemBuilder: (context, int index) {
            //       return Row(
            //         children: [
            //           index == 0
            //               ? SizedBox(
            //                   width: 16,
            //                 )
            //               : SizedBox(),
            //           InkWell(
            //             onTap: () {
            //               setState(() {
            //                 selectedIndexNight = index;
            //                 _handleTimeShortCuts(1);
            //               });
            //             },
            //             child: Container(
            //               alignment: Alignment.center,
            //               height: 32,
            //               decoration: BoxDecoration(
            //                   border: selectedIndexNight == index
            //                       ? Border.all(color: secondary_300)
            //                       : Border.all(style: BorderStyle.none),
            //                   color: selectedIndexNight == index
            //                       ? secondary_100
            //                       : primary_50,
            //                   borderRadius: BorderRadius.circular(5.0)),
            //               child: Padding(
            //                 padding: EdgeInsets.only(left: 12, right: 12),
            //                 child: Text(scheduleNight[index],
            //                     style: Theme.of(context)
            //                         .textTheme
            //                         .caption
            //                         .merge(TextStyle(
            //                             height: 1.25,
            //                             color: selectedIndexNight == index
            //                                 ? secondary_300
            //                                 : neutral_350))),
            //               ),
            //             ),
            //           ),
            //           index != scheduleNight.length - 1
            //               ? SizedBox(
            //                   width: 8,
            //                 )
            //               : SizedBox(),
            //           index == scheduleNight.length - 1
            //               ? SizedBox(
            //                   width: 16,
            //                 )
            //               : SizedBox(),
            //         ],
            //       );
            //     },
            //   ),
            // ),
            widget.userOrder
                ? Column(
                    children: [
                      SizedBox(
                        height: 20,
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
                    ],
                  )
                : SizedBox(),

            // widget.userOrder
            //     ? UserOrderWidget(
            //   price: true,
            // )
            //     : SizedBox(),
          ],
        ),
      ),
    );
  }
}
