import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:markets/src/helpers/colors.dart';

class DeliveryTimeWidget extends StatefulWidget {
  const DeliveryTimeWidget(
      {Key key, this.calendarText, this.onPress, this.time})
      : super(key: key);
  final String calendarText;
  final void Function() onPress;
  final TimeOfDay time;
  @override
  State<DeliveryTimeWidget> createState() => _DeliveryTimeWidgetState();
}

class _DeliveryTimeWidgetState extends State<DeliveryTimeWidget> {
  @override
  void initState() {
    super.initState();
  }

  String getText() {
    final localizations = MaterialLocalizations.of(context);
    if (widget.time == null) {
      return 'Нажмите, чтобы выбрать время';
    } else {
      final formattedTimeOfDay = localizations.formatTimeOfDay(widget.time,
          alwaysUse24HourFormat: true);
      return '${formattedTimeOfDay}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
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
            'assets/icons/clocks.svg',
            color: neutral_500,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(getText(),
              style: Theme.of(context).textTheme.button.merge(TextStyle(
                  color: neutral_500,
                  fontWeight: FontWeight.w400,
                  height: 1.25))),
        ],
      ),
    );
  }
}
