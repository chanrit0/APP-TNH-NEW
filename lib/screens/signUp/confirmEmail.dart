import 'package:app_tnh2/controller/api.dart';
import 'package:app_tnh2/helper/notification_service.dart';
import 'package:app_tnh2/model/signUp/modelSignupStep2.dart';
import 'package:app_tnh2/provider/providerHome.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:app_tnh2/widgets/Alert/alertLoginFail.dart';
import 'package:app_tnh2/widgets/stateScreenDetails.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_tnh2/screens/home/appointment/widget/alert/alertFailApi.dart';
import 'package:app_tnh2/screens/stores/authStore.dart';
import 'package:app_tnh2/config/keyStorages.dart';
import 'package:app_tnh2/screens/home/home.dart';
import 'package:app_tnh2/widgets/app_loading.dart';
import 'package:app_tnh2/widgets/w_keyboard_dismiss.dart';
import 'package:provider/provider.dart';
import 'package:timer_count_down/timer_count_down.dart';

class ConfirmEmailCreen extends StatefulWidget {
  final String ref_no;
  final String hn;
  final String card_ID; //ตัวแปลเลขบัตร
  final String firstName; //ตัวแปลชื่อ
  final String lastName; //นามสกุล
  final String birthday; //ตัวแปลวันเกิด
  final String numberPhone; //ตัวแปลเบอร์
  final String email; //ตัวแปลอีเมล
  final String password; //ตัวแปลรหัส
  final String confirmPassword; //ตัวแปลยืนยันรกหัส
  final bool agreementAccept; //ตัวแปลผู้ใช้เลืออกยอมรับนโยบาย
  final ModelSignupStep2 data;
  const ConfirmEmailCreen({
    super.key,
    required this.ref_no,
    required this.hn,
    required this.card_ID,
    required this.firstName,
    required this.lastName,
    required this.birthday,
    required this.numberPhone,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.agreementAccept,
    required this.data,
  });

  @override
  State<ConfirmEmailCreen> createState() => _ConfirmEmailCreenState();
}

