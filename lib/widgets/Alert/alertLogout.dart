import 'package:app_tnh2/controller/api.dart';
import 'package:app_tnh2/provider/providerHome.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:app_tnh2/screens/stores/authStore.dart';
import 'package:app_tnh2/config/keyStorages.dart';
import 'package:app_tnh2/screens/signIn/signIn.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

alertLogout(BuildContext context, Service postService) {
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
                    'ท่านต้องการออกจากระบบ ?',
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
                          postService.funLogOut().then((value) async => {
                                if (value?.resCode == '00')
                                  {
                                    Provider.of<ProviderHome>(context,
                                            listen: false)
                                        .setUpdatePolicy = 'active',
                                    await accessTokenStore(
                                        key: KeyStorages.accessToken,
                                        action: "remove"),
                                    await accessTokenStore(
                                        key: KeyStorages.refreshToken,
                                        action: "remove"),
                                    await accessTokenStore(
                                        key: KeyStorages.signInStatus,
                                        action: "remove"),
                                    await accessTokenStore(
                                        key: KeyStorages.cardId,
                                        action: "remove"),
                                    await accessTokenStore(
                                        key: KeyStorages.onOffNotiStore,
                                        action: "remove"),
                                    await accessTokenStore(
                                        key: KeyStorages.verifyStatus,
                                        action: "remove"),
                                    Navigator.pushAndRemoveUntil<void>(
                                      context,
                                      MaterialPageRoute<void>(
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
                                  {print('ไม่ออกจากระบบไม่สำเร็จ')}
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
                          style:
                              TextStyle(fontSize: font20, color: Colors.white),
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
                          style:
                              TextStyle(fontSize: font20, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )
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
