import 'package:app_tnh2/styles/colors.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:flutter/material.dart';

alertSignUpSuccess(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: SizedBox(
            width: 250,
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage('assets/images/AlertSingup@3x.png'),
                  height: 120,
                  width: 120,
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'สมัครสมาชิกสำเร็จ !',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorBtRegister,
                      fontFamily: 'RSU_BOLD',
                      fontSize: font30),
                ),
              ],
            )),
      ),
    ),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
