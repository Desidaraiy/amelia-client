import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/helpers/colors.dart';
import '../controllers/common_controller.dart';
import '../repository/settings_repository.dart' as settingsRepo;
import 'package:shared_preferences/shared_preferences.dart';

class CityDialogWidget extends StatefulWidget {
  const CityDialogWidget({
    Key key,
    this.title,
    this.controller,
    this.list,
  }) : super(key: key);
  final String title;
  final List list;
  final CommonController controller;

  @override
  _CityDialogWidgetState createState() => _CityDialogWidgetState();
}

class _CityDialogWidgetState extends State<CityDialogWidget> {
  void _selectCity(context) async {
    await settingsRepo.changeCitySettings(true, widget.list[selectedIndex]);
    await widget.controller.reInitCon();
    Navigator.of(context).pop();
  }

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.title,
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      buttonPadding: EdgeInsets.all(0),
      actionsPadding: EdgeInsets.only(right: 12, top: 8),
      titlePadding: EdgeInsets.fromLTRB(24, 22, 24, 24),
      backgroundColor: neutral_100,
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      actions: [
        TextButton(
          onPressed: () {
            _selectCity(context);
          },
          child: Text('Выбрать',
              style: Theme.of(context)
                  .textTheme
                  .button
                  .merge(TextStyle(color: primary_700, fontSize: 17.07))),
        ),
      ],
      content: SingleChildScrollView(
          child: Container(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(
              color: neutral_150,
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.list.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, int index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Text(
                              widget.list[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .merge(TextStyle(color: neutral_500)),
                            )),
                            SizedBox(
                              width: 12,
                            ),
                            Container(
                              width: 44,
                              height: 44,
                              child: selectedIndex == index
                                  ? SvgPicture.asset(
                                      'assets/icons/radio_button_checked.svg',
                                      color: neutral_500,
                                      width: 24,
                                      height: 24,
                                      fit: BoxFit.scaleDown,
                                    )
                                  : SvgPicture.asset(
                                      'assets/icons/radio_button_unchecked.svg',
                                      color: neutral_500,
                                      width: 24,
                                      height: 24,
                                      fit: BoxFit.scaleDown,
                                    ),
                            ),
                          ],
                        ),
                      ),
                      index == widget.list.length - 1
                          ? SizedBox()
                          : SizedBox(
                              height: 8,
                            )
                    ],
                  );
                },
              ),
            ),
            Divider(
              color: neutral_150,
              height: 1,
            ),
          ],
        ),
      )),
    );
  }
}
