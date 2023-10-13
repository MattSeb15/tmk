import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final Widget? icon;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final TextInputAction? textInputAction;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final String? labelText;
  final TextStyle? labelStyle;
  final double? fontSize;
  final EdgeInsetsGeometry? margin;

  const DefaultTextField({
    Key? key,
    this.hintText,
    this.fontSize,
    this.controller,
    this.icon,
    this.margin,
    this.hintStyle,
    this.style,
    this.textInputAction,
    this.padding,
    this.width,
    this.height,
    this.labelText,
    this.labelStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.only(bottom: 10),
      padding: padding,
      width: width ?? double.infinity,
      height: height ?? 50,
      child: TextField(
        key: key,
        controller: controller,
        style: style ?? TextStyle(fontSize: fontSize ?? 15),
        textInputAction: textInputAction,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: labelStyle ?? TextStyle(fontSize: fontSize ?? 15),
          icon: icon,
          hintText: hintText,
          hintStyle: hintStyle ?? TextStyle(fontSize: fontSize ?? 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),  
          
        ),
      ),
    );
  }
}
