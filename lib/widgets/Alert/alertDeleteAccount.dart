import 'package:app_tnh2/controller/api.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:app_tnh2/screens/stores/authStore.dart';
import 'package:app_tnh2/config/keyStorages.dart';
import 'package:app_tnh2/screens/signIn/signIn.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

alertDeleteAccount(BuildContext context, Service postService) {
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
                    'ท่านต้องการลบบัญชี ?',
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
                            postService.funDeletAcc().then((value) async => {
                                  if (value?.resCode == '00')
                                    {
                                      await accessTokenStore(
                                          key: KeyStorages.accessToken,
                                          action: "remove"),
                                      await accessTokenStore(
                                          key: KeyStorages.signInStatus,
                                          action: "remove"),
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            settings: const RouteSettings(
                                                name: 'TNH_SignIn_Screen'),
                                            builder: (BuildContext context) =>
                                                const SignInScreen(
                                                  statusSignIn: false,
                                                  statusForgot: false,
                                                )),
                                        ModalRoute.withName('/'),
                                      )
                                    }
                                  else
                                    {print('noooo')}
                                })
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorCansel,
                            shadowColor: ColorCansel,
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
                            backgroundColor: ColorDefaultApp1,
                            shadowColor: ColorDefaultApp1,
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
