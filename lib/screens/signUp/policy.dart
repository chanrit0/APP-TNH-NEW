import 'package:app_tnh2/controller/api.dart';
import 'package:app_tnh2/provider/providerHome.dart';
import 'package:app_tnh2/screens/home/appointment/widget/alert/alertFailApi.dart';
import 'package:app_tnh2/screens/signUp/confirmOTP.dart';
import 'package:app_tnh2/screens/signUp/signup.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:app_tnh2/widgets/app_loading.dart';
import 'package:app_tnh2/widgets/stateScreenDetails.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PolicyScreen extends StatefulWidget {
  final String type;
  final String event;
  const PolicyScreen(this.type, this.event, {super.key});

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  bool isChecked = false; //เลือกอนุญาตินโยบาย
  bool _isDisable = true; //dis ปุ่ม แต่ไม่รู้จะเอาไหม
  late Service postService;
  dynamic funGetAgreement = '';
  dynamic funGetAgreementCheck = '';

  late WebViewController controller;
  String textAgreement = '';

  void _navigation() async {
    if (widget.type == "save") {
      if (Provider.of<ProviderHome>(context, listen: false).dataUpdatePolicy ==
          'notactive') {
        verifyMember();
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
              settings: const RouteSettings(name: 'TNH_Signup_Screen'),
              builder: (context) => SignupScreen(
                    agreementAccept: isChecked,
                  )),
        );
      }
    } else {
      final res =
          await postService.funGetAgreementSave(widget.event, isChecked);
      if (res == '00') {
        print('00');
      } else {
        print('01');
      }
      Navigator.pop(context);
    }
  }

  void verifyMember() async {
    AppLoading.show(context);
    postService.funVerifyMemberStep1().then((value) => {
          if (value.resCode == '00')
            {
              AppLoading.hide(context),
              Navigator.push(
                context,
                MaterialPageRoute(
                    settings:
                        const RouteSettings(name: 'TNH_ConfirmOtp_Screen'),
                    builder: (context) => ConfirmOtpScreen(
                          card_ID: '',
                          firstName: '',
                          lastName: '',
                          birthday: '',
                          numberPhone: '',
                          email: '',
                          password: '',
                          confirmPassword: '',
                          agreementAccept: isChecked,
                          data: value,
                        )),
              ),
            }
          else
            {
              AppLoading.hide(context),
              alertFailApi(context, value.resText!),
            }
        });
  }

  @override
  void initState() {
    super.initState();
    postService = Service(context: context);
    funGetAgreement = postService.funGetAgreement();
    if (widget.type == "update") {
      loadCheck();
    }
  }

  Future loadCheck() async {
    funGetAgreementCheck = await postService.funGetAgreementCheck();
    setState(() {
      _isDisable = false;
      if (widget.event == '1') {
        isChecked = funGetAgreementCheck.resData.termsOfUse ?? false;
      } else if (widget.event == '2') {
        isChecked = funGetAgreementCheck.resData.privacyPolicy ?? false;
      } else if (widget.event == '3') {
        isChecked = funGetAgreementCheck.resData.healthPolicy ?? false;
      } else {
        isChecked = funGetAgreementCheck.resData.marketingPolicy ?? false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: StateScreenDetails(
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
                  widget.event == '1'
                      ? 'เงื่อนไขการใช้งานแอปพลิเคชัน'
                      : widget.event == '2'
                          ? 'นโยบายข้อมูลส่วนบุคคล'
                          : widget.event == '3'
                              ? 'การยินยอมเปิดเผยข้อมูลสุขภาพ'
                              : 'การยินยอมเปิดเผยข้อมูลการตลาด',
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
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                ),
                child: Column(
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: FutureBuilder(
                            future: funGetAgreement,
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                var item = snapshot.data;

                                if (item == null) {
                                  return const SizedBox();
                                } else {
                                  return SingleChildScrollView(
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: HtmlWidget(
                                        widget.event == '1'
                                            ? item.resData?.termsOfUse
                                                ?.replaceAll('\n', '')
                                                .replaceAll('\r', '')
                                            : widget.event == '2'
                                                ? item.resData?.privacyPolicy
                                                    ?.replaceAll('\n', '')
                                                    .replaceAll('\r', '')
                                                    .replaceAll(
                                                        '<h2 style=\"text-align: center;color: #595a5c;\"><h4 class=\"_tal-ct _mgbt-32px orange-border-header\" style=\"text-align: center;\"></h4>',
                                                        '')
                                                : widget.event == '3'
                                                    ? item.resData?.healthPolicy
                                                        ?.replaceAll('\n', '')
                                                        .replaceAll('\r', '')
                                                        .replaceAll(
                                                            '<h2 style=\"text-align: center;color: #595a5c;\"><h4 class=\"_tal-ct _mgbt-32px orange-border-header\" style=\"text-align: center;\"></h4>',
                                                            '')
                                                    : item.resData
                                                        ?.marketingPolicy
                                                        ?.replaceAll('\n', '')
                                                        .replaceAll('\r', '')
                                                        .replaceAll(
                                                            '<h2 style=\"text-align: center;color: #595a5c;\"><h4 class=\"_tal-ct _mgbt-32px orange-border-header\" style=\"text-align: center;\">',
                                                            ''),
                                        textStyle: const TextStyle(
                                          fontFamily: 'RSU_BOLD',
                                          fontSize: 18,
                                          color: ColorDefaultApp0,
                                        ),
                                        customStylesBuilder: (element) {
                                          return {
                                            'font-size': '18px',
                                          };
                                        },
                                      ),
                                    ),
                                  );
                                }
                              }
                              return const Center(
                                  child: SpinKitRing(color: ColorDefaultApp1));
                            },
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 0,
                      fit: FlexFit.tight,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Checkbox(
                                  checkColor: Colors.white,
                                  activeColor: const Color(0xff29989b),
                                  value: isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked = value!;
                                      if (widget.type == "save") {
                                        if (isChecked) {
                                          setState(() {
                                            _isDisable = false;
                                          });
                                        } else {
                                          setState(() {
                                            _isDisable = true;
                                          });
                                        }
                                      }
                                    });
                                  },
                                ),
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        isChecked = !isChecked;
                                        if (widget.type == "save") {
                                          if (isChecked) {
                                            setState(() {
                                              _isDisable = false;
                                            });
                                          } else {
                                            setState(() {
                                              _isDisable = true;
                                            });
                                          }
                                        }
                                      });
                                    },
                                    child: Text(
                                      'ยอมรับ',
                                      style: TextStyle(
                                          fontSize: font20,
                                          color: ColorDefaultApp0),
                                    )),
                                const SizedBox(
                                  width: 20,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            right: 20.0,
                          ),
                          child: ElevatedButton(
                            onPressed: _isDisable ? null : _navigation,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorDefaultApp1,
                              shadowColor: ColorDefaultApp1,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              minimumSize: const Size(double.infinity, 44),
                            ),
                            child: Text(
                              widget.type == "save" ? 'ดำเนินการต่อ' : 'บันทึก',
                              style: TextStyle(
                                  fontSize: font18, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
