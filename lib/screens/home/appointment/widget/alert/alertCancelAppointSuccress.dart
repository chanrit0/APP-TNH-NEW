import 'package:app_tnh2/screens/home/appointment/appointment.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:flutter/material.dart';

AlertCancelAppointSuccress(BuildContext context, bool statustAppoint) {
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
                Image(
                  image: AssetImage(statustAppoint
                      ? 'assets/icons/postpone-Appoint@3x.png'
                      : 'assets/icons/cansel-Appoint@3x.png'),
                  height: 120,
                  width: 120,
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  statustAppoint ? 'เลื่อนนัดสำเร็จ !' : 'ยกเลิกนัดสำเร็จ !',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: statustAppoint ? ColorBtRegister : ColorCansel,
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
  ).then((value) => {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              settings: const RouteSettings(name: 'TNH_Appointment_Screen'),
              builder: (BuildContext context) =>
                  const AppointmentScreen(statusAppoinment: true)),
          ModalRoute.withName('/'),
        )
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         settings: const RouteSettings(name: 'TNH_Appointment_Screen'),
        //         builder: (context) => const AppointmentScreen(
        //               statusAppoinment: true,
        //             )))
      });
}
