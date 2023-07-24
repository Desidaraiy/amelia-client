import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/components/PrimaryButtonWidget.dart';
import 'package:markets/src/components/ReviewItemWidget.dart';
import 'package:markets/src/components/TextInputWidget.dart';
import 'package:markets/src/helpers/colors.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/reviews_controller.dart';
import '../elements/CircularLoadingWidget.dart';
import '../models/route_argument.dart';

class WriteReviewWidget extends StatefulWidget {
  final RouteArgument routeArgument;

  WriteReviewWidget({Key key, this.routeArgument}) : super(key: key);

  @override
  _WriteReviewWidgetState createState() {
    return _WriteReviewWidgetState();
  }
}

class _WriteReviewWidgetState extends StateMVC<WriteReviewWidget> {
  ReviewsController _con;

  _WriteReviewWidgetState() : super(ReviewsController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForOrder(orderId: widget.routeArgument.id);
    super.initState();
  }

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
            S.of(context).new_review,
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        key: _con.scaffoldKey,
        body: RefreshIndicator(
            onRefresh: _con.refreshOrder,
            child: _con.order == null
                ? CircularLoadingWidget(height: 500)
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Column(
                        children: <Widget>[
                          ReviewItemWidget(order: _con.order,),
                          SizedBox(height: 24),
                          Text(
                            "Оцените товар!",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(fontSize: 20.74)),
                          ),
                          SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(5, (star) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    _con.productsReviews[0].rate = (star + 1).toString();
                                  });
                                },
                                child: star < int.parse(_con.productsReviews[0].rate)
                                    ? SvgPicture.asset(
                                  'assets/icons/grade_300_48.svg',
                                  color: accent_200,
                                )
                                    : SvgPicture.asset(
                                  'assets/icons/grade_300_48.svg',
                                  color: neutral_100,
                                ),
                              );
                            }),
                          ),

                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: PropertyInput(     textController: TextEditingController(),
                              personal: false,
                              onSaved: (input) {},small:false,
                              onChange: (input) { _con.productsReviews[0].review = input;},
                              hintText: 'Ваш отзыв',
                              maxLines: 7,
                              maxLength: 500,
                              prefixIcon: null,
                              keyboardType: TextInputType.text,
                              labelText: "Ваш отзыв",
                            ),
                          ),
                          SizedBox(height: 8,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: PrimaryButton(
                              icon: null,
                              small: false,
                              text: "Написать отзыв",
                              onPressed: () {
                                _con.addProductReview(_con.productsReviews[0], _con.productsOfOrder[0]);
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
                          ),
                        ],
                      )
                        ],
                      ),
                    ),
                  )));
  }
}
