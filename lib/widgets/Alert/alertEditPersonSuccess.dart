import 'package:app_tnh2/styles/colors.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:flutter/material.dart';

AlertEditPersonSuccess(BuildContext context) {
  final fullScreenWidth = MediaQuery.of(context).size.width;
  AlertDialog alert = AlertDialog(
    content: MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: SizedBox(
          width: 250,
          height: fullScreenWidth < 330 ? 310 : 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage(
                    'assets/images/alertAppointmentScuccress@3x.png'),
                height: 120,
                width: 120,
              ),
              SizedBox(
                height: fullScreenWidth < 330 ? 20 : 40,
              ),
              Text(
                'ส่งข้อมูลการแก้ไขสำเร็จ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: ColorBtRegister,
                    fontFamily: 'RSU_BOLD',
                    fontSize: font30),
              ),
              Text(
                'โรงพยาบาลได้รับข้อมูลของท่านเรียบร้อยอยู่ระหว่างดำเนินการ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: ColorDefaultApp0,
                    fontFamily: 'RSU_BOLD',
                    fontSize: font18),
              ),
            ],
          )),
    ),
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  ).then((value) => {Navigator.pop(context)});
}
