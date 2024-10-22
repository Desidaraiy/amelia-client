import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/components/PrimaryButtonWidget.dart';
import 'package:markets/src/components/SmallTextInputWidget.dart';
// import 'package:markets/src/controllers/user_controller.dart';
import 'package:markets/src/helpers/colors.dart';
import 'package:markets/src/helpers/helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';
import '../repository/user_repository.dart';

class OTPConfirmationWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final ValueChanged<void> onVerified;
  final String phone;
  OTPConfirmationWidget({Key key, this.onVerified, this.phone})
      : super(key: key);

  @override
  _OTPConfirmationWidgetState createState() => _OTPConfirmationWidgetState();
}

class _OTPConfirmationWidgetState extends StateMVC<OTPConfirmationWidget> {
  String smsSent;
  String phone;
  TextEditingController _codeController;
  FocusNode _codeFocusNode;
  String _autofilledCode = '';

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController();
    _codeFocusNode = FocusNode();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    phone = widget.phone;
    _codeFocusNode.requestFocus();
  }

  void _handleCodeChanged(String value) {
    if (value.isNotEmpty) {
      if (value.length > 3) {
        _verify(_codeController.text);
      }
    }
  }

  // void _verify(code) async {
  //   User user = FirebaseAuth.instance.currentUser;

  //   try {
  //     final AuthCredential credential = PhoneAuthProvider.credential(
  //         verificationId: currentUser.value.verificationId, smsCode: code);
  //     final UserCredential userCredential =
  //         await FirebaseAuth.instance.signInWithCredential(credential);
  //     widget.onVerified(userCredential.user);
  //   } catch (e) {
  //     String errorMessage = '';
  //     if (e.code == 'invalid-verification-code') {
  //       errorMessage = 'Неверный код подтверждения';
  //       _codeController.text = '';
  //       _codeFocusNode.requestFocus();
  //     }
  //     ScaffoldMessenger.of(widget.scaffoldKey?.currentContext)
  //         .showSnackBar(SnackBar(
  //       content: Text(errorMessage.isNotEmpty ? errorMessage : e.toString()),
  //     ));
  //   }
  // }

  void _verify(String code) async {
    try {
      final response = await http.post(
        Uri.parse('https://verify.ameliamobile.ru/v1/verify'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'phone': widget.phone,
          'code': code,
        }),
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['state'] == 'success') {
          widget.onVerified('1');
        } else {
          ScaffoldMessenger.of(widget.scaffoldKey?.currentContext)
              .showSnackBar(SnackBar(
            content: Text('Ошибка верификации: ${jsonResponse['data']}'),
          ));
          _codeController.text = '';
          _codeFocusNode.requestFocus();
        }
      } else {
        ScaffoldMessenger.of(widget.scaffoldKey?.currentContext)
            .showSnackBar(SnackBar(
          content: Text('Ошибка сервера: ${response.statusCode}'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(widget.scaffoldKey?.currentContext)
          .showSnackBar(SnackBar(
        content: Text('Ошибка верификации: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: Helper.of(context).onWillPop,
        child: Scaffold(
            backgroundColor: background,
            key: widget.scaffoldKey,
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    children: [
                      Image.asset('assets/img/amelia_rose.png'),
                      SvgPicture.asset(
                        'assets/img/amelia_name.svg',
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      children: [
                        Text(
                          S.of(context).write_otp,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              .merge(TextStyle(fontSize: 22.13)),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "${S.of(context).code_sent_to} ${phone}",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText1.merge(
                              TextStyle(
                                  color: neutral_500,
                                  height: 1.2,
                                  fontWeight: FontWeight.w400)),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(right: 8),
                                child: SmallPropertyInput(
                                  maxLength: 4,
                                  onChange: (value) =>
                                      _handleCodeChanged(value),
                                  focusNode: _codeFocusNode,
                                  onSaved: (_) => _codeFocusNode.unfocus(),
                                  controller: _codeController,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}
