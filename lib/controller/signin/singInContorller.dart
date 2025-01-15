import 'dart:convert';

import 'package:app_tnh2/config/constants.dart';
import 'package:app_tnh2/config/keyStorages.dart';
import 'package:app_tnh2/controller/http.dart';
import 'package:app_tnh2/helper/notification_service.dart';
import 'package:app_tnh2/provider/providerHome.dart';
import 'package:app_tnh2/screens/home/home.dart';
import 'package:app_tnh2/screens/signUp/policy.dart';
import 'package:app_tnh2/screens/stores/authStore.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:app_tnh2/widgets/Alert/alertResetPasswordScuccess.dart';
import 'package:app_tnh2/widgets/Alert/alertUpdateVersion.dart';
import 'package:app_tnh2/widgets/Alert/alertLoginFail.dart';
import 'package:app_tnh2/widgets/app_loading.dart';
import 'package:app_tnh2/widgets/button.dart';
import 'package:app_tnh2/widgets/input.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class API {
  static final request =
      HttpRequest(ApiConstants.HOST_URL + ApiConstants.API_VERSION);
}

class SingInController with ChangeNotifier {
  final formKeyA = GlobalKey<FormState>();

  String cardID = ''; //เลขบัตรประจำตัวประชาชน
  String password = ''; //รหัส
  bool isPasswordVisible = true; //เปิดปิดลูกตา
  String tokenNoti = '';

  ScrollController scrollController = ScrollController();

  void getTokenNoti() async {
    final token = await FireBaseApi.getDeviceToken();
    if (token != null) {
      tokenNoti = token;
    }
  }

