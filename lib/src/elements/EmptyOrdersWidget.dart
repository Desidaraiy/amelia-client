import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/components/PrimaryButtonWidget.dart';
import 'package:markets/src/helpers/colors.dart';

import '../../generated/l10n.dart';
import '../helpers/app_config.dart' as config;

class EmptyOrdersWidget extends StatefulWidget {
  EmptyOrdersWidget({
    Key key,
  }) : super(key: key);

  @override
  _EmptyOrdersWidgetState createState() => _EmptyOrdersWidgetState();
}

class _EmptyOrdersWidgetState extends State<EmptyOrdersWidget> {
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
            backgroundColor:
            Theme.of(context).accentColor.withOpacity(0.2),
          ),
        )
            : SizedBox(),
        Container(
          alignment: AlignmentDirectional.center,
          padding: EdgeInsets.symmetric(horizontal: 16),
          height: config.App(context).appHeight(70),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                'assets/img/no_orders.png',

                // fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Text(
                S.of(context).you_dont_have_orders,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(height: 6),
              Text(
                S.of(context).here_your_orders,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4.merge(
                    TextStyle(color: neutral_200, fontWeight: FontWeight.w400)),
              ),
              // SizedBox(height: 24),
              // !loading,
              // SizedBox(
              //   width: 124,
              //   child: PrimaryButton(
              //     min_width:80,
              //     min_height:48,
              //     buttonText:true,
              //     onPressed: () {
              //       Navigator.of(context).pushNamed('/Pages', arguments: 0);
              //     },
              //     icon: SvgPicture.asset(
              //       'assets/icons/navigate_before_300.svg',
              //       color: primary_50,
              //       width: 24,
              //       height: 24,
              //       fit: BoxFit.scaleDown,
              //     ),
              //     text: 'На главную',
              //     small: true,
              //     left_padding: 14,
              //     right_padding: 14,
              //     top_padding: 10,
              //     bottom_padding: 10,
              //     border_radius: 10,
              //   ),
              // )
            ],
          ),
        ),
      ],
    );
  }
}
