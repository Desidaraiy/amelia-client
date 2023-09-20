import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/components/PrimaryButtonWithLoader.dart';
import 'package:markets/src/components/TextInputWidget.dart';
import 'package:markets/src/components/CheckBoxWidget.dart';
import 'package:markets/src/helpers/colors.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';
import '../controllers/user_controller.dart';
import '../elements/BlockButtonWidget.dart';
import '../helpers/app_config.dart' as config;
import '../helpers/helper.dart';
import '../repository/user_repository.dart' as userRepo;

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends StateMVC<LoginWidget> {
  UserController _con;

  _LoginWidgetState() : super(UserController()) {
    _con = controller;
  }

  TextEditingController txCont = new TextEditingController();
  bool tapped = false;
  bool userDataChecked = false;

  @override
  void initState() {
    super.initState();

    if (userRepo.currentUser.value.apiToken != null) {
      Navigator.of(context).pushReplacementNamed('/Pages', arguments: 4);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper.of(context).onWillPop,
      child: Scaffold(
          backgroundColor: background,
          key: _con.scaffoldKey,
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.only(top: 32, bottom: 16),
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
                        S.of(context).welcome,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .merge(TextStyle(fontSize: 22.13)),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        S.of(context).type_phone_to_log_in,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .merge(TextStyle(color: neutral_500, height: 1.2)),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      PropertyInput(
                          onSaved: (input) {},
                          hintText: '999 999-99-99',
                          maxLines: 1,
                          maxLength: 100,
                          inputFormatters: [
                            TextInputMask(mask: '\999 999-99-99')
                          ],
                          textController: txCont,
                          small: true,
                          keyboardType: TextInputType.number,
                          prefixIcon: Container(
                            width: 48,
                            height: 48,
                            alignment: Alignment.center,
                            child: Text(
                              S.of(context).country_code,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .merge(TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: primary_700)),
                            ),
                          )),
                      CheckBoxWidget(
                        value: userDataChecked,
                        onChange: (value) {
                          setState(() {
                            userDataChecked = value;
                          });
                        },
                        checkboxTextFirst: InkWell(
                          onTap: () {},
                          child: RichText(
                            text: TextSpan(
                              text: 'Принимаю условия ',
                              style: Theme.of(context)
                                  .textTheme
                                  .overline
                                  .merge(TextStyle(
                                    color: neutral_400,
                                    height: 1.1,
                                  )),
                              children: [
                                TextSpan(
                                    text: 'обработки данных',
                                    style: Theme.of(context)
                                        .textTheme
                                        .overline
                                        .merge(TextStyle(
                                            color: neutral_400,
                                            height: 1.1,
                                            decoration:
                                                TextDecoration.underline))),
                              ],
                            ),
                          ),
                        ),
                        checkboxTextSecond: null,
                      ),
                      !userDataChecked
                          ? Text(S.of(context).personal_data_validate,
                              style: Theme.of(context).textTheme.overline.merge(
                                  TextStyle(
                                      color: semantic_error, height: 1.2)))
                          : Container(height: 0),
                      SizedBox(
                        height: 8,
                      ),
                      PrimaryButtonLoader(
                        icon: null,
                        small: false,
                        text: "Отправить код",
                        enabled: userDataChecked,
                        isLoading: tapped,
                        onPressed: () {
                          if (userDataChecked) {
                            setState(() {
                              tapped = true;
                            });
                            String phone =
                                txCont.text.replaceAll(RegExp(r'[-\s]'), '');
                            _con.verifyPhone('+7${phone}');
                          }
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
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: config.App(context).appWidth(55),
                      child: TextButton.icon(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed('/Pages', arguments: 0);
                        },
                        icon: Icon(Icons.chevron_left),
                        label: Text('На главную'),
                      ),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: config.App(context).appHeight(18),
                //   child: Stack(
                //     fit: StackFit.expand,
                //     alignment: AlignmentDirectional.topCenter,
                //     children: <Widget>[
                //       Positioned(
                //         top: 0,
                //         child: Container(
                //           width: config.App(context).appWidth(100),
                //           height: config.App(context).appHeight(37),
                //           decoration: BoxDecoration(
                //               color: Theme.of(context).accentColor),
                //         ),
                //       ),
                //       Positioned(
                //         top: config.App(context).appHeight(37) - 120,
                //         child: Container(
                //           width: config.App(context).appWidth(84),
                //           height: config.App(context).appHeight(37),
                //           child: Text(
                //             S.of(context).lets_start_with_login,
                //             style: Theme.of(context).textTheme.headline2.merge(
                //                 TextStyle(
                //                     color: Theme.of(context).primaryColor)),
                //           ),
                //         ),
                //       ),
                //       Positioned(
                //         top: config.App(context).appHeight(37) - 50,
                //         child: Container(
                //           decoration: BoxDecoration(
                //               color: Theme.of(context).primaryColor,
                //               borderRadius:
                //                   BorderRadius.all(Radius.circular(10)),
                //               boxShadow: [
                //                 BoxShadow(
                //                   blurRadius: 50,
                //                   color: Theme.of(context)
                //                       .hintColor
                //                       .withOpacity(0.2),
                //                 )
                //               ]),
                //           margin: EdgeInsets.symmetric(
                //             horizontal: 20,
                //           ),
                //           padding: EdgeInsets.only(
                //               top: 50, right: 27, left: 27, bottom: 20),
                //           width: config.App(context).appWidth(88),
                //           // height: config.App(context).appHeight(55),
                //         ),
                //       ),
                //       Positioned.fill(
                //         bottom: 10,
                //         child: Column(
                //           children: <Widget>[
                //             MaterialButton(
                //               elevation: 0,
                //               onPressed: () {
                //                 Navigator.of(context)
                //                     .pushReplacementNamed('/ForgetPassword');
                //               },
                //               textColor: Theme.of(context).hintColor,
                //               child: Text(S.of(context).i_forgot_password),
                //             ),
                //             MaterialButton(
                //               elevation: 0,
                //               onPressed: () {
                //                 Navigator.of(context)
                //                     .pushReplacementNamed('/SignUp');
                //               },
                //               textColor: Theme.of(context).hintColor,
                //               child: Text(S.of(context).i_dont_have_an_account),
                //             ),
                //           ],
                //         ),
                //       )
                //     ],
                //   ),
                // ),
              ],
            ),
          )),
    );
  }
}
