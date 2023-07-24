import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:markets/src/helpers/colors.dart';

class SmallPropertyInput extends StatefulWidget {
  SmallPropertyInput({
    Key key,
    this.onChange,
    this.errorText = '',
    this.propertyInvalid = false,
    this.maxLines,
    this.maxLength,
    // this.keyboardType,
    this.inputFormatters,
    this.error_border,
    this.onSaved,
    this.controller,
    this.focusNode,
  }) : super(key: key);
  final Function(String) onChange;
  final String errorText;
  final bool propertyInvalid;
  final int maxLines;
  final int maxLength;
  // final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final error_border;
  final Function(String) onSaved;
  final FocusNode focusNode;
  final TextEditingController controller;

  @override
  _SmallPropertyInputState createState() => _SmallPropertyInputState();
}

class _SmallPropertyInputState extends State<SmallPropertyInput> {
  // final TextEditingController _textController = new TextEditingController();
  // FocusNode focusNode = FocusNode();
  // @override
  // @override
  // void dispose() {
  //   focusNode.dispose();
  //   _textController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: widget.onSaved,
      textAlign: TextAlign.center,
      controller: widget.controller,
      focusNode: widget.focusNode,
      keyboardType: TextInputType.number,
      inputFormatters: widget.inputFormatters,
      onChanged: widget.onChange,
      cursorColor: Theme.of(context).primaryColor,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      style: Theme.of(context)
          .textTheme
          .subtitle1
          .merge(TextStyle(fontSize: 16, color: neutral_500)),
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        filled: true,
        fillColor: primary_50,
        counterText: "",
        errorText: widget.propertyInvalid ? widget.errorText : null,
        errorStyle: Theme.of(context)
            .textTheme
            .overline
            .merge(TextStyle(color: semantic_error)),
        // contentPadding: widget.prefixIcon == null
        //     ? const EdgeInsets.fromLTRB(16, 8, 16, 8)
        //     : const EdgeInsets.fromLTRB(16, 16, 16, 8),
        border: InputBorder.none,
        errorBorder: UnderlineInputBorder(
          // borderSide:  BorderSide(color: redCustom, width: 1.5),
          borderRadius: BorderRadius.circular(5.0),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: expanded_light_neutral_100,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: primary_50,
              width: 0,
            ),
            borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }
}
