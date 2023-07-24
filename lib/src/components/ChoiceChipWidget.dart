import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/helpers/colors.dart';

class ChoiceChipWidget extends StatefulWidget {
   ChoiceChipWidget({Key key, this.title, this.index, this.selectedIndex}) : super(key: key);
  final String title;
  final int index;
  int selectedIndex;
  @override
  State<ChoiceChipWidget> createState() => _ChoiceChipWidgetState();
}

class _ChoiceChipWidgetState extends State<ChoiceChipWidget> {

  @override
  Widget build(BuildContext context) {
    return               ChipTheme(
      data: ChipTheme.of(context).copyWith(
        secondarySelectedColor: secondary_100,
        elevation: 0,
        pressElevation: 0,
        selectedColor: secondary_100,
        backgroundColor: widget.selectedIndex == widget.index
            ? secondary_100
            : primary_50,

        shape: widget.selectedIndex == widget.index
            ? StadiumBorder(
                side: BorderSide(
                color: secondary_300,
                width: 1.0,
              ))
            : null,
        // [ RoundedRectangleBorder(
        //   borderRadius: BorderRadius.all(
        //     Radius.circular(5),
        //   ),
        // ),]
      ),
      child: ChoiceChip(
        avatar: widget.selectedIndex == widget.index
            ? SvgPicture.asset(
                'assets/icons/done_300_24.svg',
                color: secondary_300)
            : null,
        label: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(widget.title,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .merge(TextStyle(
                      color: widget.selectedIndex == widget.index
                          ? secondary_300
                          : neutral_350))),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        selected: widget.selectedIndex == widget.index,
        onSelected: (selected) {
          setState(() {
            selected = !selected;
            // isSelected  = isSelected ?false:true;
            widget.selectedIndex = widget.index;
          });
        },
      ),
    );
  }
}
