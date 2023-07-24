import 'package:flutter/material.dart';
import 'package:markets/src/helpers/colors.dart';

class AlertDialogWidget extends StatelessWidget {
  final String fireButtonLabel;
  const AlertDialogWidget(
      {Key key,
      this.title,
      this.onYes,
      this.onYesCallBack,
      this.fireButtonLabel = 'Удалить'})
      : super(key: key);

  final String title;
  final String onYes;
  final VoidCallback onYesCallBack;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      buttonPadding: EdgeInsets.all(0),
      actionsPadding: EdgeInsets.only(right: 12, top: 8),
      titlePadding: EdgeInsets.fromLTRB(8, 20, 8, 0),
      backgroundColor: neutral_100,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, 'Отмена'),
          child: Text('Отмена',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .merge(TextStyle(color: neutral_500))),
        ),
        TextButton(
          onPressed: () {
            onYesCallBack();
          },
          child: Text(fireButtonLabel,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .merge(TextStyle(color: expanded_red_450))),
        ),
      ],
    );
  }
}
