import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:markets/src/helpers/colors.dart';
import 'package:markets/src/components/SimpleDialogWidget.dart';

import 'generated/l10n.dart';
import 'route_generator.dart';
import 'src/helpers/app_config.dart' as config;
import 'src/helpers/custom_trace.dart';
import 'src/models/setting.dart';
import 'src/repository/settings_repository.dart' as settingRepo;
import 'src/repository/user_repository.dart' as userRepo;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Firebase.initializeApp();
  await GlobalConfiguration().loadFromAsset("configurations");
  print(CustomTrace(StackTrace.current,
      message: "base_url: ${GlobalConfiguration().getValue('base_url')}"));
  print(CustomTrace(StackTrace.current,
      message:
          "api_base_url: ${GlobalConfiguration().getValue('api_base_url')}"));
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

// Address _address = new Address();
// String _addressName = await mapsUtil.getAddressName(
//     LatLng(_locationData.latitude, _locationData.longitude),
//     "AIzaSyA2FxilmtaGxZ6g4X3IjSbsaD71-bNfpaI");
// print("address Name ${_addressName ?? "0"}");
// _address = Address.fromJSON({
//   'address': _addressName,
//   'latitude': _locationData.latitude,
//   'longitude': _locationData.longitude
// });
// print("adress ${_address.address ?? "0"} ");
// await settingRepo.changeCurrentLocation(_address);

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    settingRepo.initSettings();
    // settingRepo.getCurrentLocation();
    userRepo.getCurrentUser();
    // settingRepo.location();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: settingRepo.setting,
        builder: (context, Setting _setting, _) {
          return MaterialApp(
              navigatorKey: settingRepo.navigatorKey,
              title: _setting.appName,
              initialRoute: '/Splash',
              onGenerateRoute: RouteGenerator.generateRoute,
              debugShowCheckedModeBanner: false,
              locale: _setting.mobileLanguage.value,
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              theme: ThemeData(
                  fontFamily: 'Jost',
                  primarySwatch: Palette.neutral,
                  cupertinoOverrideTheme: CupertinoThemeData(
                    primaryColor: neutral_500,
                  ),
                  textSelectionTheme: TextSelectionThemeData(
                    cursorColor: neutral_500,
                    selectionColor: neutral_100,
                    selectionHandleColor: neutral_500,
                  ),
                  snackBarTheme: SnackBarThemeData(
                    backgroundColor:
                        secondary_300, // Установите глобальный цвет фона снакбаров
                    contentTextStyle: TextStyle(
                        color:
                            Colors.white), // Установите глобальный цвет текста
                  ),
                  textTheme: TextTheme(
                    button: TextStyle(
                        color: primary_50,
                        fontSize: 17.1,
                        fontFamily: 'Jost',
                        letterSpacing: 0,
                        fontWeight: FontWeight.w500,
                        height: 1.0),
                    headline2: TextStyle(
                      color: primary_700,
                      fontSize: 20.7,
                      fontFamily: 'Forum',
                    ),
                    headline3: TextStyle(
                        color: primary_700,
                        fontSize: 16,
                        height: 1.0,
                        fontFamily: 'Forum'),
                    headline4: TextStyle(
                        color: primary_50,
                        fontSize: 16,
                        fontFamily: 'Jost',
                        fontWeight: FontWeight.w500,
                        height: 1.0),
                    subtitle1: TextStyle(
                        color: primary_700,
                        fontSize: 18.22,
                        fontFamily: 'Jost',
                        fontWeight: FontWeight.w400,
                        height: 1.0),
                    overline: TextStyle(
                        color: neutral_200,
                        fontSize: 12.34,
                        fontFamily: 'Jost',
                        height: 1.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w400),
                    caption: TextStyle(
                        color: primary_50,
                        fontSize: 14.05,
                        fontFamily: 'Jost',
                        height: 1.1,
                        fontWeight: FontWeight.w400),
                    bodyText2: TextStyle(
                        color: neutral_500,
                        fontSize: 16,
                        fontFamily: 'Jost',
                        height: 1.2,
                        fontWeight: FontWeight.w400),
                    bodyText1: TextStyle(
                        color: primary_700,
                        fontSize: 15,
                        fontFamily: 'Jost',
                        height: 1.0,
                        fontWeight: FontWeight.w300),
                  )));
        });
  }
}
