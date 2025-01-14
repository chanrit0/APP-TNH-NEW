import 'package:app_tnh2/screens/home/appointment/widget/alert/alertCancelAppointSuccress.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:app_tnh2/config/keyStorages.dart';
import 'package:app_tnh2/screens/stores/authStore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

alertCancelAppointment(
    BuildContext context, bool statustAppoint, postService, apmbId) {
  final fullScreenWidth = MediaQuery.of(context).size.width;
  AlertDialog alert = AlertDialog(
    content: MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: SizedBox(
            width: 250,
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  statustAppoint
                      ? 'ท่านต้องการเลื่อนนัด ?'
                      : fullScreenWidth < 330
                          ? 'ท่านต้องการ\nยกเลิกนัด ?'
                          : 'ท่านต้องการยกเลิกนัด ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorDefaultApp0,
                      fontFamily: 'RSU_BOLD',
                      fontSize: font24),
                ),
                ElevatedButton(
                  onPressed: () async => {
                    await postService
                        .funCancleAppoint(apmbId)
                        .then((value) async => {
                              if (value == '00')
                                {
                                  AlertCancelAppointSuccress(
                                      context, statustAppoint),
                                  if (statustAppoint)
                                    {
                                      await accessTokenStore(
                                          key: KeyStorages.tabAppointment,
                                          action: "set",
                                          value: "1".toString()),
                                    }
                                  else
                                    {
                                      await accessTokenStore(
                                          key: KeyStorages.tabAppointment,
                                          action: "set",
                                          value: "3".toString())
                                    }
                                },
                            })
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorDefaultApp1,
                    shadowColor: ColorDefaultApp1,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    minimumSize: const Size(double.infinity, 44),
                  ),
                  child: Text(
                    'ตกลง',
                    style: TextStyle(fontSize: font20, color: Colors.white),
                  ),
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
