import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/components/PrimaryButtonWidget.dart';
import 'package:markets/src/helpers/colors.dart';

import '../../generated/l10n.dart';
import '../helpers/app_config.dart' as config;
class NoServiceWidget extends StatelessWidget {
  const NoServiceWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Container(
      alignment: AlignmentDirectional.center,
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: config.App(context).appHeight(70),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            'assets/img/no_service.png',

            // fit: BoxFit.cover,
          ),
          SizedBox(height: 20),
          Text(
            "Нет интернет соединения",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          ),

          SizedBox(height: 12),
          // !loading,
          SizedBox(
            width: 139,
            child: PrimaryButton(
              min_width:139,
              min_height:48,
              buttonText:true,
              onPressed: () {
                Navigator.of(context).pushNamed('/Pages', arguments: 0);
              },
              text: 'Повторить',
              small: false,
              left_padding: 30,
              right_padding: 30,
              top_padding: 14,
              bottom_padding: 14,
              border_radius: 5,
            ),
          )
        ],
      ),
    );
  }
}
