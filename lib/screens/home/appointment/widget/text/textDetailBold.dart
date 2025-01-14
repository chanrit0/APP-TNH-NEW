import 'package:app_tnh2/styles/colors.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:flutter/material.dart';

class textDetailBold extends StatelessWidget {
  final String textData;
  const textDetailBold(this.textData, {super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Text(
        textData,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: ColorDefaultApp1,
          fontSize: font18,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    );
  }
}
