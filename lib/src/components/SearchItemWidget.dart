import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/helpers/colors.dart';

class SearchItem extends StatelessWidget {
  const SearchItem(
      {Key key,
      this.topLeft,
      this.topRight,
      this.bottomLeft,
      this.bottomRight,
      this.title,
      this.category,
      this.sale,
      this.price,
      this.newPrice,
      this.cardHeight,
      this.imageUrl,
      this.imgSize})
      : super(key: key);
  final double topLeft;
  final double topRight;
  final double bottomLeft;
  final double bottomRight;
  final String title;
  final String category;
  final bool sale;
  final String price;
  final String newPrice;
  final double cardHeight;
  final double imgSize;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 6),
      height: cardHeight,
      decoration: BoxDecoration(
          color: primary_50,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(topLeft),
              topRight: Radius.circular(topRight),
              bottomRight: Radius.circular(bottomRight),
              bottomLeft: Radius.circular(bottomLeft))),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(3.0)),
            child: CachedNetworkImage(
                height: imgSize,
                width: imgSize,
                fit: BoxFit.cover,
                imageUrl: imageUrl ?? 'https://via.placeholder.com/150x150'),
          ),
          SizedBox(
            width: 6,
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              category,
                              style: Theme.of(context).textTheme.overline,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  price,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .merge(TextStyle(fontSize: 12.34)),
                                ),
                                SizedBox(
                                  width: 1,
                                ),
                                Text(
                                  '₽',
                                  style: Theme.of(context)
                                      .textTheme
                                      .overline
                                      .merge(TextStyle(
                                          color: primary_700, fontSize: 10.16)),
                                ),
                              ],
                            ),
                            sale == true
                                ? Row(
                                    children: [
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        newPrice,
                                        style: Theme.of(context)
                                            .textTheme
                                            .overline
                                            .merge(TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 10.16)),
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SvgPicture.asset(
                  'assets/icons/navigate_next_200.svg',
                  height: 24,
                  width: 24,
                  fit: BoxFit.scaleDown,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
