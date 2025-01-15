import 'package:app_tnh2/controller/api.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:app_tnh2/widgets/Alert/alertResetPasswordScuccess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

alertResetPassword(BuildContext context, Service postService, String cardId) {
  AlertDialog alert = AlertDialog(
    content: MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: SizedBox(
            width: 250.w,
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Text(
                    'ท่านต้องการเปลี่ยนรหัสผ่าน ?',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        color: ColorDefaultApp0,
                        fontFamily: 'RSU_BOLD',
                        fontSize: font24),
                  ),
                ),
                Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () async => {
                            postService.funForgotPass(cardId).then((value) => {
                                  if (value?.resCode == '00')
                                    {
                                      Navigator.pop(context),
                                      alertResetPasswordScuccess(
                                          context, '${value?.resCode}')
                                    }
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
                            style: TextStyle(
                                fontSize: font20, color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async => {Navigator.pop(context)},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorBtRegister,
                            shadowColor: ColorBtRegister,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            minimumSize: const Size(double.infinity, 44),
                          ),
                          child: Text(
                            'ยกเลิก',
                            style: TextStyle(
                                fontSize: font20, color: Colors.white),
                          ),
                        ),
                      ],
                    ))
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
