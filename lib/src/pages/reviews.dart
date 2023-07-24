import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/components/PrimaryButtonWidget.dart';
import 'package:markets/src/components/ProductReviewWidget.dart';
import 'package:markets/src/components/ReviewItemWidget.dart';
import 'package:markets/src/components/TextInputWidget.dart';
import 'package:markets/src/helpers/colors.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/reviews_controller.dart';
import '../elements/CircularLoadingWidget.dart';
import '../models/route_argument.dart';

class ReviewsWidget extends StatelessWidget {
  const ReviewsWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: primary_50,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: SvgPicture.asset(
            'assets/icons/navigate_before_200.svg',
            color: primary_700,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).reviews,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              PrimaryButton(
                icon: null,
                small: false,
                text: "Написать отзыв",
                onPressed: () {
                  // Navigator.of(context).pushNamed('/WriteReview', arguments: RouteArgument(id: order.id, heroTag: "market_reviews"));
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
              SizedBox(
                height: 16,
              ),
              ProductReviewWidget(
                show_all: true,
              ),
              SizedBox(
                height: 8,
              ),
              ProductReviewWidget(
                show_all: true,
              ),
              SizedBox(
                height: 8,
              ),
              ProductReviewWidget(
                show_all: true,
              ),
              SizedBox(
                height: 8,
              ),
              ProductReviewWidget(
                show_all: true,
              ),
              SizedBox(
                height: 8,
              ),
              ProductReviewWidget(
                show_all: true,
              ),
              SizedBox(
                height: 8,
              ),
              ProductReviewWidget(
                show_all: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
