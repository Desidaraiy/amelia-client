import 'package:flutter_svg/flutter_svg.dart';

import '../../generated/l10n.dart';
import 'package:markets/src/helpers/colors.dart';
import 'package:flutter/material.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({
    Key key,
    this.sectionHeight,
    this.sectionTitle,
    this.edit,
    this.levels,
    this.title_1_1,
    this.data_1_1,
    this.title_1_2,
    this.data_1_2,
    this.title_2_1,
    this.data_2_1,
    this.title_3_1,
    this.data_3_1,
    this.title_2_2,
    this.data_2_2, this.onTap,
  }) : super(key: key);
  final double sectionHeight;
  final String sectionTitle;
  final bool edit;
  final int levels;
  final String title_1_1;
  final String data_1_1;

  final String title_1_2;
  final String data_1_2;

  final String title_2_1;
  final String data_2_1;

  final String title_2_2;
  final String data_2_2;

  final String title_3_1;
  final String data_3_1;

  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: edit
          ? EdgeInsets.fromLTRB(16, 3, 16, 16)
          : EdgeInsets.fromLTRB(16, 0, 16, 16),
      // height: sectionHeight,
      color: primary_50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              edit
                  ? Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              sectionTitle,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                          InkWell(
                            onTap: onTap,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/edit_200_20.svg',
                                    color: neutral_400,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    S.of(context).change,
                                    style: Theme.of(context)
                                        .textTheme
                                        .overline
                                        .merge(TextStyle(
                                            color: neutral_400, height: 1.2)),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(vertical: 12,),child: Text(
                sectionTitle,
                style: Theme.of(context).textTheme.subtitle1,
              ),
                    )
            ],
          ),
          levels == 3
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              title_1_1,
                              style: Theme.of(context).textTheme.overline.merge(
                                  TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: neutral_500)),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              data_1_1,
                              style: Theme.of(context)
                                  .textTheme
                                  .overline
                                  .merge(TextStyle(color: neutral_500)),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Text(
                              title_1_2,
                              style: Theme.of(context).textTheme.overline.merge(
                                    TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: neutral_500),
                                  ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              data_1_2,
                              style: Theme.of(context)
                                  .textTheme
                                  .overline
                                  .merge(TextStyle(color: neutral_500)),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Text(
                              title_2_1,
                              style: Theme.of(context).textTheme.overline.merge(
                                    TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: neutral_500),
                                  ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              data_2_1,
                              style: Theme.of(context)
                                  .textTheme
                                  .overline
                                  .merge(TextStyle(color: neutral_500)),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Text(
                              title_2_2,
                              style: Theme.of(context).textTheme.overline.merge(
                                    TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: neutral_500),
                                  ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              data_2_2,
                              style: Theme.of(context).textTheme.overline.merge(
                                    TextStyle(color: neutral_500),
                                  ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title_3_1,
                              style: Theme.of(context).textTheme.overline.merge(
                                    TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: neutral_500),
                                  ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Text(
                                data_3_1,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 20,
                                style:
                                    Theme.of(context).textTheme.overline.merge(
                                          TextStyle(color: neutral_500),
                                        ),
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title_1_1,
                          style: Theme.of(context).textTheme.overline.merge(
                            TextStyle(
                                fontWeight: FontWeight.w500,
                                color: neutral_500),
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          data_1_1,
                          style: Theme.of(context).textTheme.overline.merge(
                            TextStyle(color: neutral_500),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title_1_2,
                          style: Theme.of(context).textTheme.overline.merge(
                            TextStyle(
                                fontWeight: FontWeight.w500,
                                color: neutral_500),
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                            data_1_2,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 20,
                            style:
                            Theme.of(context).textTheme.overline.merge(
                              TextStyle(color: neutral_500),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
