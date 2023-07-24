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
  List<FocusNode> _focusNodes;
  List<TextEditingController> _textControllers;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(6, (_) => FocusNode());
    _textControllers = List.generate(6, (_) => TextEditingController());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    phone = widget.phone;
    _focusNodes[0].requestFocus();
  }

  @override
  void dispose() {
    _focusNodes.forEach((node) => node.dispose());
    _textControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void _handleCodeChanged(int index, String value) {
    if (value.isNotEmpty) {
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
        final code =
            _textControllers.map((controller) => controller.text).join();
        _verify(code);
      }
    }
  }

  void _verify(code) async {
    User user = FirebaseAuth.instance.currentUser;

    // if (user != null) {
    //   print('not null');
    //   widget.onVerified;
    // } else {

    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: currentUser.value.verificationId, smsCode: code);
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      widget.onVerified(userCredential.user);
    } catch (e) {
      String errorMessage = '';
      if (e.code == 'invalid-verification-code') {
        errorMessage = 'Неверный код подтверждения';
        for (int i = 0; i <= 5; i++) {
          _textControllers[i].text = '';
        }
        _focusNodes[0].requestFocus();
      }
      ScaffoldMessenger.of(widget.scaffoldKey?.currentContext)
          .showSnackBar(SnackBar(
        content: Text(errorMessage.isNotEmpty ? errorMessage : e.toString()),
      ));
    }
  }

  // UserController _con;

  // _OTPConfirmationWidgetState() : super(UserController()) {
  //   _con = controller;
  // }
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                            6,
                            (index) => Expanded(
                              child: Container(
                                margin: EdgeInsets.only(right: 8),
                                child: SmallPropertyInput(
                                  maxLength: 1,
                                  onChange: (value) =>
                                      _handleCodeChanged(index, value),
                                  focusNode: _focusNodes[index],
                                  onSaved: (_) => _focusNodes[index].unfocus(),
                                  controller: _textControllers[index],
                                ),
                              ),
                            ),
                          ),
                          // children: [
                          // Expanded(
                          //   child: SmallPropertyInput(
                          //     onSaved: (input) {},
                          //     maxLines: 1,
                          //     maxLength: 1,
                          //     keyboardType: TextInputType.number,
                          //   ),
                          // ),
                          // SizedBox(
                          //   width: 8,
                          // ),
                          // Expanded(
                          //   child: SmallPropertyInput(
                          //     onSaved: (input) {},
                          //     maxLines: 1,
                          //     maxLength: 1,
                          //     keyboardType: TextInputType.number,
                          //   ),
                          // ),
                          // SizedBox(
                          //   width: 8,
                          // ),
                          // Expanded(
                          //   child: SmallPropertyInput(
                          //     onSaved: (input) {},
                          //     maxLines: 1,
                          //     maxLength: 1,
                          //     keyboardType: TextInputType.number,
                          //   ),
                          // ),
                          // SizedBox(
                          //   width: 8,
                          // ),
                          // Expanded(
                          //   child: SmallPropertyInput(
                          //     onSaved: (input) {},
                          //     maxLines: 1,
                          //     maxLength: 1,
                          //     keyboardType: TextInputType.number,
                          //   ),
                          // ),
                          // SizedBox(
                          //   width: 8,
                          // ),
                          // Expanded(
                          //   child: SmallPropertyInput(
                          //     onSaved: (input) {},
                          //     maxLines: 1,
                          //     maxLength: 1,
                          //     keyboardType: TextInputType.number,
                          //   ),
                          // ),
                          // SizedBox(
                          //   width: 8,
                          // ),
                          // Expanded(
                          //   child: SmallPropertyInput(
                          //     onSaved: (input) {},
                          //     maxLines: 1,
                          //     maxLength: 1,
                          //     keyboardType: TextInputType.number,
                          //   ),
                          // ),

                          // ConstrainedBox(
                          //   constraints: BoxConstraints(minWidth: 36, minHeight: 44),
                          //   child: PropertyInput(
                          //     onSaved: (input) {
                          //     },
                          //     maxLines: 1,
                          //     maxLength: 1,
                          //     keyboardType: TextInputType.number,
                          //   ),
                          // ),
                          // SizedBox(width: 8,),
                          // ConstrainedBox(
                          //   constraints: BoxConstraints(minWidth: 36, minHeight: 44),
                          //   child: IntrinsicWidth(
                          //     child: PropertyInput(
                          //       onSaved: (input) {
                          //       },
                          //       maxLines: 1,
                          //       maxLength: 1,
                          //       keyboardType: TextInputType.number,
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(width: 8,),
                          // ConstrainedBox(
                          //   constraints: BoxConstraints(minWidth: 36,minHeight: 44),
                          //    child: IntrinsicWidth(
                          //      child: PropertyInput(
                          //       onSaved: (input) {
                          //       },
                          //       maxLines: 1,
                          //       maxLength: 1,
                          //       keyboardType: TextInputType.number,
                          // ),
                          //    ),
                          //  ),
                          // SizedBox(width: 8,),
                          // ConstrainedBox(
                          //   constraints: BoxConstraints(minWidth: 36, maxHeight: 44),
                          //   child: IntrinsicWidth(
                          //     child: PropertyInput(
                          //       onSaved: (input) {
                          //       },
                          //       maxLines: 1,
                          //       maxLength: 1,
                          //       keyboardType: TextInputType.number,
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(width: 8,),
                          // ConstrainedBox(
                          //   constraints: BoxConstraints(minWidth: 36),
                          //   child: IntrinsicWidth(
                          //     child: PropertyInput(
                          //       onSaved: (input) {
                          //       },
                          //       maxLines: 1,
                          //       maxLength: 1,
                          //       keyboardType: TextInputType.number,
                          //     ),
                          //   ),
                          // ),
                          // ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        PrimaryButton(
                          icon: null,
                          small: false,
                          text: "Подтвердить",
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
                        )
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}
