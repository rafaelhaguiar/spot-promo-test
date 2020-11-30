import 'package:flutter/material.dart';
import 'package:spot_promo_test/utils/custom_fonts.dart';

class CustomLabel extends StatelessWidget {

  final String text;
  final Color color;
  final bool isTitle;
  final double fontSize;

  const CustomLabel({Key key, this.text, this.color = Colors.white, this.isTitle = false, this.fontSize = 26}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontFamily: isTitle ? CustomFonts.fontTitle : CustomFonts.fontRegular,
        fontSize: fontSize,
      ),
    );
  }
}