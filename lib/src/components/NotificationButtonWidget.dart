import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/controllers/notification_controller.dart';
import 'package:markets/src/helpers/colors.dart';
import 'package:markets/src/models/route_argument.dart';
import 'package:markets/src/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class NotificationButtonWidget extends StatefulWidget {
  const NotificationButtonWidget({Key key}) : super(key: key);

  @override
  _NotificationButtonWidgetState createState() =>
      _NotificationButtonWidgetState();
}

class _NotificationButtonWidgetState
    extends StateMVC<NotificationButtonWidget> {
  _NotificationButtonWidgetState() : super(NotificationController()) {
    _con = controller;
  }

  NotificationController _con;

  @override
  void initState() {
    _con.listenForNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (currentUser.value.apiToken != null) {
          Navigator.of(context).pushNamed('/Notifications',
              arguments: RouteArgument(param: '/Pages', id: '0'));
        } else {
          Navigator.of(context).pushNamed('/Login');
        }
      },
      color: Colors.transparent,
      icon: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: <Widget>[
          SvgPicture.asset('assets/icons/notification.svg'),
          _con.newNotifications.length != 0
              ? Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                      color: expanded_red_450,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  width: 14,
                  height: 14,
                  child: Text(
                    _con.newNotifications.length >= 5
                        ? "5+"
                        : (_con.newNotifications.length - 1).toString(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.caption.merge(
                          TextStyle(
                              color: primary_50, fontSize: 10, height: 1.2),
                        ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
