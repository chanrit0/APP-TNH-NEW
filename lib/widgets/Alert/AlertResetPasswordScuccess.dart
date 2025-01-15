import 'package:app_tnh2/styles/colors.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:flutter/material.dart';

alertResetPasswordScuccess(BuildContext context, String code) {
  AlertDialog alert = AlertDialog(
    content: MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
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
                Image(
                  image: code == '00'
                      ? const AssetImage(
                          'assets/images/resetPassSuccess@3x.png')
                      : const AssetImage(
                          'assets/images/resetPasswordNot@3x.png'),
                  height: 120,
                  width: 120,
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  code == '00'
                      ? 'การรีเซ็ตรหัสผ่านถูกส่งไปที่อีเมลองท่านเรียบร้อยแล้ว'
                      : code == '02'
                          ? 'ท่านเคยรีเซ็ตรหัสผ่านไปแล้ว ท่านสามารถรีเซ็ตรหัสผ่านได้เพียง\nวันละ 1 ครั้งเท่านั้น'
                          : code == '03'
                              ? 'เปลี่ยนรหัสผ่านไม่สำเร็จ!'
                              : 'ไม่พบหมายเลขบัตรประชาชน',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: code == '00' ? ColorBtRegister : ColorOreng,
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
  );
}
