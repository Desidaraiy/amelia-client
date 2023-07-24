import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/components/AddDeliveryAddressWidget.dart';
import 'package:markets/src/components/AlertDialogWidget.dart';
import 'package:markets/src/components/CheckBoxWidget.dart';
import 'package:markets/src/components/DeleteLabelWidget.dart';
import 'package:markets/src/components/ModalBottomSheetWidget.dart';
import 'package:markets/src/components/PrimaryButtonWidget.dart';
import 'package:markets/src/components/ProductListWidget.dart';
import 'package:markets/src/components/SetWidget.dart';
import 'package:markets/src/components/TextInputWidget.dart';
import 'package:markets/src/helpers/colors.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../generated/l10n.dart';
import '../controllers/settings_controller.dart';
import '../elements/CircularLoadingWidget.dart';
import '../elements/MobileVerificationBottomSheetWidget.dart';
import '../elements/PaymentSettingsDialog.dart';
import '../elements/ProfileSettingsDialog.dart';
import '../elements/SearchBarWidget.dart';
import '../helpers/helper.dart';
import '../repository/settings_repository.dart';
import '../repository/user_repository.dart';
import '../repository/user_repository.dart' as userRepo;
import 'add_bank_card.dart';

class SettingsWidget extends StatefulWidget {
  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends StateMVC<SettingsWidget> {
  SettingsController _con;

  _SettingsWidgetState() : super(SettingsController()) {
    _con = controller;
  }
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  TextEditingController _userNameTextController = new TextEditingController();

  Future<void> _handleLaunchUrl() async {
    final Uri url = Uri.parse("https://vk.com/amelia53");
    if (await canLaunchUrl(url) != null) {
      await launchUrl(url);
    }
  }

  void _saveUserNameToPrefs() {
    setUserName(_userNameTextController.text);
  }

  List<String> languages = ["Русский", "Английский"];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      key: _con.scaffoldKey,
      body: currentUser.value.id == null
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Column(
                            children: [
                              Image.asset('assets/img/amelia_rose.png'),
                              SvgPicture.asset(
                                'assets/img/amelia_name.svg',
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Text(
                                "Войдите или зарегистрируйтесь",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .merge(TextStyle(fontSize: 20.74)),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Чтобы заказать понравившийся букет прямо сейчас и отслеживать заказы",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .merge(TextStyle(
                                        color: neutral_500,
                                        height: 1.2,
                                        fontSize: 17.07)),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              PrimaryButton(
                                  icon: null,
                                  small: false,
                                  text: "Войти или зарегистрироваться",
                                  min_width: 300,
                                  min_height: 48,
                                  left_padding: 16,
                                  right_padding: 16,
                                  top_padding: 14,
                                  bottom_padding: 14,
                                  border_radius: 5,
                                  buttonText: true,
                                  onPressed: () => Navigator.of(context)
                                      .pushNamed('/Login')),
                              SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: primary_50,
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: Text(
                                  "Язык приложения",
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ),
                              SizedBox(
                                height: 32,
                                child: ListView.builder(
                                  itemCount: languages.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, int index) {
                                    return Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedIndex = index;
                                            });
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 32,
                                            decoration: BoxDecoration(
                                                border: selectedIndex == index
                                                    ? Border.all(
                                                        color: secondary_300)
                                                    : Border.all(
                                                        style:
                                                            BorderStyle.none),
                                                color: selectedIndex == index
                                                    ? secondary_100
                                                    : expanded_light_neutral_100,
                                                borderRadius:
                                                    BorderRadius.circular(5.0)),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 12, right: 12),
                                              child: Text(languages[index],
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption
                                                      .merge(TextStyle(
                                                          height: 1.1,
                                                          color: selectedIndex ==
                                                                  index
                                                              ? secondary_300
                                                              : neutral_350))),
                                            ),
                                          ),
                                        ),
                                        index != languages.length - 1
                                            ? SizedBox(
                                                width: 8,
                                              )
                                            : SizedBox(),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          color: primary_50,
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: Text(
                                  "Поддержка",
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ),
                              Text(
                                "Свяжитесь с нами",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/call.svg',
                                      color: neutral_400,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "923-500",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .merge(TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: neutral_400,
                                              height: 1.1,
                                              decoration:
                                                  TextDecoration.underline)),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/alternate_email.svg',
                                      color: neutral_400,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "info@amelia53.ru",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .merge(TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: neutral_400,
                                              height: 1.1,
                                              decoration:
                                                  TextDecoration.underline)),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/mail.svg',
                                      color: neutral_400,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "vk.com/amelia53",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .merge(TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: neutral_400,
                                              height: 1.1,
                                              decoration:
                                                  TextDecoration.underline)),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          : NestedScrollView(
              floatHeaderSlivers: true,
              scrollDirection: Axis.vertical,
              controller: _scrollController,
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(S.of(context).favorites,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1),
                                ),
                                // InkWell(
                                //   onTap: () => Navigator.of(context)
                                //       .pushNamed('/Favorites'),
                                //   child: Text(
                                //     S.of(context).show_all,
                                //     style: Theme.of(context)
                                //         .textTheme
                                //         .caption
                                //         .merge(TextStyle(color: neutral_500)),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                              // height: 116,
                              child: _con.favoritesList.isNotEmpty
                                  ? ProductListWidget(
                                      productsList: _con.favoritesList,
                                      heroTag: 'home_product_carousel')
                                  : Container(
                                      height: 50,
                                      child: Center(
                                          child: Text(
                                              'Вы еще не добавили избранное')))
                              // ListView(
                              //   scrollDirection: Axis.horizontal,
                              //   children: [
                              //     SizedBox(
                              //       width: 16,
                              //     ),
                              //     ProductSet(
                              //       icon: true,
                              //       imgName:
                              //           'https://sun9-79.userapi.com/impg/HSN5O-wAHvu0-URUNpmH0V8Sl5AyU7OVuurFYQ/w9xDsigr5WU.jpg?size=810x1080&quality=95&sign=af054a9ec974de9e0e214c5019c3cbb0&type=album',
                              //     ),
                              //     SizedBox(
                              //       width: 8,
                              //     ),
                              //     ProductSet(
                              //       icon: true,
                              //       imgName:
                              //           'https://sun9-88.userapi.com/impg/jNjhZs44SV8FzwIRtLV8WcsNqfALf2ZI2vAkag/P30o_B1sQQE.jpg?size=721x1080&quality=95&sign=f6ba05f4dfc6d547acb4900bdeb289f7&type=album',
                              //     ),
                              //     SizedBox(
                              //       width: 8,
                              //     ),
                              //     ProductSet(
                              //       icon: true,
                              //       imgName:
                              //           'https://sun9-63.userapi.com/impg/53tpEzrL8fZE4_ZmaRix8xFCXgKTkIZjyzQ47A/Y7LN5xd7jCo.jpg?size=721x1080&quality=95&sign=0514cf738fc5bd031110381f2bd235b3&type=album',
                              //     ),
                              //     SizedBox(
                              //       width: 8,
                              //     ),
                              //     ProductSet(
                              //       icon: true,
                              //       imgName:
                              //           'https://sun9-16.userapi.com/C2CK49spPERa-NkJDsSaWQX7VoVsvGCaxnb6jA/yfIv6tuszhg.jpg',
                              //     ),
                              //     SizedBox(
                              //       width: 8,
                              //     ),
                              //     ProductSet(
                              //       icon: true,
                              //       imgName:
                              //           'https://sun9-72.userapi.com/zH6Z1Njw6vGfh0tPSHR2eBcrqpS2gL3MvYPyYw/YtvbZkFwfTk.jpg',
                              //     ),
                              //     SizedBox(
                              //       width: 16,
                              //     ),
                              //   ],
                              // ),
                              ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            color: primary_50,
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, bottom: 12),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    child: Text(
                                      "Мои данные",
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                  ),
                                  PropertyInput(
                                      small: false,
                                      personal: true,
                                      onSaved: (input) {},
                                      textController: TextEditingController(
                                          text: currentUser.value.phone
                                              .replaceAll('+7', '')),
                                      hintText: '999 999-99-99',
                                      maxLines: 1,
                                      maxLength: 100,
                                      inputFormatters: [
                                        TextInputMask(mask: '\999 999-99-99')
                                      ],
                                      keyboardType: TextInputType.number,
                                      prefixIcon: Container(
                                        width: 48,
                                        height: 48,
                                        padding: EdgeInsets.only(top: 4),
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
                                  // SizedBox(
                                  //   height: 8,
                                  // ),
                                  // InkWell(
                                  //   onTap: () => showModalBottomSheet(
                                  //       isScrollControlled: true,
                                  //       context: context,
                                  //       backgroundColor: Colors.transparent,
                                  //       builder: (_) {
                                  //         return ModalBottomSheetWidget(
                                  //           reset: false,
                                  //           initialChildSize: 0.30,
                                  //           widget: Padding(
                                  //             padding: const EdgeInsets.all(16),
                                  //             child: Column(
                                  //               children: [
                                  //                 PropertyInput(
                                  //                   textController:
                                  //                       TextEditingController(),
                                  //                   personal: false,
                                  //                   small: false,
                                  //                   onSaved: (input) {},
                                  //                   onChange: (input) {},
                                  //                   hintText:
                                  //                       'Электронная почта',
                                  //                   maxLines: 1,
                                  //                   maxLength: 100,
                                  //                   keyboardType:
                                  //                       TextInputType.text,
                                  //                   labelText:
                                  //                       "Электронная почта",
                                  //                 ),
                                  //                 SizedBox(
                                  //                   height: 16,
                                  //                 ),
                                  //                 PrimaryButton(
                                  //                   icon: null,
                                  //                   small: false,
                                  //                   text: "Сохранить",
                                  //                   onPressed: () {
                                  //                     Navigator.of(context)
                                  //                         .pop();
                                  //                   },
                                  //                   min_width: 176,
                                  //                   min_height: 48,
                                  //                   left_padding: 0,
                                  //                   right_padding: 0,
                                  //                   top_padding: 14,
                                  //                   bottom_padding: 14,
                                  //                   border_radius: 5,
                                  //                   buttonText: true,
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //           ),
                                  //           title: "Электронная почта",
                                  //           showAll: false,
                                  //         );
                                  //       }),
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.symmetric(
                                  //         vertical: 10),
                                  //     child: Row(
                                  //       children: [
                                  //         SvgPicture.asset(
                                  //           'assets/icons/add_200.svg',
                                  //           color: neutral_400,
                                  //         ),
                                  //         SizedBox(
                                  //           width: 4,
                                  //         ),
                                  //         Text(
                                  //           "Добавить электронную почту",
                                  //           style: Theme.of(context)
                                  //               .textTheme
                                  //               .bodyText1
                                  //               .merge(TextStyle(
                                  //                   fontWeight: FontWeight.w400,
                                  //                   height: 1.2,
                                  //                   decoration: TextDecoration
                                  //                       .underline,
                                  //                   color: neutral_400)),
                                  //         )
                                  //       ],
                                  //     ),
                                  //   ),
                                  // )
                                ]),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          // Container(
                          //   color: primary_50,
                          //   padding: const EdgeInsets.only(
                          //       left: 16, right: 16, bottom: 12),
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Padding(
                          //         padding:
                          //             const EdgeInsets.symmetric(vertical: 12),
                          //         child: Text(
                          //           "Адреса доставки",
                          //           style:
                          //               Theme.of(context).textTheme.subtitle1,
                          //         ),
                          //       ),
                          //       Row(
                          //         children: [
                          //           Expanded(
                          //             child: PropertyInput(
                          //               small: false,
                          //               personal: true,
                          //               onSaved: (input) {},
                          //               textController: TextEditingController(
                          //                   text: currentUser.value.address),
                          //               maxLines: 5,
                          //               maxLength: 300,
                          //               keyboardType: TextInputType.text,
                          //             ),
                          //           ),
                          //           SizedBox(
                          //             width: 8,
                          //           ),
                          //           InkWell(
                          //             onTap: () => showDialog(
                          //                 context: context,
                          //                 builder: (BuildContext context) =>
                          //                     AlertDialogWidget(
                          //                       title:
                          //                           "Удалить адрес доставки?",
                          //                       onYes: "Удалить",
                          //                     )),
                          //             child: Padding(
                          //               padding: const EdgeInsets.all(10.0),
                          //               child: SvgPicture.asset(
                          //                 'assets/icons/delete_200_24.svg',
                          //                 color: expanded_red_450,
                          //               ),
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //       InkWell(
                          //         onTap: () => showModalBottomSheet(
                          //             isScrollControlled: true,
                          //             context: context,
                          //             backgroundColor: Colors.transparent,
                          //             builder: (_) {
                          //               return ModalBottomSheetWidget(
                          //                 reset: false,
                          //                 initialChildSize: 0.50,
                          //                 widget: Column(
                          //                   children: [
                          //                     Padding(
                          //                       padding:
                          //                           const EdgeInsets.all(16),
                          //                       child: Column(
                          //                           crossAxisAlignment:
                          //                               CrossAxisAlignment
                          //                                   .start,
                          //                           children: [
                          //                             PropertyInput(
                          //                               small: false,
                          //                               textController:
                          //                                   TextEditingController(),
                          //                               personal: false,
                          //                               onSaved: (input) {},
                          //                               onChange: (input) {},
                          //                               hintText:
                          //                                   'Город, улица, дом',
                          //                               maxLines: 5,
                          //                               maxLength: 300,
                          //                               keyboardType:
                          //                                   TextInputType.text,
                          //                               labelText:
                          //                                   "Город, улица, дом",
                          //                             ),
                          //                             SizedBox(
                          //                               height: 8,
                          //                             ),
                          //                             Row(
                          //                               children: [
                          //                                 Expanded(
                          //                                   child:
                          //                                       PropertyInput(
                          //                                     small: false,
                          //                                     textController:
                          //                                         TextEditingController(),
                          //                                     personal: false,
                          //                                     onSaved:
                          //                                         (input) {},
                          //                                     onChange:
                          //                                         (input) {},
                          //                                     hintText:
                          //                                         'Подъезд',
                          //                                     maxLines: 1,
                          //                                     maxLength: 5,
                          //                                     keyboardType:
                          //                                         TextInputType
                          //                                             .number,
                          //                                     labelText:
                          //                                         "Подъезд",
                          //                                   ),
                          //                                 ),
                          //                                 SizedBox(
                          //                                   width: 8,
                          //                                 ),
                          //                                 Expanded(
                          //                                   child:
                          //                                       PropertyInput(
                          //                                     small: false,
                          //                                     textController:
                          //                                         TextEditingController(),
                          //                                     personal: false,
                          //                                     onSaved:
                          //                                         (input) {},
                          //                                     onChange:
                          //                                         (input) {},
                          //                                     hintText: 'Этаж',
                          //                                     maxLines: 1,
                          //                                     maxLength: 5,
                          //                                     prefixIcon: null,
                          //                                     keyboardType:
                          //                                         TextInputType
                          //                                             .number,
                          //                                     labelText: "Этаж",
                          //                                   ),
                          //                                 ),
                          //                                 SizedBox(
                          //                                   width: 8,
                          //                                 ),
                          //                                 Expanded(
                          //                                   child:
                          //                                       PropertyInput(
                          //                                     small: false,
                          //                                     textController:
                          //                                         TextEditingController(),
                          //                                     personal: false,
                          //                                     onSaved:
                          //                                         (input) {},
                          //                                     onChange:
                          //                                         (input) {},
                          //                                     hintText:
                          //                                         'Квартира/офис',
                          //                                     maxLines: 1,
                          //                                     maxLength: 100,
                          //                                     keyboardType:
                          //                                         TextInputType
                          //                                             .text,
                          //                                     labelText:
                          //                                         "Квартира/офис",
                          //                                   ),
                          //                                 ),
                          //                               ],
                          //                             ),
                          //                             SizedBox(
                          //                               height: 8,
                          //                             ),
                          //                             PropertyInput(
                          //                               small: false,
                          //                               textController:
                          //                                   TextEditingController(),
                          //                               personal: false,
                          //                               onSaved: (input) {},
                          //                               onChange: (input) {},
                          //                               hintText:
                          //                                   'Комментарий курьеру (необязательно)',
                          //                               maxLines: 5,
                          //                               maxLength: 300,
                          //                               keyboardType:
                          //                                   TextInputType.text,
                          //                               labelText:
                          //                                   "Комментарий курьеру (необязательно)",
                          //                             ),
                          //                             SizedBox(
                          //                               height: 8,
                          //                             ),
                          //                             PrimaryButton(
                          //                               icon: null,
                          //                               small: false,
                          //                               text: "Сохранить",
                          //                               onPressed: () {
                          //                                 Navigator.of(context)
                          //                                     .pop();
                          //                               },
                          //                               min_width: 176,
                          //                               min_height: 48,
                          //                               left_padding: 0,
                          //                               right_padding: 0,
                          //                               top_padding: 14,
                          //                               bottom_padding: 14,
                          //                               border_radius: 5,
                          //                               buttonText: true,
                          //                             ),
                          //                           ]),
                          //                     )
                          //                   ],
                          //                 ),
                          //                 title: "Адрес доставки",
                          //                 showAll: false,
                          //               );
                          //             }),
                          //         child: Padding(
                          //           padding: const EdgeInsets.symmetric(
                          //               vertical: 10),
                          //           child: Row(
                          //             children: [
                          //               SvgPicture.asset(
                          //                 'assets/icons/add_200.svg',
                          //                 color: neutral_400,
                          //               ),
                          //               SizedBox(
                          //                 width: 4,
                          //               ),
                          //               Text(
                          //                 "Добавить адрес доставки",
                          //                 style: Theme.of(context)
                          //                     .textTheme
                          //                     .bodyText1
                          //                     .merge(TextStyle(
                          //                         fontWeight: FontWeight.w400,
                          //                         height: 1.2,
                          //                         decoration:
                          //                             TextDecoration.underline,
                          //                         color: neutral_400)),
                          //               )
                          //             ],
                          //           ),
                          //         ),
                          //       )
                          //     ],
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 8,
                          // ),
                          // Container(
                          //   color: primary_50,
                          //   padding: const EdgeInsets.only(
                          //       left: 16, right: 16, bottom: 12),
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Padding(
                          //         padding:
                          //             const EdgeInsets.symmetric(vertical: 12),
                          //         child: Text(
                          //           "Карты",
                          //           style:
                          //               Theme.of(context).textTheme.subtitle1,
                          //         ),
                          //       ),
                          //       Row(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           Column(
                          //             children: [
                          //               Container(
                          //                 alignment: Alignment.center,
                          //                 height: 64,
                          //                 width: 112,
                          //                 decoration: BoxDecoration(
                          //                   borderRadius:
                          //                       BorderRadius.circular(5.0),
                          //                   color: expanded_light_neutral_100,
                          //                 ),
                          //                 child: Padding(
                          //                   padding: EdgeInsets.only(
                          //                       left: 12,
                          //                       right: 12,
                          //                       top: 4,
                          //                       bottom: 8),
                          //                   child: Column(
                          //                     children: [
                          //                       SvgPicture.asset(
                          //                           "assets/icons/credit_card.svg"),
                          //                       SizedBox(
                          //                         height: 6,
                          //                       ),
                          //                       Text('**** 4049',
                          //                           style: Theme.of(context)
                          //                               .textTheme
                          //                               .overline
                          //                               .merge(TextStyle(
                          //                                   // height: 1.2,
                          //                                   color: neutral_350,
                          //                                   fontWeight:
                          //                                       FontWeight
                          //                                           .w500))),
                          //                     ],
                          //                   ),
                          //                 ),
                          //               ),
                          //               InkWell(
                          //                 onTap: () => showDialog(
                          //                     context: context,
                          //                     builder: (BuildContext context) =>
                          //                         AlertDialogWidget(
                          //                           title: "Удалить карту?",
                          //                           onYes: "Удалить",
                          //                         )),
                          //                 child: Padding(
                          //                   padding: const EdgeInsets.all(10.0),
                          //                   child: SvgPicture.asset(
                          //                     'assets/icons/delete_200_24.svg',
                          //                     color: expanded_red_450,
                          //                   ),
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //           SizedBox(
                          //             width: 8,
                          //           ),
                          //           InkWell(
                          //             onTap: () => showModalBottomSheet(
                          //                 isScrollControlled: true,
                          //                 context: context,
                          //                 backgroundColor: Colors.transparent,
                          //                 builder: (_) {
                          //                   return ModalBottomSheetWidget(
                          //                     reset: false,
                          //                     initialChildSize: 0.80,
                          //                     widget: Padding(
                          //                       padding:
                          //                           const EdgeInsets.all(16),
                          //                       child: Column(
                          //                         children: [
                          //                           Container(
                          //                             height: 206,
                          //                             padding:
                          //                                 EdgeInsets.fromLTRB(
                          //                                     16, 16, 16, 8),
                          //                             decoration: BoxDecoration(
                          //                                 color: primary_50,
                          //                                 borderRadius:
                          //                                     BorderRadius
                          //                                         .circular(
                          //                                             20.0)),
                          //                             child: Column(
                          //                               crossAxisAlignment:
                          //                                   CrossAxisAlignment
                          //                                       .start,
                          //                               children: [
                          //                                 Text(
                          //                                   S
                          //                                       .of(context)
                          //                                       .card_number,
                          //                                   style: Theme.of(
                          //                                           context)
                          //                                       .textTheme
                          //                                       .subtitle1,
                          //                                 ),
                          //                                 SizedBox(
                          //                                   height: 4,
                          //                                 ),
                          //                                 PropertyInput(
                          //                                   textController:
                          //                                       TextEditingController(),
                          //                                   personal: false,
                          //                                   small: true,
                          //                                   onSaved: (input) {},
                          //                                   onChange:
                          //                                       (input) {},
                          //                                   hintText:
                          //                                       '1234 5678 9012 3456',
                          //                                   maxLines: 1,
                          //                                   maxLength: 19,
                          //                                   inputFormatters: [
                          //                                     TextInputMask(
                          //                                         mask:
                          //                                             '9999 9999 9999 9999')
                          //                                   ],
                          //                                   keyboardType:
                          //                                       TextInputType
                          //                                           .number,
                          //                                   // labelText: "Город, улица, дом",
                          //                                 ),
                          //                                 SizedBox(
                          //                                   height: 8,
                          //                                 ),
                          //                                 Row(
                          //                                   children: [
                          //                                     Expanded(
                          //                                       child: Column(
                          //                                         crossAxisAlignment:
                          //                                             CrossAxisAlignment
                          //                                                 .start,
                          //                                         children: [
                          //                                           Text(
                          //                                             S
                          //                                                 .of(context)
                          //                                                 .exp_date,
                          //                                             style: Theme.of(
                          //                                                     context)
                          //                                                 .textTheme
                          //                                                 .subtitle1,
                          //                                           ),
                          //                                           SizedBox(
                          //                                             height: 4,
                          //                                           ),
                          //                                           SizedBox(
                          //                                             width: 86,
                          //                                             child:
                          //                                                 PropertyInput(
                          //                                               textController:
                          //                                                   TextEditingController(),
                          //                                               personal:
                          //                                                   false,
                          //                                               small:
                          //                                                   true,
                          //                                               onSaved:
                          //                                                   (input) {},
                          //                                               onChange:
                          //                                                   (input) {},
                          //                                               hintText:
                          //                                                   'MM/YY',
                          //                                               maxLines:
                          //                                                   1,
                          //                                               maxLength:
                          //                                                   5,
                          //                                               inputFormatters: [
                          //                                                 TextInputMask(
                          //                                                     mask: '9X/999')
                          //                                               ],
                          //                                               keyboardType:
                          //                                                   TextInputType.number,
                          //                                               // labelText: "Город, улица, дом",
                          //                                             ),
                          //                                           )
                          //                                         ],
                          //                                       ),
                          //                                     ),
                          //                                     Column(
                          //                                       crossAxisAlignment:
                          //                                           CrossAxisAlignment
                          //                                               .end,
                          //                                       children: [
                          //                                         Text(
                          //                                           S
                          //                                               .of(context)
                          //                                               .cvv_cvc,
                          //                                           style: Theme.of(
                          //                                                   context)
                          //                                               .textTheme
                          //                                               .subtitle1,
                          //                                         ),
                          //                                         SizedBox(
                          //                                           height: 4,
                          //                                         ),
                          //                                         SizedBox(
                          //                                           width: 60,
                          //                                           child:
                          //                                               PropertyInput(
                          //                                             textController:
                          //                                                 TextEditingController(),
                          //                                             personal:
                          //                                                 false,
                          //                                             small:
                          //                                                 true,
                          //                                             onSaved:
                          //                                                 (input) {},
                          //                                             onChange:
                          //                                                 (input) {},
                          //                                             hintText:
                          //                                                 '123',
                          //                                             maxLines:
                          //                                                 1,
                          //                                             maxLength:
                          //                                                 3,
                          //                                             inputFormatters: [
                          //                                               TextInputMask(
                          //                                                   mask:
                          //                                                       '999')
                          //                                             ],
                          //                                             keyboardType:
                          //                                                 TextInputType
                          //                                                     .number,
                          //                                             // labelText: "Город, улица, дом",
                          //                                           ),
                          //                                         )
                          //                                       ],
                          //                                     )
                          //                                   ],
                          //                                 ),
                          //                                 SizedBox(
                          //                                   height: 12,
                          //                                 ),
                          //                                 Expanded(
                          //                                   child: Row(
                          //                                     mainAxisAlignment:
                          //                                         MainAxisAlignment
                          //                                             .end,
                          //                                     children: [
                          //                                       Image.asset(
                          //                                         'assets/img/mir.png',
                          //                                       ),
                          //                                     ],
                          //                                   ),
                          //                                 ),
                          //                               ],
                          //                             ),
                          //                           ),
                          //                           SizedBox(
                          //                             height: 8,
                          //                           ),
                          //                           CheckBoxWidget(
                          //                               checkboxTextFirst: Text(
                          //                                 'Сохранить карту',
                          //                                 style: Theme.of(
                          //                                         context)
                          //                                     .textTheme
                          //                                     .overline
                          //                                     .merge(TextStyle(
                          //                                         color:
                          //                                             neutral_500,
                          //                                         height: 1.1)),
                          //                               ),
                          //                               checkboxTextSecond:
                          //                                   InkWell(
                          //                                 ///открывается страница с этим
                          //                                 onTap: () {},
                          //                                 child: RichText(
                          //                                   text: TextSpan(
                          //                                     text:
                          //                                         'Сохраняя карту, вы соглашаетесь с условиями ',
                          //                                     style: Theme.of(
                          //                                             context)
                          //                                         .textTheme
                          //                                         .overline
                          //                                         .merge(
                          //                                             TextStyle(
                          //                                           color:
                          //                                               neutral_400,
                          //                                           height: 1.1,
                          //                                         )),
                          //                                     children: [
                          //                                       TextSpan(
                          //                                           text:
                          //                                               'привязки карты',
                          //                                           style: Theme.of(
                          //                                                   context)
                          //                                               .textTheme
                          //                                               .overline
                          //                                               .merge(TextStyle(
                          //                                                   color:
                          //                                                       neutral_400,
                          //                                                   height:
                          //                                                       1.1,
                          //                                                   decoration:
                          //                                                       TextDecoration.underline))),
                          //                                     ],
                          //                                   ),
                          //                                 ),
                          //                               )),
                          //                           SizedBox(
                          //                             height: 8,
                          //                           ),
                          //                           PrimaryButton(
                          //                             icon: null,
                          //                             small: false,
                          //                             text: "Сохранить",
                          //                             min_width: 176,
                          //                             min_height: 48,
                          //                             left_padding: 0,
                          //                             right_padding: 0,
                          //                             top_padding: 14,
                          //                             bottom_padding: 14,
                          //                             border_radius: 5,
                          //                             buttonText: true,
                          //                             onPressed: () =>
                          //                                 Navigator.of(context)
                          //                                     .pop(),
                          //                           )
                          //                         ],
                          //                       ),
                          //                     ),
                          //                     title: S.of(context).add_card,
                          //                     showAll: false,
                          //                   );
                          //                 }),
                          //             child: Container(
                          //               alignment: Alignment.center,
                          //               height: 64,
                          //               width: 112,
                          //               decoration: BoxDecoration(
                          //                 borderRadius:
                          //                     BorderRadius.circular(5.0),
                          //                 color: expanded_light_neutral_100,
                          //               ),
                          //               child: Padding(
                          //                 padding: EdgeInsets.only(
                          //                     left: 12,
                          //                     right: 12,
                          //                     top: 4,
                          //                     bottom: 8),
                          //                 child: Column(
                          //                   children: [
                          //                     SvgPicture.asset(
                          //                         "assets/icons/add_card.svg"),
                          //                     SizedBox(
                          //                       height: 6,
                          //                     ),
                          //                     Text('Добавить карту',
                          //                         style: Theme.of(context)
                          //                             .textTheme
                          //                             .overline
                          //                             .merge(TextStyle(
                          //                                 // height: 1.2,
                          //                                 color: neutral_350,
                          //                                 fontWeight: FontWeight
                          //                                     .w500))),
                          //                   ],
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          SizedBox(
                            height: 8,
                          ),
                          // Container(
                          //   color: primary_50,
                          //   padding: const EdgeInsets.only(
                          //       left: 16, right: 16, bottom: 12),
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Padding(
                          //         padding:
                          //             const EdgeInsets.symmetric(vertical: 12),
                          //         child: Text(
                          //           "Язык приложения",
                          //           style:
                          //               Theme.of(context).textTheme.subtitle1,
                          //         ),
                          //       ),
                          //       SizedBox(
                          //         height: 32,
                          //         child: ListView.builder(
                          //           itemCount: languages.length,
                          //           scrollDirection: Axis.horizontal,
                          //           itemBuilder: (context, int index) {
                          //             return Row(
                          //               children: [
                          //                 InkWell(
                          //                   onTap: () {
                          //                     setState(() {
                          //                       selectedIndex = index;
                          //                     });
                          //                   },
                          //                   child: Container(
                          //                     alignment: Alignment.center,
                          //                     height: 32,
                          //                     decoration: BoxDecoration(
                          //                         border: selectedIndex == index
                          //                             ? Border.all(
                          //                                 color: secondary_300)
                          //                             : Border.all(
                          //                                 style:
                          //                                     BorderStyle.none),
                          //                         color: selectedIndex == index
                          //                             ? secondary_100
                          //                             : expanded_light_neutral_100,
                          //                         borderRadius:
                          //                             BorderRadius.circular(
                          //                                 5.0)),
                          //                     child: Padding(
                          //                       padding: EdgeInsets.only(
                          //                           left: 12, right: 12),
                          //                       child: Text(languages[index],
                          //                           style: Theme.of(context)
                          //                               .textTheme
                          //                               .caption
                          //                               .merge(TextStyle(
                          //                                   height: 1.1,
                          //                                   color: selectedIndex ==
                          //                                           index
                          //                                       ? secondary_300
                          //                                       : neutral_350))),
                          //                     ),
                          //                   ),
                          //                 ),
                          //                 index != languages.length - 1
                          //                     ? SizedBox(
                          //                         width: 8,
                          //                       )
                          //                     : SizedBox(),
                          //               ],
                          //             );
                          //           },
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            color: primary_50,
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, bottom: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  child: Text(
                                    "Поддержка",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                ),
                                Text(
                                  "Свяжитесь с нами",
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/call.svg',
                                        color: neutral_400,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          _handleLaunchUrl();
                                        },
                                        child: Text(
                                          "923-500",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .merge(TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: neutral_400,
                                                  height: 1.1,
                                                  decoration: TextDecoration
                                                      .underline)),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/alternate_email.svg',
                                        color: neutral_400,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          _handleLaunchUrl();
                                        },
                                        child: Text(
                                          "info@amelia53.ru",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .merge(TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: neutral_400,
                                                  height: 1.1,
                                                  decoration: TextDecoration
                                                      .underline)),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/mail.svg',
                                        color: neutral_400,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          _handleLaunchUrl();
                                        },
                                        child: Text(
                                          "vk.com/amelia53",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .merge(TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: neutral_400,
                                                  height: 1.1,
                                                  decoration: TextDecoration
                                                      .underline)),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      InkWell(
                        onTap: () => showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                AlertDialogWidget(
                                  title: "Удалить аккаунт?",
                                  // fireButtonLabel: 'Удалить',
                                  onYes: "Удалить",
                                  onYesCallBack: () {
                                    // delete user
                                    userRepo.logout();
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: DeleteLabel(
                            small: false,
                            title: "Удалить аккаунт",
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    shadowColor: expanded_light_neutral_100.withOpacity(0.2),
                    pinned: true,
                    floating: true,
                    automaticallyImplyLeading: false,
                    collapsedHeight: 90,
                    backgroundColor: primary_50,
                    expandedHeight: 90,
                    flexibleSpace: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  S.of(context).profile,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .merge(TextStyle(
                                          fontWeight: FontWeight.w500)),
                                ),
                                InkWell(
                                  onTap: () => showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      backgroundColor: Colors.transparent,
                                      builder: (_) {
                                        return ModalBottomSheetWidget(
                                          reset: false,
                                          initialChildSize: 0.30,
                                          widget: Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: Column(
                                              children: [
                                                PropertyInput(
                                                  // textController:
                                                  //     TextEditingController(),
                                                  textController:
                                                      _userNameTextController,
                                                  personal: false,
                                                  small: false,
                                                  onSaved: (input) {},
                                                  onChange: (input) {},
                                                  hintText: 'Имя и фамилия',
                                                  maxLines: 1,
                                                  maxLength: 100,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  labelText: "Имя и фамилия",
                                                ),
                                                SizedBox(
                                                  height: 16,
                                                ),
                                                PrimaryButton(
                                                  icon: null,
                                                  small: false,
                                                  text: "Сохранить изменения",
                                                  onPressed: () async {
                                                    // ! сделать отправку имени пользователя на сервер

                                                    await _saveUserNameToPrefs();
                                                    Navigator.of(context).pop();
                                                  },
                                                  min_width: 176,
                                                  min_height: 48,
                                                  left_padding: 0,
                                                  right_padding: 0,
                                                  top_padding: 14,
                                                  bottom_padding: 14,
                                                  border_radius: 5,
                                                  buttonText: true,
                                                ),
                                              ],
                                            ),
                                          ),
                                          title: "Имя и фамилия",
                                          showAll: false,
                                        );
                                      }),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                    child: Row(
                                      children: [
                                        Text(
                                          currentUser.value.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .merge(TextStyle(
                                                  color: neutral_500,
                                                  height: 1.2)),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        SvgPicture.asset(
                                          'assets/icons/edit_200_20.svg',
                                          color: neutral_400,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (currentUser.value.apiToken != null) {
                                logout().then((value) {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      '/Pages', (Route<dynamic> route) => false,
                                      arguments: 0);
                                });
                              } else {
                                Navigator.of(context).pushNamed('/Login');
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: expanded_light_neutral_100),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/logout.svg',
                                    color: neutral_500,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    S.of(context).log_out,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .merge(TextStyle(
                                            color: neutral_500, height: 1.2)),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ];
              }),
    );

    // SingleChildScrollView(
    //         padding: EdgeInsets.symmetric(vertical: 7),
    //         child: Column(
    //           children: <Widget>[
    //
    //             Padding(
    //               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    //               child: Row(
    //                 children: <Widget>[
    //                   Expanded(
    //                     child: Column(
    //                       children: <Widget>[
    //                         Text(
    //                           currentUser.value.name,
    //                           textAlign: TextAlign.left,
    //                           style: Theme.of(context).textTheme.headline3,
    //                         ),
    //                         Text(
    //                           currentUser.value.email,
    //                           style: Theme.of(context).textTheme.caption,
    //                         )
    //                       ],
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                     ),
    //                   ),
    //                   SizedBox(
    //                       width: 55,
    //                       height: 55,
    //                       child: InkWell(
    //                         borderRadius: BorderRadius.circular(300),
    //                         onTap: () {
    //                           Navigator.of(context).pushNamed('/Profile');
    //                         },
    //                         child: CircleAvatar(
    //                           backgroundImage: NetworkImage(currentUser.value.image.thumb),
    //                         ),
    //                       )),
    //                 ],
    //               ),
    //             ),
    //             Container(
    //               margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    //               decoration: BoxDecoration(
    //                 color: Theme.of(context).primaryColor,
    //                 borderRadius: BorderRadius.circular(6),
    //                 boxShadow: [BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.15), offset: Offset(0, 3), blurRadius: 10)],
    //               ),
    //               child: ListView(
    //                 shrinkWrap: true,
    //                 primary: false,
    //                 children: <Widget>[
    //                   ListTile(
    //                     leading: Icon(Icons.person_outline),
    //                     title: Text(
    //                       S.of(context).profile_settings,
    //                       style: Theme.of(context).textTheme.bodyText1,
    //                     ),
    //                     trailing: ButtonTheme(
    //                       padding: EdgeInsets.all(0),
    //                       minWidth: 50.0,
    //                       height: 25.0,
    //                       child: ProfileSettingsDialog(
    //                         user: currentUser.value,
    //                         onChanged: () {
    //                           var bottomSheetController = _con.scaffoldKey.currentState.showBottomSheet(
    //                             (context) => MobileVerificationBottomSheetWidget(scaffoldKey: _con.scaffoldKey, user: currentUser.value),
    //                             shape: RoundedRectangleBorder(
    //                               borderRadius: new BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
    //                             ),
    //                           );
    //                           bottomSheetController.closed.then((value) {
    //                             _con.update(currentUser.value);
    //                           });
    //                           //setState(() {});
    //                         },
    //                       ),
    //                     ),
    //                   ),
    //                   ListTile(
    //                     onTap: () {},
    //                     dense: true,
    //                     title: Text(
    //                       S.of(context).full_name,
    //                       style: Theme.of(context).textTheme.bodyText2,
    //                     ),
    //                     trailing: Text(
    //                       currentUser.value.name,
    //                       style: TextStyle(color: Theme.of(context).focusColor),
    //                     ),
    //                   ),
    //                   ListTile(
    //                     onTap: () {},
    //                     dense: true,
    //                     title: Text(
    //                       S.of(context).email,
    //                       style: Theme.of(context).textTheme.bodyText2,
    //                     ),
    //                     trailing: Text(
    //                       currentUser.value.email,
    //                       style: TextStyle(color: Theme.of(context).focusColor),
    //                     ),
    //                   ),
    //                   ListTile(
    //                     onTap: () {},
    //                     dense: true,
    //                     title: Wrap(
    //                       spacing: 8,
    //                       crossAxisAlignment: WrapCrossAlignment.center,
    //                       children: [
    //                         Text(
    //                           S.of(context).phone,
    //                           style: Theme.of(context).textTheme.bodyText2,
    //                         ),
    //                         if (currentUser.value.verifiedPhone ?? false)
    //                           Icon(
    //                             Icons.check_circle_outline,
    //                             color: Theme.of(context).accentColor,
    //                             size: 22,
    //                           )
    //                       ],
    //                     ),
    //                     trailing: Text(
    //                       currentUser.value.phone,
    //                       style: TextStyle(color: Theme.of(context).focusColor),
    //                     ),
    //                   ),
    //                   ListTile(
    //                     onTap: () {},
    //                     dense: true,
    //                     title: Text(
    //                       S.of(context).address,
    //                       style: Theme.of(context).textTheme.bodyText2,
    //                     ),
    //                     trailing: Text(
    //                       Helper.limitString(currentUser.value.address ?? S.of(context).unknown),
    //                       overflow: TextOverflow.fade,
    //                       softWrap: false,
    //                       style: TextStyle(color: Theme.of(context).focusColor),
    //                     ),
    //                   ),
    //                   //space at the bottom
    //                   SizedBox(height:4),
    //                 ],
    //               ),
    //             ),
    //             Container(
    //               margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    //               decoration: BoxDecoration(
    //                 color: Theme.of(context).primaryColor,
    //                 borderRadius: BorderRadius.circular(6),
    //                 boxShadow: [BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.15), offset: Offset(0, 3), blurRadius: 10)],
    //               ),
    //               child: ListView(
    //                 shrinkWrap: true,
    //                 primary: false,
    //                 children: <Widget>[
    //                   ListTile(
    //                     leading: Icon(Icons.credit_card),
    //                     title: Text(
    //                       S.of(context).payments_settings,
    //                       style: Theme.of(context).textTheme.bodyText1,
    //                     ),
    //                     trailing: ButtonTheme(
    //                       padding: EdgeInsets.all(0),
    //                       minWidth: 50.0,
    //                       height: 25.0,
    //                       child: PaymentSettingsDialog(
    //                         creditCard: _con.creditCard,
    //                         onChanged: () {
    //                           _con.updateCreditCard(_con.creditCard);
    //                           //setState(() {});
    //                         },
    //                       ),
    //                     ),
    //                   ),
    //                   ListTile(
    //                     dense: true,
    //                     title: Text(
    //                       S.of(context).default_credit_card,
    //                       style: Theme.of(context).textTheme.bodyText2,
    //                     ),
    //                     trailing: Text(
    //                       _con.creditCard.number.isNotEmpty ? _con.creditCard.number.replaceRange(0, _con.creditCard.number.length - 4, '...') : '',
    //                       style: TextStyle(color: Theme.of(context).focusColor),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             Container(
    //               margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    //               decoration: BoxDecoration(
    //                 color: Theme.of(context).primaryColor,
    //                 borderRadius: BorderRadius.circular(6),
    //                 boxShadow: [BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.15), offset: Offset(0, 3), blurRadius: 10)],
    //               ),
    //               child: ListView(
    //                 shrinkWrap: true,
    //                 primary: false,
    //                 children: <Widget>[
    //                   ListTile(
    //                     leading: Icon(Icons.settings_outlined),
    //                     title: Text(
    //                       S.of(context).app_settings,
    //                       style: Theme.of(context).textTheme.bodyText1,
    //                     ),
    //                   ),
    //                   ListTile(
    //                     onTap: () {
    //                       Navigator.of(context).pushNamed('/Languages');
    //                     },
    //                     dense: true,
    //                     title: Row(
    //                       children: <Widget>[
    //                         Icon(
    //                           Icons.translate,
    //                           size: 22,
    //                           color: Theme.of(context).focusColor,
    //                         ),
    //                         SizedBox(width: 10),
    //                         Text(
    //                           S.of(context).languages,
    //                           style: Theme.of(context).textTheme.bodyText2,
    //                         ),
    //                       ],
    //                     ),
    //                     trailing: Text(
    //                       S.of(context).english,
    //                       style: TextStyle(color: Theme.of(context).focusColor),
    //                     ),
    //                   ),
    //                   ListTile(
    //                     onTap: () {
    //                       Navigator.of(context).pushNamed('/DeliveryAddresses');
    //                     },
    //                     dense: true,
    //                     title: Row(
    //                       children: <Widget>[
    //                         Icon(
    //                           Icons.place_outlined,
    //                           size: 22,
    //                           color: Theme.of(context).focusColor,
    //                         ),
    //                         SizedBox(width: 10),
    //                         Text(
    //                           S.of(context).delivery_addresses,
    //                           style: Theme.of(context).textTheme.bodyText2,
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   ListTile(
    //                     onTap: () {
    //                       Navigator.of(context).pushNamed('/Help');
    //                     },
    //                     dense: true,
    //                     title: Row(
    //                       children: <Widget>[
    //                         Icon(
    //                           Icons.help_outline,
    //                           size: 22,
    //                           color: Theme.of(context).focusColor,
    //                         ),
    //                         SizedBox(width: 10),
    //                         Text(
    //                           S.of(context).help_support,
    //                           style: Theme.of(context).textTheme.bodyText2,
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //       ));
  }
}
