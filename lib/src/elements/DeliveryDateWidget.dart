import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:markets/src/helpers/colors.dart';

// import 'package:ptk_inventory/config/colors.dart';

class DeliveryDateWidget extends StatefulWidget {
  final String calendarText;
  final bool active;
  final void Function() onPress;
  final DateTime date;
  const DeliveryDateWidget(
      {Key key, this.calendarText, this.onPress, this.date, this.active})
      : super(key: key);

  @override
  State<DeliveryDateWidget> createState() => _DeliveryDateWidgetState();
}

class _DeliveryDateWidgetState extends State<DeliveryDateWidget> {
  @override
  void initState() {
    super.initState();
  }

  String getText() {
    if (widget.date == null) {
      return DateFormat('EEEE, d MMMM, ' 'yyyy', 'ru_RU')
          .format(DateTime.now());
    } else {
      return '${DateFormat('EEEE, d MMMM, ' 'yyyy', 'ru_RU').format(widget.date)}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: widget.active
                ? BorderSide(width: 1.0, color: secondary_300)
                : BorderSide(width: 0.1, color: primary_50),
          ),
        ),
        alignment: Alignment.centerLeft,
        backgroundColor: MaterialStateProperty.all(
          primary_50,
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.all(12),
        ),
        elevation: MaterialStateProperty.all(0),
      ),
      onPressed: widget.onPress,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(
            'assets/icons/calendar.svg',
            color: neutral_500,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(getText(),
              style: Theme.of(context).textTheme.button.merge(
                  TextStyle(color: neutral_500, fontWeight: FontWeight.w400))),
        ],
      ),
    );
  }
}

// class ChooseDateButton extends StatefulWidget {
//   const ChooseDateButton({
//     Key key,
//     required this.calendarText,
//     required this.onPress,
//     required this.date,
//   }) : super(key: key);
//   final String calendarText;
//   final void Function()? onPress;
//   final DateTime? date;
//
//   @override
//   State<ChooseDateButton> createState() => _ChooseDateButtonState();
// }
//
// class _ChooseDateButtonState extends State<ChooseDateButton> {

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       style: ButtonStyle(
//         overlayColor: MaterialStateProperty.all(
//           const Color.fromRGBO(82, 124, 234, 0.1),
//         ),
//         shape: MaterialStateProperty.all(
//           RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(7.0),
//           ),
//         ),
//         alignment: Alignment.centerLeft,
//         backgroundColor: MaterialStateProperty.all(
//           greyCard,
//         ),
//         padding: MaterialStateProperty.all(
//           const EdgeInsets.fromLTRB(12, 0, 18, 0),
//         ),
//         elevation: MaterialStateProperty.all(0),
//       ),
//       onPressed: widget.onPress,
//       child: SizedBox(
//         height: 50,
//         width: 230,
//         child: Row(
//           // mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             const Icon(
//               Icons.calendar_month_rounded,
//               color: primaryBlue,
//             ),
//             const SizedBox(
//               width: 12,
//             ),
//             Text(
//               getText(),
//               style: const TextStyle(
//                 color: blackLabels,
//                 fontSize: 14,
//                 fontFamily: 'Rubik',
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