class _ConfirmEmailCreenState extends State<ConfirmEmailCreen>
    with TickerProviderStateMixin {
  final _formKeyEmail = GlobalKey<FormState>();
//โหลดหน้า

  late AnimationController _controller; //ควบคุมเวลา
  int levelClock = 300; //เวลา 5 นาที

  String refNo = ''; //ref_no เมื่อส่งอีกครั้ง ResendPhone
  bool checkTime = false; // เวลาหมดเปลี่นรค่า
  int timeCount = 300; // เวลา

  String email1 = '';
  String email2 = '';
  String email3 = '';
  String email4 = '';
  String email5 = '';
  String email6 = '';

  late Service postService;

  Future<void> _signIn(String cardID, String passsword) async {
    final tokenNoti = await FireBaseApi.getDeviceToken();
    postService
        .funSignIn(username: cardID, password: passsword, token: tokenNoti)
        .then((value) async => {
              if (value?.accessToken != null)
                {
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
                        key: KeyStorages.signInStatus,
                        action: "set",
                        value: 'true'),
                    await accessTokenStore(
                        key: KeyStorages.cardId, action: "set", value: cardID),
                    await accessTokenStore(
                        key: KeyStorages.onOffNotiStore,
                        action: "set",
                        value: 'on'),
                    await accessTokenStore(
                        key: KeyStorages.verifyStatus,
                        action: "set",
                        value: '${value?.verifyStatus}'),
                    Navigator.pop(context),
                    Future.delayed(const Duration(milliseconds: 1), () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            settings:
                                const RouteSettings(name: 'TNH_Home_Screen'),
                            builder: (BuildContext context) => const HomeScreen(
                                  statusSignUp: true,
                                )),
                        ModalRoute.withName('/'),
                      );
                    })
                  },
                }
              else
                {
                  Navigator.pop(context),
                  AlertLoginFail(context),
                }
            });
  }

  //ดำเนินการต่อ
  void sendOTP(String securityCode) {
    AppLoading.show(context);
    if (Provider.of<ProviderHome>(context, listen: false).dataUpdatePolicy ==
        'notactive') {
      postService
          .funSendVerifyStep3(
            '${refNo != '' ? refNo : widget.data.refNo}',
            securityCode,
          )
          .then((value) async => {
                if (value?.resCode == '00')
                  {
                    _signIn(
                        Provider.of<ProviderHome>(context, listen: false)
                            .dataCardID,
                        Provider.of<ProviderHome>(context, listen: false)
                            .dataPasssword),
                  }
                else
                  {
                    Navigator.pop(context),
                    alertFailApi(context, 'รหัส Security Code ไม่ถูกต้อง'),
                  }
              });
    } else {
      postService
          .funSendEmail(
              '${refNo != '' ? refNo : widget.data.refNo}',
              securityCode,
              widget.email,
              widget.card_ID,
              widget.firstName,
              widget.lastName,
              widget.birthday,
              widget.numberPhone,
              widget.password,
              widget.confirmPassword,
              widget.agreementAccept)
          .then((value) => {
                if (value?.resCode == '00')
                  {
                    _signIn(widget.card_ID, widget.password),
                  }
                else
                  {
                    Navigator.pop(context),
                    alertFailApi(context, 'รหัส Security Code ไม่ถูกต้อง'),
                  }
              });
    }
  }

  //fun ส่งอีกครั้ง
  void resendEmail(String email) {
    AppLoading.show(context);
    if (Provider.of<ProviderHome>(context, listen: false).dataUpdatePolicy ==
        'notactive') {
      postService.funResendVerifyStep3().then((value) => {
            if (value?.resCode == '00')
              {
                Navigator.pop(context),
                setState(() {
                  refNo = '${value?.refNo}';
                }),
                _controller = AnimationController(
                    vsync: this, duration: Duration(seconds: levelClock)),
                _controller.forward()
              }
            else
              {
                Navigator.pop(context),
                alertFailApi(context, 'ส่งรหัส Security Code ไม่สำเร็จ'),
                // print('ส่งอีดครั้งไม่สำเร็จ!!!'),
              }
          });
    } else {
      postService.funResendEmail(email).then((value) => {
            if (value?.resCode == '00')
              {
                Navigator.pop(context),
                setState(() {
                  refNo = '${value?.refNo}';
                }),
                _controller = AnimationController(
                    vsync: this, duration: Duration(seconds: levelClock)),
                _controller.forward()
              }
            else
              {
                Navigator.pop(context),
                alertFailApi(context, 'ส่งรหัส Security Code ไม่สำเร็จ'),
                // print('ส่งอีดครั้งไม่สำเร็จ!!!'),
              }
          });
    }
  }

  @override
  void initState() {
    super.initState();
    postService = Service(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: StateScreenDetails(
        child: WKeyboardDismiss(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    iconSize: 33,
                    icon: const Icon(Icons.chevron_left),
                    color: ColorDefaultApp0,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    'ยืนยัน Security Code',
                    style: TextStyle(fontSize: font20, color: ColorDefaultApp0),
                  ),
                  Container(
                    width: 30,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Flexible(
                flex: 5,
                fit: FlexFit.tight,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              'กรุณากรอกรหัสที่ถูกส่งไปยังอีเมล',
                              style: TextStyle(
                                  color: ColorTextpolicy,
                                  fontFamily: 'RSU_light',
                                  fontSize: font20),
                            ),
                            Text(
                              '${widget.data.hideEmail}',
                              style: TextStyle(
                                  color: ColorDefaultApp1,
                                  fontFamily: 'RSU_BOLD',
                                  fontSize: font30),
                            ),
                            Text(
                              'รหัสอ้างอิง : ${refNo != '' ? refNo : widget.ref_no}',
                              style: TextStyle(
                                  color: ColorTextpolicy,
                                  fontFamily: 'RSU_light',
                                  fontSize: font20),
                            )
                          ],
                        )
                      ],
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Form(
                              key: _formKeyEmail,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 30,
                                    child: TextFormField(
                                      onChanged: (value) => {
                                        if (value.length == 1)
                                          {
                                            FocusScope.of(context).nextFocus(),
                                            setState(() => email1 = value)
                                          }
                                      },
                                      textInputAction: TextInputAction.done,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    height: 20,
                                    width: 30,
                                    child: TextFormField(
                                      onChanged: (value) => {
                                        if (value.length == 1)
                                          {
                                            FocusScope.of(context).nextFocus(),
                                            setState(() => email2 = value)
                                          }
                                        else
                                          {
                                            FocusScope.of(context)
                                                .previousFocus(),
                                            setState(() => email2 = value)
                                          }
                                      },
                                      textInputAction: TextInputAction.done,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    height: 20,
                                    width: 30,
                                    child: TextFormField(
                                      onChanged: (value) => {
                                        if (value.length == 1)
                                          {
                                            FocusScope.of(context).nextFocus(),
                                            setState(() => email3 = value)
                                          }
                                        else
                                          {
                                            FocusScope.of(context)
                                                .previousFocus(),
                                            setState(() => email3 = value)
                                          }
                                      },
                                      textInputAction: TextInputAction.done,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    height: 20,
                                    width: 30,
                                    child: TextFormField(
                                      onChanged: (value) => {
                                        if (value.length == 1)
                                          {
                                            FocusScope.of(context).nextFocus(),
                                            setState(() => email4 = value)
                                          }
                                        else
                                          {
                                            FocusScope.of(context)
                                                .previousFocus(),
                                            setState(() => email4 = value)
                                          }
                                      },
                                      textInputAction: TextInputAction.done,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    height: 20,
                                    width: 30,
                                    child: TextFormField(
                                      onChanged: (value) => {
                                        if (value.length == 1)
                                          {
                                            FocusScope.of(context).nextFocus(),
                                            setState(() => email5 = value)
                                          }
                                        else
                                          {
                                            FocusScope.of(context)
                                                .previousFocus(),
                                            setState(() => email5 = value)
                                          }
                                      },
                                      textInputAction: TextInputAction.done,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    height: 20,
                                    width: 30,
                                    child: TextFormField(
                                      onChanged: (value) => {
                                        if (value.length == 1)
                                          {
                                            FocusScope.of(context).nextFocus(),
                                            setState(() => email6 = value)
                                          }
                                        else
                                          {
                                            FocusScope.of(context)
                                                .previousFocus(),
                                            setState(() => email6 = value)
                                          }
                                      },
                                      textInputAction: TextInputAction.done,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: [
                              Countdown(
                                seconds: timeCount,
                                build: (BuildContext context, double time) {
                                  int minutes = (time / 60)
                                      .floor(); // แปลงจำนวนวินาทีเป็นนาที
                                  int seconds = (time % 60)
                                      .floor(); // หาเศษวินาทีที่เหลือ
                                  return Text(
                                    '$minutes:$seconds', // แสดงเป็นรูปแบบนาที:วินาที
                                    style: TextStyle(
                                        color: ColorDefaultApp1,
                                        fontSize: font24),
                                  );
                                },
                                interval: Duration(milliseconds: 1000),
                                onFinished: () {
                                  setState(() {
                                    checkTime = true;
                                  });
                                },
                              ),
                              InkWell(
                                onTap: () {
                                  resendEmail(widget.email);
                                },
                                child: Text(
                                  'ส่งคำขอ Security Code อีกครั้ง',
                                  style: TextStyle(
                                    fontSize: font18,
                                    color: Colors.grey,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ]),
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  sendOTP(email1 +
                                      email2 +
                                      email3 +
                                      email4 +
                                      email5 +
                                      email6);
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
                                  'ดำเนินการต่อ',
                                  style: TextStyle(
                                      fontSize: font18, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
