import 'package:flutter/material.dart';

class ProfileWidgites {
  Widget text(String text, double fontsize, FontWeight fontweight) {
    return Text(
      text,
      textDirection: TextDirection.rtl,
      style: TextStyle(fontWeight: fontweight, fontSize: fontsize),
    );
  }

  Widget row(List<Widget> widgets) {
    return Container(
      padding: EdgeInsets.only(right: 30),
      decoration: BoxDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: widgets,
      ),
    );
  }
}
