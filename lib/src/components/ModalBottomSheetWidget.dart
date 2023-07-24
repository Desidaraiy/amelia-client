import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/helpers/colors.dart';
import '../../generated/l10n.dart';

class ModalBottomSheetWidget extends StatefulWidget {
  const ModalBottomSheetWidget(
      {Key key,
      this.initialChildSize,
      this.minChildSize,
      this.maxChildSize,
      this.widget,
      this.title,
      this.showAll,
      this.reset})
      : super(key: key);
  final Widget widget;
  final String title;
  final double initialChildSize;
  final double minChildSize;
  final double maxChildSize;
  final bool showAll;
  final bool reset;
  @override
  _ModalBottomSheetWidgetState createState() => _ModalBottomSheetWidgetState();
}

class _ModalBottomSheetWidgetState extends State<ModalBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    Widget makeDismissible({Widget child}) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.of(context).pop();
          },
          child: GestureDetector(
            onTap: () {},
            child: child,
          ),
        );
    return makeDismissible(
        child: !widget.showAll
            ? DraggableScrollableSheet(
                initialChildSize: widget.initialChildSize,
                builder: (context, controller) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20.0),
                      ),
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      controller: controller,
                      children: [
                        Container(
                          child: Flex(
                            mainAxisSize: MainAxisSize.max,
                            direction: Axis.vertical,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      topLeft: Radius.circular(20)),
                                  color: primary_50,
                                ),
                                padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                                width: double.infinity,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      Expanded(
                                        child: Stack(
                                          // fit: StackFit.loose,
                                          alignment:
                                              AlignmentDirectional.center,
                                          children: [
                                            Text(
                                              widget.title,
                                              // textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline2
                                                  .merge(
                                                    TextStyle(fontSize: 18.22),
                                                  ),
                                            ),
                                            Positioned(
                                              left: 0,
                                              child: InkWell(
                                                onTap: () =>
                                                    Navigator.of(context).pop(),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: SvgPicture.asset(
                                                    'assets/icons/navigate_before_200.svg',
                                                    color: primary_700,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            widget.reset
                                                ? Positioned(
                                                    right: 0,
                                                    child: InkWell(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 14,
                                                                bottom: 10),
                                                        child: Text(
                                                          S.of(context).reset,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline3,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : SizedBox(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              widget.widget
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                })
            : DraggableScrollableSheet(
                initialChildSize: widget.initialChildSize,
                maxChildSize: widget.maxChildSize,
                builder: (context, controller) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20.0),
                      ),
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      controller: controller,
                      children: [
                        Container(
                          child: Flex(
                            mainAxisSize: MainAxisSize.max,
                            direction: Axis.vertical,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      topLeft: Radius.circular(20)),
                                  color: primary_50,
                                ),
                                padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                                width: double.infinity,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      Expanded(
                                        child: Stack(
                                          // fit: StackFit.loose,
                                          alignment:
                                              AlignmentDirectional.center,
                                          children: [
                                            Text(widget.title,
                                                // textAlign: TextAlign.center,/
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2),
                                            Positioned(
                                              left: 0,
                                              child: InkWell(
                                                onTap: () =>
                                                    Navigator.of(context).pop(),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: SvgPicture.asset(
                                                    'assets/icons/navigate_before_200.svg',
                                                    color: primary_700,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              right: 0,
                                              child: InkWell(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 12, bottom: 12),
                                                  child: Text(
                                                    "Очистить",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline3,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              widget.widget
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }));
  }
}
