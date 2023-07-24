import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/components/PrimaryButtonWidget.dart';
import 'package:markets/src/helpers/colors.dart';

import '../../generated/l10n.dart';
import '../helpers/app_config.dart' as config;


class EmptyFavoritesWidget extends StatelessWidget {
  const EmptyFavoritesWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
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
            "Вы не добавили товары в избранное",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(height: 6),
          Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Нажмите",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4.merge(
                        TextStyle(color: neutral_200, fontWeight: FontWeight.w400)),
                  ),
                  SizedBox(width: 4),
                  SvgPicture.asset(
                    'assets/icons/favorite_filled_true.svg',
color: expanded_red_450,
                    // fit: BoxFit.cover,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "на товаре, ",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4.merge(
                        TextStyle(color: neutral_200, fontWeight: FontWeight.w400)),
                  ),
                ],
              ),
              Text(
                "чтобы добавить в избранное",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4.merge(
                    TextStyle(color: neutral_200, fontWeight: FontWeight.w400)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

