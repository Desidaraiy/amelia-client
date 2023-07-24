import 'package:flutter/material.dart';
import 'package:markets/src/components/AlertDialogWidget.dart';
import 'package:markets/src/components/DeleteLabelWidget.dart';
import 'package:markets/src/helpers/colors.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/notification_controller.dart';
import '../elements/EmptyNotificationsWidget.dart';
import '../elements/NotificationItemWidget.dart';
import '../elements/PermissionDeniedWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../repository/user_repository.dart';

class NotificationsWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  NotificationsWidget({Key key, this.parentScaffoldKey}) : super(key: key);
  @override
  _NotificationsWidgetState createState() => _NotificationsWidgetState();
}

class _NotificationsWidgetState extends StateMVC<NotificationsWidget> {
  NotificationController _con;

  _NotificationsWidgetState() : super(NotificationController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForNotifications();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      key: _con.scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primary_50,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).notifications,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: currentUser.value.apiToken == null
          ? PermissionDeniedWidget()
          : RefreshIndicator(
              onRefresh: _con.refreshNotifications,
              child: _con.newNotifications.isEmpty &&
                      _con.oldNotifications.isEmpty
                  ? EmptyNotificationsWidget()
                  : ListView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      children: <Widget>[
                        _con.newNotifications.isNotEmpty
                            ? Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          "${_con.newNotifications.length - 1} новых уведомлений",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: () => showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialogWidget(
                                                    title:
                                                        "Удалить все уведомления?",
                                                    onYes: "Удалить",
                                                  )),
                                          child: DeleteLabel(
                                              small: true,
                                              title: "Удалить все"))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                ],
                              )
                            : SizedBox(),
                        _con.newNotifications.length != 0
                            ? ListView.separated(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                primary: false,
                                itemCount: _con.newNotifications.length - 1,
                                separatorBuilder: (context, index) {
                                  return SizedBox(height: 8);
                                },
                                itemBuilder: (context, index) {
                                  return NotificationItemWidget(
                                    notification:
                                        _con.newNotifications.elementAt(index),
                                  );
                                },
                              )
                            : SizedBox(),
                        Column(
                          children: [
                            _con.newNotifications.isEmpty &&
                                    _con.oldNotifications.isNotEmpty
                                ? SizedBox()
                                : SizedBox(
                                    height: 16,
                                  ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: _con.oldNotifications.isNotEmpty
                                      ? Text(
                                          "Старые уведомления",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                        )
                                      : SizedBox(),
                                ),
                                _con.newNotifications.isEmpty &&
                                        _con.oldNotifications.isNotEmpty
                                    ? GestureDetector(
                                        onTap: () => showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialogWidget(
                                                  title:
                                                      "Удалить все уведомления?",
                                                  onYes: "Удалить",
                                                )),
                                        child: DeleteLabel(
                                            small: true, title: "Удалить все"))
                                    : SizedBox()
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                        ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          primary: false,
                          itemCount: _con.newNotifications.length - 1,
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 8);
                          },
                          itemBuilder: (context, index) {
                            return NotificationItemWidget(
                              notification:
                                  _con.newNotifications.elementAt(index),
                            );
                          },
                        ),
                      ],
                    ),
            ),
    );
  }
}
