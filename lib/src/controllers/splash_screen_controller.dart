import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
import 'package:markets/src/helpers/maps_util.dart';
import 'package:markets/src/models/address.dart';
import 'package:markets/src/repository/settings_repository.dart' as settingRepo;
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../helpers/custom_trace.dart';
import '../repository/user_repository.dart' as userRepo;

class SplashScreenController extends ControllerMVC {
  ValueNotifier<Map<String, double>> progress = new ValueNotifier(new Map());
  GlobalKey<ScaffoldState> scaffoldKey;
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  SplashScreenController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    // Should define these variables before the app loaded
    progress.value = {"Setting": 0, "User": 0};
  }

  @override
  void initState() async {
    super.initState();
    print("start");
    // Firebase.initializeApp();
    // Firebase.initializeApp().whenComplete(() {
    //   print("fire!");
    //   setState(() {});
    // });
    // firebaseMessaging.requestNotificationPermissions(
    //     const IosNotificationSettings(sound: true, badge: true, alert: true));
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      print('ok firebase messaging');
    });
    configureFirebase(firebaseMessaging);
    settingRepo.setting.addListener(() {
      if (settingRepo.setting.value.appName != null &&
          settingRepo.setting.value.appName != '' &&
          settingRepo.setting.value.mainColor != null) {
        progress.value["Setting"] = 41;
        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
        progress?.notifyListeners();
      }
    });
    userRepo.currentUser.addListener(() {
      if (userRepo.currentUser.value.auth != null) {
        progress.value["User"] = 59;
        progress?.notifyListeners();
      }
    });
    // Timer(Duration(seconds: 60), () {
    //   ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
    //     content: Text(S.of(state.context).verify_your_internet_connection),
    //   ));
    // });
    Timer(Duration(seconds: 60), () {
      final context = scaffoldKey.currentContext;
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(S.of(context).verify_your_internet_connection),
        ));
      }
    });
  }

  void configureFirebase(FirebaseMessaging _firebaseMessaging) {
    try {
      // _firebaseMessaging.configure(
      //   onMessage: notificationOnMessage,
      //   onLaunch: notificationOnLaunch,
      //   onResume: notificationOnResume,
      // );
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        notificationOnMessage(message);
      });
    } catch (e) {
      print('error configuring firebase messaging');
      print(CustomTrace(StackTrace.current, message: e));
      print(CustomTrace(StackTrace.current, message: 'Error Config Firebase'));
    }
  }

  Future notificationOnResume(Map<String, dynamic> message) async {
    try {
      if (message['data']['id'] == "orders") {
        settingRepo.navigatorKey.currentState
            .pushReplacementNamed('/Pages', arguments: 3);
      }
    } catch (e) {
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Future notificationOnLaunch(Map<String, dynamic> message) async {
    String messageId = await settingRepo.getMessageId();
    try {
      if (messageId != message['google.message_id']) {
        if (message['data']['id'] == "orders") {
          await settingRepo.saveMessageId(message['google.message_id']);
          settingRepo.navigatorKey.currentState
              .pushReplacementNamed('/Pages', arguments: 3);
        }
      }
    } catch (e) {
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Future notificationOnMessage(RemoteMessage message) async {
    Fluttertoast.showToast(
      msg: message.notification.title,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 5,
    );
  }
}
