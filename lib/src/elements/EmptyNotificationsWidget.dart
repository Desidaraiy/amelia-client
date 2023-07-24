import 'dart:async';

import 'package:flutter/material.dart';
import 'package:markets/src/helpers/colors.dart';

import '../../generated/l10n.dart';
import '../helpers/app_config.dart' as config;

class EmptyNotificationsWidget extends StatefulWidget {
  EmptyNotificationsWidget({
    Key key,
  }) : super(key: key);

  @override
  _EmptyNotificationsWidgetState createState() => _EmptyNotificationsWidgetState();
}

class _EmptyNotificationsWidgetState extends State<EmptyNotificationsWidget> {
  bool loading = true;

  @override
  void initState() {
    Timer(Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        loading
            ? SizedBox(
                height: 3,
                child: LinearProgressIndicator(
                  backgroundColor: Theme.of(context).accentColor.withOpacity(0.2),
                ),
              )
            : SizedBox(),
        Container(
          alignment: AlignmentDirectional.center,
          padding: EdgeInsets.symmetric(horizontal: 30),
          height: config.App(context).appHeight(70),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                'assets/img/notifications.png',

                // fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Text(
                S.of(context).dont_have_any_item_in_the_notification_list,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(height: 6),
              Text(
                S.of(context).here_notifications,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4.merge(
                    TextStyle(color: neutral_200, fontWeight: FontWeight.w400)),
              ),
              SizedBox(height: 24),
              !loading
                  ? MaterialButton(
                      elevation: 0,
                      onPressed: () {
                        Navigator.of(context).pushNamed('/Pages', arguments: 0);
                      },
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                      color: Theme.of(context).accentColor.withOpacity(1),
                      shape: StadiumBorder(),
                      child: Text(
                        S.of(context).start_exploring,
                        style: Theme.of(context).textTheme.headline6.merge(TextStyle(color: Theme.of(context).scaffoldBackgroundColor)),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ],
    );
  }
}
