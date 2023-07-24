import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:markets/src/helpers/colors.dart';

class PropertyInput extends StatefulWidget {
  PropertyInput(
      {Key key,
      this.initialValue,
      this.onChange,
      this.errorText = '',
      this.propertyInvalid = false,
      this.hintText,
      this.maxLines,
      this.maxLength,
      this.keyboardType,
      this.inputFormatters,
      this.prefixIcon,
      this.suffixIcon,
      this.style,
      this.error_border,
      this.labelText,
      this.coupon,
      this.helperText,
      this.onSaved,
      this.personal,
      this.textController,
      this.small,
      this.disabled = false})
      : super(key: key);
  final String initialValue;
  final Function(String) onChange;
  final String errorText;
  final bool propertyInvalid;
  String hintText;
  final int maxLines;
  final int maxLength;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final TextStyle style;
  final String labelText;
  final error_border;
  final bool coupon;
  final String helperText;
  final Function(String) onSaved;
  bool disabled;
  bool small = false;
  bool personal = false;
  final TextEditingController textController;

  @override
  _PropertyInputState createState() => _PropertyInputState();
}

class _PropertyInputState extends State<PropertyInput> {
  // final TextEditingController _textController =
  //     new TextEditingController(text: "");
  bool enabled;
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        widget.hintText = '';
      } else {
        widget.hintText = "";
      }
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    widget.textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: !widget.disabled,
      minLines: 1,
      onSaved: widget.onSaved,
      controller: widget.textController,
      focusNode: focusNode,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      initialValue: widget.initialValue,
      onChanged: widget.onChange,
      cursorColor: Theme.of(context).primaryColor,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      style: Theme.of(context)
          .textTheme
          .subtitle1
          .merge(TextStyle(fontSize: 16, color: neutral_500)),
      decoration: InputDecoration(
        helperStyle: Theme.of(context)
            .textTheme
            .overline
            .merge(TextStyle(color: expanded_green_400)),
        helperText: widget.helperText,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        filled: true,
        fillColor: widget.small
            ? background
            : widget.personal
                ? expanded_light_neutral_100
                : primary_50,
        labelText: widget.prefixIcon == null ? widget.labelText : null,
        counterText: "",
        suffixIcon:
            widget.textController.text.length > 0 && widget.suffixIcon != null
                ? IconButton(
                    icon: widget.suffixIcon,
                    onPressed: () {
                      setState(() {
                        widget.textController.clear();
                      });
                    })
                : null,
        prefixIcon: widget.prefixIcon ?? null,
        hintText:
            widget.prefixIcon != null || widget.small ? widget.hintText : null,
        labelStyle: TextStyle(
            color: !widget.disabled ? neutral_200 : neutral_100,
            fontSize: 16,
            fontFamily: 'Jost',
            height: 1.2,
            fontWeight: FontWeight.w400),
        errorText: widget.propertyInvalid ? widget.errorText : null,
        errorStyle: Theme.of(context)
            .textTheme
            .overline
            .merge(TextStyle(color: semantic_error)),
        contentPadding: widget.prefixIcon == null
            ? const EdgeInsets.fromLTRB(16, 8, 16, 8)
            : widget.small
                ? const EdgeInsets.fromLTRB(16, 15, 16, 8)
                : const EdgeInsets.fromLTRB(16, 16, 16, 8),
        hintStyle: Theme.of(context)
            .textTheme
            .subtitle1
            .merge(TextStyle(fontSize: 16, color: neutral_200, height: 1.2)),
        border: InputBorder.none,
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: widget.coupon == true
              ? BorderSide(
                  color: expanded_light_neutral_100,
                  width: 1.5,
                )
              : BorderSide(
                  color: semantic_error,
                  width: 1.5,
                ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red[900], width: 1.5),
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
