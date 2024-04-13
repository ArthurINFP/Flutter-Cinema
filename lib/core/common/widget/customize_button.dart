// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomizeButton extends StatelessWidget {
  Function()? onPressed;
  TextStyle? textStyle;
  String? text;
  Color? backgroundColor;
  double? borderRadius;
  double? height;
  double? widget;
  CustomizeButton({
    Key? key,
    this.onPressed,
    this.textStyle,
    this.text,
    this.backgroundColor,
    this.borderRadius,
    this.height,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: SizedBox(
        height: height,
        width: widget,
        child: ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                    backgroundColor ?? theme.colorScheme.primary),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius ?? 8)))),
            child: Text(
              text ?? 'Nhap title',
              style: textStyle ??
                  const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
            )),
      ),
    );
  }
}
