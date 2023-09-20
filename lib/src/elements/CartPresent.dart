import 'package:flutter/material.dart';
import 'package:markets/src/components/SetWidget.dart';
import 'package:markets/src/helpers/colors.dart';
import 'package:markets/src/models/present.dart';

class CartPresent extends StatelessWidget {
  const CartPresent({this.present});
  final CartPresentModel present;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      child: Column(
        children: [
          ProductSet(
            icon: false,
            imgName: 'set',
            imgUrl: present.imageurl,
            setName: present.name,
            small: true,
          ),
          SizedBox(
            height: 2,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "0",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                width: 1,
              ),
              Text(
                '₽',
                style: Theme.of(context)
                    .textTheme
                    .overline
                    .merge(TextStyle(color: primary_700)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
