import 'package:app_tnh2/controller/api.dart';
import 'package:app_tnh2/model/signUp/modelSignupStep1.dart';
import 'package:app_tnh2/provider/providerHome.dart';
import 'package:app_tnh2/screens/signUp/confirmEmail.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:app_tnh2/widgets/stateScreenDetails.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_tnh2/screens/home/appointment/widget/alert/alertFailApi.dart';
import 'package:app_tnh2/widgets/app_loading.dart';
import 'package:app_tnh2/widgets/w_keyboard_dismiss.dart';
import 'package:provider/provider.dart';
import 'package:timer_count_down/timer_count_down.dart';

class ConfirmOtpScreen extends StatefulWidget {
  final String card_ID; //ตัวแปลเลขบัตร
  final String firstName; //ตัวแปลชื่อ
  final String lastName; //นามสกุล
  final String birthday; //ตัวแปลวันเกิด
  final String numberPhone; //ตัวแปลเบอร์
  final String email; //ตัวแปลอีเมล
  final String password; //ตัวแปลรหัส
  final String confirmPassword; //ตัวแปลยืนยันรกหัส
  final bool agreementAccept; //ตัวแปลผู้ใช้เลืออกยอมรับนโยบาย
  final ModelSignupStep1 data;
  const ConfirmOtpScreen(
      {super.key,
      required this.card_ID,
      required this.firstName,
      required this.lastName,
      required this.birthday,
      required this.numberPhone,
      required this.email,
      required this.password,
      required this.confirmPassword,
      required this.agreementAccept,
      required this.data});

  @override
  State<ConfirmOtpScreen> createState() => _ConfirmOtpScreenState();
}

class _ConfirmOtpScreenState extends State<ConfirmOtpScreen> {
  final _formKeyOTP = GlobalKey<FormState>();

  bool checkTimeOut = false; //เวลาหมดกดได้และกดไม่ได้
  bool checkTime = false; // เวลาหมดเปลี่นรค่า
  int timeCount = 300; // เวลา
  String refNo = ''; //ref_no เมื่อส่งอีกครั้ง ResendPhone

  String otp1 = '';
  String otp2 = '';
  String otp3 = '';
  String otp4 = '';
  String otp5 = '';
  String otp6 = '';

