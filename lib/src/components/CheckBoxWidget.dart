import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/helpers/colors.dart';

class CheckBoxWidget extends StatefulWidget {
  const CheckBoxWidget(
      {Key key,
      this.checkboxTextFirst,
      this.checkboxTextSecond,
      this.value,
      this.onChange})
      : super(key: key);
  final Widget checkboxTextFirst;
  final Widget checkboxTextSecond;
  final bool value;
  final Function(bool) onChange;
  @override
  _CheckBoxWidgetState createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  bool isChecked = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isChecked = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: widget.checkboxTextSecond != null
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isChecked = !isChecked;
              widget.onChange(isChecked);
            });
          },
          child: Padding(
              padding: EdgeInsets.only(
                  right: 10,
                  top: widget.checkboxTextSecond != null ? 0 : 10,
                  bottom: 10),
              child: isChecked
                  ? SvgPicture.asset(
                      'assets/icons/check_box_selected.svg',
                      color: primary_700,
                    )
                  : SvgPicture.asset(
                      'assets/icons/check_box.svg',
                      color: primary_700,
                    )),
        ),
        widget.checkboxTextSecond != null
            ? Expanded(
                child: Padding(
                  padding: widget.checkboxTextSecond != null
                      ? EdgeInsets.only(top: 3)
                      : EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.checkboxTextFirst,
                      // Text(
                      //   widget.checkboxTextFirst,
                      //   style: Theme.of(context).textTheme.overline.merge(
                      //       TextStyle(color: neutral_500, height: 1.1)),
                      // ),
                      SizedBox(
                        height: 6,
                      ),
                      Column(
                        children: [
                          widget.checkboxTextSecond
                          // Text(
                          //   widget.checkboxTextSecond,
                          //   overflow: TextOverflow.ellipsis,
                          //   maxLines: 10,
                          //   style: Theme.of(context)
                          //       .textTheme
                          //       .overline
                          //       .merge(TextStyle(
                          //         color: neutral_400,
                          //         height: 1.1,
                          //       )),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : widget.checkboxTextFirst
        // Text(
        //         widget.checkboxTextFirst,
        //         style: Theme.of(context)
        //             .textTheme
        //             .overline
        //             .merge(TextStyle(color: neutral_500, height: 1.1)),
        //       ),
      ],
    );
  }
}
