import 'package:app_tnh2/controller/signin/singInContorller.dart';
import 'package:app_tnh2/helper/notification_service.dart';
import 'package:app_tnh2/screens/signUp/policy.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:app_tnh2/widgets/Alert/alertSignUpSuccess.dart';
import 'package:app_tnh2/widgets/input.dart';
import 'package:app_tnh2/widgets/stateScreen.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:flutter/material.dart';
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
  @override
  initState() {
    super.initState();
    FireBaseApi.initNotification(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SingInController>().checkUpdate(context);
      if (widget.statusSignIn) {
        alertSignUpSuccess(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final fullScreenWidth = MediaQuery.of(context).size.width;
    return Consumer<SingInController>(builder: (context, singInCon, child) {
      return MediaQuery(
        data:
            MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
        child: StateScreen(
          child: WKeyboardDismiss(
            child: ListView(
              controller: singInCon.scrollController,
              children: [
                Column(children: [
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: Image(
                      image:
                          const AssetImage('assets/images/logo_singin@3x.png'),
                      height: MediaQuery.of(context).size.height * 25 / 100,
                      width: 200,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      SizedBox(
                          width: double.infinity,
                          child: Form(
                            key: singInCon.formKeyA,
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
                                  Input(
                                    initialValue: singInCon.cardID,
                                    onChanged: (value) =>
                                        singInCon.cardID = value,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'กรุณากรอกข้อมูล / Passport ID';
                                      }
                                      return null;
                                    },
                                    hintText:
                                        'กรุณากรอกเลขบัตรประจำตัวประชาชน / Passport ID',
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
                                  Input(
                                    inputPass: true,
                                    initialValue: singInCon.password,
                                    onChanged: (value) =>
                                        singInCon.password = value,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'กรุณากรอกข้อมูล / Password';
                                      }
                                      return null;
                                    },
                                    hintText: 'กรุณากรอกรหัสผ่าน / Password',
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            singInCon.cardID = '';
                                            singInCon.alertSelectResetPassword(
                                                context);
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
                                          if (singInCon.formKeyA.currentState!
                                              .validate()) {
                                            singInCon.funSignIn(context);
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
                        const SizedBox(height: 10),
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
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ),
      );
    });
  }
}