  late Service postService;
  //ดำเนินการต่อ
  void sendOTP(String otp) {
    AppLoading.show(context);
    if (Provider.of<ProviderHome>(context, listen: false).dataUpdatePolicy ==
        'notactive') {
      postService
          .funSendVerifyStep2('${refNo != '' ? refNo : widget.data.refNo}', otp)
          .then((value) => {
                if (value.resCode == '00')
                  {
                    Navigator.pop(context),
                    Future.delayed(const Duration(milliseconds: 1), () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            settings: const RouteSettings(
                                name: 'TNH_ConfirmEmail_Screen'),
                            builder: (context) => ConfirmEmailCreen(
                                  ref_no: '${value.refNo}',
                                  hn: '',
                                  card_ID: '',
                                  firstName: '',
                                  lastName: '',
                                  birthday: '',
                                  numberPhone: '',
                                  email: '',
                                  password: '',
                                  confirmPassword: '',
                                  agreementAccept: widget.agreementAccept,
                                  data: value,
                                )),
                      );
                    })
                  }
                else
                  {
                    Navigator.pop(context),
                    Future.delayed(const Duration(milliseconds: 1), () {
                      alertFailApi(context, 'รหัส OTP ไม่ถูกต้อง');
                    })
                  }
              })
          .catchError((onError) {
        Navigator.of(context).pop();
        print('funSendVerifyStep2 $onError');
      });
    } else {
      postService
          .funSendOTP(
              '${refNo != '' ? refNo : widget.data.refNo}',
              otp,
              widget.email,
              widget.card_ID,
              widget.firstName,
              widget.lastName,
              widget.birthday,
              widget.numberPhone)
          .then((value) => {
                if (value.resCode == '00')
                  {
                    Navigator.pop(context),
                    Future.delayed(const Duration(milliseconds: 1), () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            settings: const RouteSettings(
                                name: 'TNH_ConfirmEmail_Screen'),
                            builder: (context) => ConfirmEmailCreen(
                                  ref_no: '${value.refNo}',
                                  hn: '${widget.data.hn}',
                                  card_ID: widget.card_ID,
                                  firstName: widget.firstName,
                                  lastName: widget.lastName,
                                  birthday: widget.birthday,
                                  numberPhone: widget.numberPhone,
                                  email: widget.email,
                                  password: widget.password,
                                  confirmPassword: widget.confirmPassword,
                                  agreementAccept: widget.agreementAccept,
                                  data: value,
                                )),
                      );
                    })
                  }
                else
                  {
                    Navigator.pop(context),
                    alertFailApi(context, 'รหัส OTP ไม่ถูกต้อง'),
                  }
              })
          .catchError((onError) {
        Navigator.of(context).pop();
        print('funSendOTP $onError');
      });
    }
  }

  //fun ส่งอีกครั้ง
  void resendPhone(String numberPhone) {
    AppLoading.show(context);
    if (Provider.of<ProviderHome>(context, listen: false).dataUpdatePolicy ==
        'notactive') {
      postService
          .funResendVerifyStep2()
          .then((value) => {
                if (value?.resCode == '00')
                  {
                    Navigator.pop(context),
                    setState(() {
                      refNo = '${value?.refNo}';
                      timeCount = 300;
                    }),
                  }
                else
                  {
                    Navigator.pop(context),
                    alertFailApi(context, 'ส่งรหัส OTP ไม่สำเร็จ'),
                  }
              })
          .catchError((onError) {
        Navigator.of(context).pop();
        print('funResendVerifyStep2 $onError');
      });
    } else {
      postService
          .funResendPhone(numberPhone)
          .then((value) => {
                if (value?.resCode == '00')
                  {
                    Navigator.pop(context),
                    setState(() {
                      refNo = '${value?.refNo}';
                      timeCount = 300;
                    }),
                  }
                else
                  {
                    Navigator.pop(context),
                    alertFailApi(context, 'ส่งรหัส OTP ไม่สำเร็จ'),
                  }
              })
          .catchError((onError) {
        Navigator.of(context).pop();
        print('funResendPhone $onError');
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
    final fullScreenWidth = MediaQuery.of(context).size.width;
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
                    'ยืนยัน OTP',
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
                              fullScreenWidth < 330
                                  ? 'กรุณากรอกรหัส\nที่ถูกส่งไปยังโทรศัพท์หมายเลข'
                                  : 'กรุณากรอกรหัสที่ถูกส่งไปยังโทรศัพท์หมายเลข',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: ColorTextpolicy,
                                  fontFamily: 'RSU_light',
                                  fontSize: font20),
                            ),
                            Text(
                              '${widget.data.hidePhone}',
                              style: TextStyle(
                                  color: ColorDefaultApp1,
                                  fontFamily: 'RSU_BOLD',
                                  fontSize: font30),
                            ),
                            Text(
                              'รหัสอ้างอิง : ${refNo != '' ? refNo : widget.data.refNo}',
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
                              key: _formKeyOTP,
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
                                            setState(() => otp1 = value)
                                          }
                                      },
                                      textInputAction: TextInputAction.done,
                                      style:
                                          Theme.of(context).textTheme.headlineMedium,
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
                                            setState(() => otp2 = value)
                                          }
                                        else
                                          {
                                            FocusScope.of(context)
                                                .previousFocus(),
                                            setState(() => otp2 = value)
                                          }
                                      },
                                      textInputAction: TextInputAction.done,
                                      style:
                                          Theme.of(context).textTheme.headlineMedium,
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
                                            setState(() => otp3 = value)
                                          }
                                        else
                                          {
                                            FocusScope.of(context)
                                                .previousFocus(),
                                            setState(() => otp3 = value)
                                          }
                                      },
                                      textInputAction: TextInputAction.done,
                                      style:
                                          Theme.of(context).textTheme.headlineMedium,
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
                                            setState(() => otp4 = value)
                                          }
                                        else
                                          {
                                            FocusScope.of(context)
                                                .previousFocus(),
                                            setState(() => otp4 = value)
                                          }
                                      },
                                      textInputAction: TextInputAction.done,
                                      style:
                                          Theme.of(context).textTheme.headlineMedium,
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
                                            setState(() => otp5 = value)
                                          }
                                        else
                                          {
                                            FocusScope.of(context)
                                                .previousFocus(),
                                            setState(() => otp5 = value)
                                          }
                                      },
                                      textInputAction: TextInputAction.done,
                                      style:
                                          Theme.of(context).textTheme.headlineMedium,
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
                                            setState(() => otp6 = value)
                                          }
                                        else
                                          {
                                            FocusScope.of(context)
                                                .previousFocus(),
                                            setState(() => otp6 = value)
                                          }
                                      },
                                      textInputAction: TextInputAction.done,
                                      style:
                                          Theme.of(context).textTheme.headlineMedium,
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
                                  resendPhone(widget.numberPhone);
                                },
                                child: Text(
                                  'ส่งคำขอ OTP อีกครั้ง',
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
                                  if (checkTime) {
                                    print('checkTime $checkTime');
                                  } else {
                                    sendOTP(otp1 +
                                        otp2 +
                                        otp3 +
                                        otp4 +
                                        otp5 +
                                        otp6);
                                  }
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
