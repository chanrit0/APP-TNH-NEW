import 'package:app_tnh2/styles/colors.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:flutter/material.dart';

alertLoginFail(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: SizedBox(
            width: 250,
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.lock_outline,
                  color: ColorCansel,
                  size: 70,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'เลขบัตรประจำตัวประชาชนหรือรหัสผ่านผิดพลาด !',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorCansel,
                      fontFamily: 'RSU_BOLD',
                      fontSize: font30),
                ),
              ],
            )),
      ),
    ),
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  ).then((value) => {});
}