  void funSignIn(BuildContext context) async {
    AppLoading.show(context);
    try {
      final body = {
        'username': cardID,
        'password': password,
        'token_noti': tokenNoti
      };
      final res = await API.request.postDio('/login', body);
      final dataDecode = json.decode(res);
      if (dataDecode['access_token'] != null) {
        if (dataDecode['verify_status'] == 'notactive') {
          Provider.of<ProviderHome>(context, listen: false).setUpdatePolicy =
              dataDecode['verify_status'];
          Provider.of<ProviderHome>(context, listen: false).setCardID = cardID;
          Provider.of<ProviderHome>(context, listen: false).setPasssword =
              password;
          await accessTokenStore(
              key: KeyStorages.accessToken,
              action: "set",
              value:
                  '${dataDecode['token_type']} ${dataDecode['access_token']}');
          await accessTokenStore(
              key: KeyStorages.refreshToken,
              action: "set",
              value: '${dataDecode['refresh_token']}');
          await accessTokenStore(
              key: KeyStorages.cardId, action: "set", value: cardID);
          await accessTokenStore(
              key: KeyStorages.onOffNotiStore, action: "set", value: 'on');
          await accessTokenStore(
              key: KeyStorages.verifyStatus,
              action: "set",
              value: '${dataDecode['verify_status']}');
          await accessTokenStore(
              key: KeyStorages.signInStatus, action: "set", value: 'true');

          AppLoading.hide(context);
          Navigator.push(
            context,
            MaterialPageRoute(
                settings: const RouteSettings(name: 'TNH_Policy_Screen'),
                builder: (context) => const PolicyScreen('save', '2')),
          );
        } else {
          await FirebaseAnalytics.instance.logLogin(loginMethod: 'login');
          await accessTokenStore(
              key: KeyStorages.accessToken,
              action: "set",
              value:
                  '${dataDecode['token_type']} ${dataDecode['access_token']}');
          await accessTokenStore(
              key: KeyStorages.refreshToken,
              action: "set",
              value: '${dataDecode['refresh_token']}');
          await accessTokenStore(
              key: KeyStorages.cardId, action: "set", value: cardID);
          await accessTokenStore(
              key: KeyStorages.onOffNotiStore, action: "set", value: 'on');
          await accessTokenStore(
              key: KeyStorages.verifyStatus,
              action: "set",
              value: '${dataDecode['verify_status']}');
          await accessTokenStore(
              key: KeyStorages.signInStatus, action: "set", value: 'true');

          AppLoading.hide(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                settings: const RouteSettings(name: 'TNH_Home_Screen'),
                builder: (context) => const HomeScreen(
                      statusSignUp: false,
                    )),
          );
        }
      } else {
        AppLoading.hide(context);
        alertLoginFail(context);
      }
    } catch (e) {
      debugPrint('catch /login: $e');
    }
  }

  void checkUpdate(BuildContext context) async {
    try {
      final body = {
        'version': ApiConstants.version,
        'device_platform': ApiConstants.devicePlatform,
        'device_up_dateversion': ApiConstants.deviceUpDateversion,
      };
      final res = await API.request.postDio('/appversion', body);
      final dataDecode = json.decode(res);
      print('dataDecode $dataDecode');
      if (dataDecode['resCode'] == '00') {
        alertUpdateVersion(
          context,
          checkUpdate,
          ApiConstants.devicePlatform == '1'
              ? 'android '
              : ApiConstants.devicePlatform == '2'
                  ? 'ios'
                  : 'huawei',
          '${dataDecode['resResult']['verBundle']}',
        );
      } else {
        debugPrint('ไม่มีอัพเดท');
      }
    } catch (e) {
      debugPrint('catch /appversion: $e');
    }
  }

  void forgotPass(BuildContext context) async {
    try {
      final body = {
        'card': cardID,
      };
      final res = await API.request.postDio('/forgot/password', body);
      final dataDecode = json.decode(res);
      if (dataDecode['resCode'] == '00') {
        Navigator.pop(context);
        Future.delayed(const Duration(seconds: 0), () {
          alertResetPasswordScuccess(context, '${dataDecode['resCode']}');
        });
      } else if (dataDecode['resCode'] == '01') {
        Navigator.pop(context);
        Future.delayed(const Duration(seconds: 0), () {
          alertResetPasswordScuccess(context, '${dataDecode['resCode']}');
        });
      } else if (dataDecode['resCode'] == '02') {
        Navigator.pop(context);
        Future.delayed(const Duration(seconds: 0), () {
          alertResetPasswordScuccess(context, '${dataDecode['resCode']}');
        });
      } else {
        Navigator.pop(context);
        Future.delayed(const Duration(seconds: 0), () {
          alertResetPasswordScuccess(context, '03');
        });
      }
    } catch (e) {
      debugPrint('catch /forgot/password: $e');
      Navigator.pop(context);
      Future.delayed(const Duration(seconds: 0), () {
        alertResetPasswordScuccess(context, '03');
      });
    }
  }

  alertSelectResetPassword(BuildContext context) {
    final formKeyB = GlobalKey<FormState>();

    final alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SizedBox(
            height: 250,
            child: Form(
              key: formKeyB,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Text(
                      textAlign: TextAlign.center,
                      'กรอกเลขบัตรประจำตัวประชาชน หรือ Passport ID ของท่าน',
                      style: TextStyle(
                        color: ColorDefaultApp0,
                        fontFamily: 'RSU_BOLD',
                        fontSize: font24,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 25,
                          child: Text(
                            'เลขบัตรประจำตัวประชาชน / Passport ID',
                            style: TextStyle(
                                color: ColorDefaultApp1, fontSize: 20),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Input(
                          initialValue: cardID,
                          onChanged: (value) {
                            cardID = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกข้อมูล';
                            }
                            return null;
                          },
                          hintText:
                              'กรุณากรอกเลขบัตรประจำตัวประชาชน / Passport ID',
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Button(
                          text: 'ดำเนินการต่อ',
                          onPressed: () {
                            if (formKeyB.currentState!.validate()) {
                              forgotPass(context);
                            }
                          },
                          color: ColorDefaultApp1,
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
