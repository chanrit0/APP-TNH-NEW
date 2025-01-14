import 'dart:io';

import 'package:app_tnh2/config/constants.dart';
import 'package:app_tnh2/controller/api.dart';
import 'package:app_tnh2/helper/notification_service.dart';
import 'package:app_tnh2/provider/providerHome.dart';
import 'package:app_tnh2/screens/home/home.dart';
import 'package:app_tnh2/screens/signUp/policy.dart';
import 'package:app_tnh2/screens/stores/authStore.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:app_tnh2/widgets/Alert/AlertResetPasswordScuccess.dart';
import 'package:app_tnh2/widgets/Alert/AlertSignUpSuccess.dart';
import 'package:app_tnh2/widgets/Alert/alertLoginFail.dart';
import 'package:app_tnh2/widgets/Alert/alertUpdateVersion.dart';
import 'package:app_tnh2/widgets/stateScreen.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:app_tnh2/config/keyStorages.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:app_tnh2/widgets/app_loading.dart';
import 'package:app_tnh2/widgets/w_keyboard_dismiss.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  final bool statusSignIn;
  final bool statusForgot;
  const SignInScreen(
      {super.key, required this.statusSignIn, required this.statusForgot});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  String cardID = ''; //เลขบัตรประจำตัวประชาชน
  String password = ''; //รหัส
  bool isPasswordVisible = true; //เปิดปิดลูกตา
  late Service postService;
  ScrollController scrollController = ScrollController();

  void _signIn(String cardID, String passsword) async {
    final tokenNoti = await FireBaseApi.getDeviceToken();
    AppLoading.show(context);
    postService
        .funSignIn(username: cardID, password: passsword, token: tokenNoti)
        .then((value) async => {
              if (value?.accessToken != null)
                {
                  if (value?.verifyStatus == 'notactive')
                    {
                      Provider.of<ProviderHome>(context, listen: false)
                          .setUpdatePolicy = value?.verifyStatus,
                      Provider.of<ProviderHome>(context, listen: false)
                          .setCardID = cardID,
                      Provider.of<ProviderHome>(context, listen: false)
                          .setPasssword = passsword,
                      await accessTokenStore(
                          key: KeyStorages.accessToken,
                          action: "set",
                          value: '${value?.tokenType} ${value?.accessToken}'),
                      await accessTokenStore(
                          key: KeyStorages.refreshToken,
                          action: "set",
                          value: '${value?.refreshToken}'),
                      await accessTokenStore(
                          key: KeyStorages.cardId,
                          action: "set",
                          value: cardID),
                      await accessTokenStore(
                          key: KeyStorages.onOffNotiStore,
                          action: "set",
                          value: 'on'),
                      await accessTokenStore(
                          key: KeyStorages.verifyStatus,
                          action: "set",
                          value: '${value?.verifyStatus}'),
                      await accessTokenStore(
                          key: KeyStorages.signInStatus,
                          action: "set",
                          value: 'true'),
                      AppLoading.hide(context),
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            settings:
                                const RouteSettings(name: 'TNH_Policy_Screen'),
                            builder: (context) =>
                                const PolicyScreen('save', '2')),
                      ),
                    }
                  else
                    {
                      await FirebaseAnalytics.instance
                          .logLogin(loginMethod: 'login'),
                      await accessTokenStore(
                          key: KeyStorages.accessToken,
                          action: "set",
                          value: '${value?.tokenType} ${value?.accessToken}'),
                      await accessTokenStore(
                          key: KeyStorages.refreshToken,
                          action: "set",
                          value: '${value?.refreshToken}'),
                      await accessTokenStore(
                          key: KeyStorages.cardId,
                          action: "set",
                          value: cardID),
                      await accessTokenStore(
                          key: KeyStorages.onOffNotiStore,
                          action: "set",
                          value: 'on'),
                      await accessTokenStore(
                          key: KeyStorages.verifyStatus,
                          action: "set",
                          value: '${value?.verifyStatus}'),
                      await accessTokenStore(
                          key: KeyStorages.signInStatus,
                          action: "set",
                          value: 'true'),
                      AppLoading.hide(context),
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            settings:
                                const RouteSettings(name: 'TNH_Home_Screen'),
                            builder: (context) => const HomeScreen(
                                  statusSignUp: false,
                                )),
                      ),
                    },
                }
              else
                {
                  AppLoading.hide(context),
                  AlertLoginFail(context),
                }
            });
  }

  void refresh() {
    checkUpdate();
  }

  void forgotPass(String cardId) async {
    postService.funForgotPass(cardId).then((value) => {
          if (value?.resCode == '00')
            {
              Navigator.pop(context),
              Future.delayed(const Duration(seconds: 0), () {
                AlertResetPasswordScuccess(context, '${value?.resCode}');
              })
            }
          else if (value?.resCode == '01')
            {
              Navigator.pop(context),
              Future.delayed(const Duration(seconds: 0), () {
                AlertResetPasswordScuccess(context, '${value?.resCode}');
              })
            }
          else if (value?.resCode == '02')
            {
              Navigator.pop(context),
              Future.delayed(const Duration(seconds: 0), () {
                AlertResetPasswordScuccess(context, '${value?.resCode}');
              })
            }
          else
            {print('เปลี่ยนรหัสผ่านไม่สำเร็จ!')}
        });
  }

  void checkUpdate() async {
    await Future.delayed(Duration(seconds: 1));
    final tokenNoti = await FireBaseApi.getDeviceToken();
    print('tokenNoti $tokenNoti');
    postService
        .funForceUpdate(ApiConstants.version, ApiConstants.devicePlatform,
            ApiConstants.deviceUpDateversion)
        .then((value) {
      if (value?.resCode == '00') {
        AlertUpdateVersion(
            context,
            refresh,
            Platform.isAndroid
                ? 'android '
                : Platform.isIOS
                    ? 'ios'
                    : 'huawei',
            '${value?.resResult?.verBundle}');
      } else {
        print('ไม่มีอัพเดท');
      }
    });
  }

  @override
  initState() {
    super.initState();
    postService = Service(context: context);
    FireBaseApi.initNotification(context);
    Future.delayed(const Duration(seconds: 0), () async {
      if (widget.statusSignIn) {
        AlertSignUpSuccess(context);
      }
    });
    checkUpdate();
  }

  @override
  Widget build(BuildContext context) {
    final fullScreenWidth = MediaQuery.of(context).size.width;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: StateScreen(
        child: WKeyboardDismiss(
          child: ListView(
            controller: scrollController,
            children: [
              Column(children: [
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Image(
                    image: const AssetImage('assets/images/logo_singin@3x.png'),
                    height: MediaQuery.of(context).size.height * 25 / 100,
                    width: 200,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    SizedBox(
                        width: double.infinity,
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    'เลขบัตรประจำตัวประชาชน / Passport ID',
                                    style: TextStyle(
                                        color: ColorDefaultApp1,
                                        fontSize: font20),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                SizedBox(
                                  child: TextFormField(
                                    scrollPadding: const EdgeInsets.all(150),
                                    initialValue: cardID,
                                    onChanged: (value) =>
                                        setState(() => cardID = value),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'กรุณากรอกข้อมูล / Passport ID';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      // isDense: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 0, vertical: 9),
                                      hintText:
                                          'กรุณากรอกเลขบัตรประจำตัวประชาชน / Passport ID',
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: font18),
                                    ),
                                    style: TextStyle(
                                        color: ColorDefaultApp0,
                                        fontSize: font20),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    'รหัสผ่าน / Password',
                                    style: TextStyle(
                                        color: ColorDefaultApp1,
                                        fontSize: font20),
                                  ),
                                ),
                                TextFormField(
                                  scrollPadding: const EdgeInsets.all(140),
                                  autocorrect: false,
                                  initialValue: password,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรุณากรอกข้อมูล / Password';
                                    }
                                    return null;
                                  },
                                  onEditingComplete: () {
                                    if (_formKey.currentState!.validate()) {
                                      _signIn(cardID, password);
                                    }
                                  },
                                  onChanged: (value) =>
                                      setState(() => password = value),
                                  decoration: InputDecoration(
                                    // isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 9),
                                    hintText: 'กรุณากรอกรหัสผ่าน / Password',
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: font18),
                                    suffixIcon: IconButton(
                                      icon: isPasswordVisible
                                          ? const Icon(Icons.visibility_off)
                                          : const Icon(Icons.visibility),
                                      onPressed: () => setState(() =>
                                          isPasswordVisible =
                                              !isPasswordVisible),
                                    ),
                                    border: const UnderlineInputBorder(),
                                  ),
                                  obscureText: isPasswordVisible,
                                  style: TextStyle(
                                      color: ColorDefaultApp0,
                                      fontSize: font20),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          AlertSelectResetPassword(context);
                                        },
                                        child: Text(
                                          'ลืมรหัสผ่าน ?',
                                          style: TextStyle(
                                            fontSize: font18,
                                            color: Colors.grey,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          _signIn(cardID, password);
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: ColorDefaultApp1,
                                        shadowColor: ColorDefaultApp1,
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        minimumSize:
                                            const Size(double.infinity, 44),
                                      ),
                                      child: Text(
                                        'เข้าสู่ระบบ',
                                        style: TextStyle(
                                            fontSize: font18,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: fullScreenWidth > 600 ? 100 : 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ยังไม่ได้เป็นสมาชิก ?',
                            style: TextStyle(
                                fontSize: font14,
                                color: const Color(0xff5b5a5d)),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 92, right: 92),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  settings: const RouteSettings(
                                      name: 'TNH_Policy_Screen'),
                                  builder: (context) =>
                                      const PolicyScreen('save', '2')),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff51c0ae),
                            shadowColor: Colors.greenAccent,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            minimumSize: const Size(double.infinity, 44),
                          ),
                          child: Text(
                            'สมัครสมาชิก',
                            style: TextStyle(
                                fontSize: font18, color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  AlertSelectResetPassword(
    BuildContext context,
  ) async {
    AlertDialog alert = AlertDialog(
      content: SizedBox(
          height: 250,
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
                      fontSize: font24),
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
                            color: ColorDefaultApp1, fontSize: font20),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    TextFormField(
                      initialValue: cardID,
                      onChanged: (value) => setState(() => cardID = value),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกข้อมูล';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 0),
                        hintText:
                            'กรุณากรอกเลขบัตรประจำตัวประชาชน / Passport ID',
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: font18),
                      ),
                      style:
                          TextStyle(color: ColorDefaultApp0, fontSize: font20),
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
                    ElevatedButton(
                      onPressed: () {
                        forgotPass(cardID);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorDefaultApp1,
                        shadowColor: Colors.greenAccent,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        minimumSize: const Size(double.infinity, 44),
                      ),
                      child: Text(
                        'ดำเนินการต่อ',
                        style: TextStyle(fontSize: font18, color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
