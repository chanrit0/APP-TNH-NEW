import 'package:app_tnh2/styles/colors.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:flutter/material.dart';

class textDetail extends StatelessWidget {
  final String text;
  const textDetail(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Text(
        '${text}',
        textAlign: TextAlign.left,
        style: TextStyle(
            color: ColorDefaultApp0, fontFamily: 'RSU_light', fontSize: font16),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    );
  }
}
