import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/helpers/colors.dart';

class ProductReviewWidget extends StatelessWidget {
  const ProductReviewWidget({Key key, this.show_all}) : super(key: key);
  final bool show_all;
  @override
  Widget build(BuildContext context) {
    return !show_all ? Container(
      width: 248,
      height: 62,
      decoration: BoxDecoration(
          color: primary_50, borderRadius: BorderRadius.circular(5.0)),
      padding: EdgeInsets.fromLTRB(6, 8, 8, 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/grade_200_16.svg',
                      color: accent_200,
                    ),
                    SvgPicture.asset(
                      'assets/icons/grade_200_16.svg',
                      color: accent_200,
                    ),
                    SvgPicture.asset(
                      'assets/icons/grade_200_16.svg',
                      color: accent_200,
                    ),
                    SvgPicture.asset(
                      'assets/icons/grade_200_16.svg',
                      color: accent_200,
                    ),
                    SvgPicture.asset(
                      'assets/icons/grade_200_16.svg',
                      color: neutral_100,
                    ),
                  ],
                ),
              ),
              Text(
                "Лариса Никитенко",
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .merge(TextStyle(color: neutral_200, height: 1.2)),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "2 дня назад",
                  style: Theme.of(context)
                      .textTheme
                      .overline
                      .merge(TextStyle(fontSize: 10.16, color: neutral_200, )),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  "Очень понравился букет:)) Сестра была очень рада! Доставка очень быстрая",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.caption.merge(TextStyle(color: neutral_500, height: 1.2)),
                )
              ],
            ),
          )
        ],
      ),
    ):Container(
      decoration: BoxDecoration(
          color: primary_50, borderRadius: BorderRadius.circular(5.0)),
      padding: EdgeInsets.fromLTRB(6, 8, 8, 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/grade_200_16.svg',
                      color: accent_200,
                    ),
                    SvgPicture.asset(
                      'assets/icons/grade_200_16.svg',
                      color: accent_200,
                    ),
                    SvgPicture.asset(
                      'assets/icons/grade_200_16.svg',
                      color: accent_200,
                    ),
                    SvgPicture.asset(
                      'assets/icons/grade_200_16.svg',
                      color: accent_200,
                    ),
                    SvgPicture.asset(
                      'assets/icons/grade_200_16.svg',
                      color: neutral_100,
                    ),
                  ],
                ),
              ),
              Text(
                "Лариса Никитенко",
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .merge(TextStyle(color: neutral_200, height: 1.2)),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "2 дня назад",
                  style: Theme.of(context)
                      .textTheme
                      .overline
                      .merge(TextStyle(fontSize: 10.16, color: neutral_200, )),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  "Очень понравился букет:)) Сестра была очень рада! Доставка очень быстрая",
                  style: Theme.of(context).textTheme.caption.merge(TextStyle(color: neutral_500, height: 1.2)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
