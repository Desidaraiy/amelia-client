import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:markets/src/helpers/colors.dart';

import '../helpers/helper.dart';
import '../helpers/swipe_widget.dart';
import '../models/notification.dart' as model;

class NotificationItemWidget extends StatelessWidget {
  final model.Notification notification;

  NotificationItemWidget(
      {Key key,
      this.notification,})
      : super(key: key);
  bool isToday() {
    final now = DateTime.now();
    return now.day == this.notification.createdAt.day &&
        now.month == this.notification.createdAt.month &&
        now.year == this.notification.createdAt.year;
  }

  bool isYesterday() {
    final yesterday = DateTime.now().subtract(Duration(days: 1));
    return yesterday.day == notification.createdAt.day &&
        yesterday.month == notification.createdAt.month &&
        yesterday.year == notification.createdAt.year;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: primary_50),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            'assets/img/delivered.png',
          ),
          SizedBox(width: 16),
          Flexible(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        Helper.of(context).trans(notification.type),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.justify,
                        style: Theme.of(context).textTheme.bodyText2.merge(
                            TextStyle(
                                fontWeight: notification.read
                                    ? FontWeight.w400
                                    : FontWeight.w500,
                                color: primary_700)),
                      ),
                      SizedBox(height: 4),
                      Text(
                        isToday()
                            ? "Сегодня в " +
                                DateFormat('HH:mm')
                                    .format(notification.createdAt)
                            : isYesterday()
                                ? "Вчера в " +
                                    DateFormat('HH:mm')
                                        .format(notification.createdAt)
                                : DateFormat('EEEE, d MMMM, ''yyyy','ru_RU')
                                    .format(notification.createdAt),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .merge(TextStyle(color: neutral_200)),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 16),
                SvgPicture.asset(
                  'assets/icons/navigate_next_200.svg',
                  height: 24,
                  width: 24,
                  fit: BoxFit.scaleDown,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
