import 'package:flutter/material.dart';
import 'package:markets/src/components/PrimaryButtonWidget.dart';
import 'package:markets/src/components/SnackbarWidget.dart';
import '../../generated/l10n.dart';
import 'package:markets/src/helpers/colors.dart';

class CreateBouquetBottomSheet extends StatelessWidget {
  const CreateBouquetBottomSheet({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 15, 16, 15),
            child: Text(S.of(context).cancel,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .merge(TextStyle(height: 1.2))),
          ),
        ),
        SizedBox(
          width: 24,
        ),
        PrimaryButton(
          buttonText: true,
          min_height: 48,
          min_width: 80,
          text: S.of(context).create_bouquet,
          onPressed: () {
            Navigator.of(context).pop('create');
            // return snackbarMessage(context,
            //     S.of(context).impossible_to_create_bouquet, true, false);
          },
          small: false,
          left_padding: 16,
          right_padding: 16,
          top_padding: 15,
          bottom_padding: 15,
          border_radius: 5,
        )
      ],
    );
  }
}
