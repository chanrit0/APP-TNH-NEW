import 'package:app_tnh2/screens/home/appointment/appointment.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:flutter/material.dart';

AlertAppointmentSuccess(BuildContext context) {
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
                const Image(
                  image: AssetImage('assets/images/postponed@3x.png'),
                  height: 120,
                  width: 120,
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'อยู่ระหว่างดำเนินการ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorBtRegister,
                      fontFamily: 'RSU_BOLD',
                      fontSize: font30),
                ),
                Text(
                  'กรุณารอเจ้าหน้าที่ติดต่อกลับ\nเพื่อยืนยันการนัดหมาย',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorDefaultApp0,
                      fontFamily: 'RSU_BOLD',
                      fontSize: font18),
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
  ).then((value) => {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              settings: const RouteSettings(name: 'TNH_Appointment_Screen'),
              builder: (BuildContext context) =>
                  const AppointmentScreen(statusAppoinment: true)),
          ModalRoute.withName('/'),
        )
        //   Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //           settings: const RouteSettings(name: 'TNH_Appointment_Screen'),
        //           builder: (context) => const AppointmentScreen(
        //                 statusAppoinment: true,
        //               )))
      });
}
