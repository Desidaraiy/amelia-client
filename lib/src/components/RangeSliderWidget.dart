import 'package:flutter/material.dart';
import 'package:markets/src/helpers/colors.dart';

class RangeSliderWidget extends StatefulWidget {
  const RangeSliderWidget({Key key, this.minPrice, this.maxPrice}) : super(key: key);
  final double minPrice;
  final double maxPrice;
  @override
  State<RangeSliderWidget> createState() => _RangeSliderWidgetState();
}

class _RangeSliderWidgetState extends State<RangeSliderWidget> {
  RangeValues _currentRangeValues = const RangeValues(2350, 5500);
  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      min: widget.minPrice,
      inactiveColor: neutral_200,
      activeColor: neutral_500,
      values: _currentRangeValues,
      max: widget.maxPrice,
      // divisions: 10,
      labels: RangeLabels(
        _currentRangeValues.start.round().toString(),
        _currentRangeValues.end.round().toString(),
      ),
      onChanged: (RangeValues values) {
        setState(() {
          _currentRangeValues = values;
        });
      },
    );
  }
}
