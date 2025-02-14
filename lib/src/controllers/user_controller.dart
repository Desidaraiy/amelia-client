import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../helpers/helper.dart';
import '../models/user.dart' as model;
import '../pages/mobile_verification_2.dart';
import '../pages/otp_confirmation.dart';
import '../repository/user_repository.dart' as repository;
import 'package:http/http.dart' as http;

class UserController extends ControllerMVC {
  model.User user = new model.User();
  bool hidePassword = true;
  bool loading = false;
  GlobalKey<FormState> loginFormKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  FirebaseMessaging _firebaseMessaging;
  OverlayEntry loader;

  UserController() {
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    _firebaseMessaging = FirebaseMessaging.instance;

    _firebaseMessaging.getToken().then((String _deviceToken) {
      user.deviceToken = _deviceToken;
      print('Device Token: $_deviceToken');
    }).catchError((e) {
      print('Notification not configured');
    });
  }

  Future<String> getDeviceToken() async {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    try {
      String deviceToken = await _firebaseMessaging.getToken();
      return deviceToken;
    } catch (e) {
      print('Notification not configured');
      return null;
    }
  }

  void login() async {
    loader = Helper.overlayLoader(state.context);
    FocusScope.of(state.context).unfocus();
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      Overlay.of(state.context).insert(loader);
      repository.login(user).then((value) {
        if (value != null && value.apiToken != null) {
          Navigator.of(scaffoldKey.currentContext)
              .pushReplacementNamed('/Pages', arguments: 2);
        } else {
          ScaffoldMessenger.of(scaffoldKey?.currentContext)
              .showSnackBar(SnackBar(
            content: Text(S.of(state.context).wrong_email_or_password),
          ));
        }
      }).catchError((e) {
        loader.remove();
        ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
          content: Text(S.of(state.context).this_account_not_exist),
        ));
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }
  }

  // Future<void> verifyPhone(model.User user) async {
  //   final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
  //     repository.currentUser.value.verificationId = verId;
  //   };

  //   final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResent]) {
  //     repository.currentUser.value.verificationId = verId;
  //     Navigator.push(
  //       scaffoldKey.currentContext,
  //       MaterialPageRoute(
  //           builder: (context) => MobileVerification2(
  //                 onVerified: (v) {
  //                   Navigator.of(scaffoldKey.currentContext)
  //                       .pushReplacementNamed('/Pages', arguments: 2);
  //                 },
  //               )),
  //     );
  //   };
  //   final PhoneVerificationCompleted _verifiedSuccess =
  //       (AuthCredential auth) {};
  //   final PhoneVerificationFailed _verifyFailed = (FirebaseAuthException e) {
  //     ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
  //       content: Text(e.message),
  //     ));
  //     print('verification failed - ${e.toString()}');
  //   };
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //     phoneNumber: user.phone,
  //     // timeout: const Duration(seconds: 5),
  //     verificationCompleted: _verifiedSuccess,
  //     verificationFailed: _verifyFailed,
  //     codeSent: smsCodeSent,
  //     codeAutoRetrievalTimeout: autoRetrieve,
  //   );
  // }

  // Future<void> verifyPhone(String phone) async {
  //   final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
  //     repository.currentUser.value.verificationId = verId;
  //   };

  //   final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResent]) {
  //     repository.currentUser.value.verificationId = verId;
  //     Navigator.push(
  //       scaffoldKey.currentContext,
  //       MaterialPageRoute(
  //           builder: (context) => OTPConfirmationWidget(
  //                 phone: phone,
  //                 onVerified: (val) async {
  //                   repository.currentUser.value.phone = phone;
  //                   if (repository.currentUser.value.name == null) {
  //                     repository.currentUser.value.name = 'Клиент';
  //                   }
  //                   repository.currentUser.value.deviceToken =
  //                       await getDeviceToken();
  //                   repository
  //                       .register(repository.currentUser.value)
  //                       .then((value) => {
  //                             Navigator.of(scaffoldKey.currentContext)
  //                                 .pushReplacementNamed('/Pages', arguments: 4)
  //                           });
  //                   ScaffoldMessenger.of(scaffoldKey?.currentContext)
  //                       .showSnackBar(SnackBar(
  //                     content: Text('Вы зарегистрировались.'),
  //                   ));
  //                 },
  //               )),
  //     );
  //   };
  //   final PhoneVerificationCompleted _verifiedSuccess =
  //       (AuthCredential auth) {};

  //   final PhoneVerificationFailed _verifyFailed = (FirebaseAuthException e) {
  //     ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
  //       content: Text(e.message),
  //     ));
  //     print('verification failed - ${e.toString()}');
  //   };
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //     phoneNumber: phone,
  //     // timeout: const Duration(seconds: 5),
  //     verificationCompleted: _verifiedSuccess,
  //     verificationFailed: _verifyFailed,
  //     codeSent: smsCodeSent,
  //     codeAutoRetrievalTimeout: autoRetrieve,
  //   );
  // }

  Future<void> verifyPhone(String phone) async {
    try {
      final response = await http.post(
        Uri.parse('https://verify.ameliamobile.ru/v1/verify'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'phone': phone,
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['state'] == 'success') {
          Navigator.push(
            scaffoldKey.currentContext,
            MaterialPageRoute(
                builder: (context) => OTPConfirmationWidget(
                      phone: phone,
                      onVerified: (val) async {
                        repository.currentUser.value.phone = phone;
                        if (repository.currentUser.value.name == null) {
                          repository.currentUser.value.name = 'Клиент';
                        }
                        repository.currentUser.value.deviceToken =
                            await getDeviceToken();
                        repository
                            .register(repository.currentUser.value)
                            .then((value) => {
                                  Navigator.of(scaffoldKey.currentContext)
                                      .pushReplacementNamed('/Pages',
                                          arguments: 4)
                                });
                        ScaffoldMessenger.of(scaffoldKey?.currentContext)
                            .showSnackBar(SnackBar(
                          content: Text('Вы зарегистрировались.'),
                        ));
                      },
                    )),
          );
        } else {
          // Обработка ошибки, если сервис вернул ошибку
          ScaffoldMessenger.of(scaffoldKey.currentContext)
              .showSnackBar(SnackBar(
            content: Text('Ошибка отправки кода: ${jsonResponse['data']}'),
          ));
        }
      } else {
        // Обработка ошибки HTTP-запроса
        ScaffoldMessenger.of(scaffoldKey.currentContext).showSnackBar(SnackBar(
          content: Text('Ошибка сервера: ${response.statusCode}'),
        ));
      }
    } catch (e) {
      // Обработка исключений
      ScaffoldMessenger.of(scaffoldKey.currentContext).showSnackBar(SnackBar(
        content: Text('Ошибка верификации: $e'),
      ));
    }
  }

  void register() async {
    loader = Helper.overlayLoader(state.context);
    FocusScope.of(state.context).unfocus();
    Overlay.of(state.context).insert(loader);
    repository.register(user).then((value) {
      if (value != null && value.apiToken != null) {
        Navigator.of(scaffoldKey.currentContext)
            .pushReplacementNamed('/Pages', arguments: 2);
      } else {
        ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
          content: Text(S.of(state.context).wrong_email_or_password),
        ));
      }
    }).catchError((e) {
      loader.remove();
      ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
        content: Text(S.of(state.context).this_email_account_exists),
      ));
    }).whenComplete(() {
      Helper.hideLoader(loader);
    });
  }

  void resetPassword() {
    loader = Helper.overlayLoader(state.context);
    FocusScope.of(state.context).unfocus();
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      Overlay.of(state.context).insert(loader);
      repository.resetPassword(user).then((value) {
        if (value != null && value == true) {
          ScaffoldMessenger.of(scaffoldKey?.currentContext)
              .showSnackBar(SnackBar(
            content: Text(S
                .of(state.context)
                .your_reset_link_has_been_sent_to_your_email),
            action: SnackBarAction(
              label: S.of(state.context).login,
              onPressed: () {
                Navigator.of(scaffoldKey.currentContext)
                    .pushReplacementNamed('/Login');
              },
            ),
            duration: Duration(seconds: 10),
          ));
        } else {
          loader.remove();
          ScaffoldMessenger.of(scaffoldKey?.currentContext)
              .showSnackBar(SnackBar(
            content: Text(S.of(state.context).error_verify_email_settings),
          ));
        }
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }
  }
}
