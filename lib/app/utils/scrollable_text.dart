import 'package:flutter/cupertino.dart';

Widget ScrollableText(String text) {
  return SingleChildScrollView(
      scrollDirection: Axis.horizontal, child: Text(text));
}
