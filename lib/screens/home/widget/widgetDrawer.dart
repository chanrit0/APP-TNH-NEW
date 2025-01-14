import 'package:app_tnh2/config/constants.dart';
import 'package:app_tnh2/screens/healthArticles/healthArticles.dart';
import 'package:app_tnh2/screens/home/appointment/appointment.dart';
import 'package:app_tnh2/screens/home/contact/contact.dart';
import 'package:app_tnh2/screens/home/healthResult/healthResult.dart';
import 'package:app_tnh2/screens/home/widget/widgetSwich.dart';
import 'package:app_tnh2/screens/personalInfo/personalInfo.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:app_tnh2/screens/signUp/policy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuDrawer extends StatelessWidget {
  final Function logOut;
  final Function deletAcc;
  final Function forgotPass;
  final dynamic checkup;
  final dynamic detail;
  const MenuDrawer(
      {super.key,
      required this.logOut,
      required this.deletAcc,
      required this.forgotPass,
      required this.checkup,
      required this.detail});

  @override
  Widget build(BuildContext context) {
    final fullScreenWidth = MediaQuery.of(context).size.width;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Flexible(
        flex: 1,
        fit: FlexFit.tight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Divider(
              color: ColorDivider,
              height: fullScreenWidth > 600 ? 20.h : 20,
              thickness: 1,
              endIndent: 0,
            ),
            Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: SizedBox(
                    child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          child: InkWell(
                            onTap: (() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    settings: const RouteSettings(
                                        name: 'TNH_PersonalInfo_Screen'),
                                    builder: (context) => PersonalInfoScreen(
                                        data: checkup, detail: detail)),
                              );
                            }),
                            child: Row(
                              children: [
                                Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Image(
                                      image: const AssetImage(
                                          'assets/icons/user-anticon2@3x.png'),
                                      height: fullScreenWidth > 600 ? 20.h : 20,
                                      width: fullScreenWidth > 600 ? 20.h : 20,
                                    )),
                                Flexible(
                                    flex: 5,
                                    fit: FlexFit.tight,
                                    child: Text(
                                      'ข้อมูลส่วนตัว',
                                      style: TextStyle(
                                          color: ColorDefaultApp0,
                                          fontSize: font20,
                                          fontFamily: 'RSU_Regular'),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: fullScreenWidth > 600 ? 20.h : 15,
                        ),
                        SizedBox(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    settings: const RouteSettings(
                                        name: 'TNH_Appointment_Screen'),
                                    builder: (context) =>
                                        const AppointmentScreen(
                                          statusAppoinment: false,
                                        )),
                              );
                            },
                            child: Row(
                              children: [
                                Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Image(
                                      image: const AssetImage(
                                          'assets/icons/IconDrawer2@3x.png'),
                                      height: fullScreenWidth > 600 ? 20.h : 20,
                                      width: fullScreenWidth > 600 ? 20.h : 20,
                                    )),
                                Flexible(
                                    flex: 5,
                                    fit: FlexFit.tight,
                                    child: Text(
                                      'นัดหมายแพทย์เพื่อตรวจสุขภาพ',
                                      style: TextStyle(
                                          color: ColorDefaultApp0,
                                          fontSize: font20,
                                          fontFamily: 'RSU_Regular'),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: fullScreenWidth > 600 ? 20.h : 15,
                        ),
                        SizedBox(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    settings: const RouteSettings(
                                        name: 'TNH_HealthResult_Screen'),
                                    builder: (context) =>
                                        const HealthResultScreen()),
                              );
                            },
                            child: Row(
                              children: [
                                Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Image(
                                      image: const AssetImage(
                                          'assets/icons/IconDrawer3@3x.png'),
                                      height: fullScreenWidth > 600 ? 20.h : 20,
                                      width: fullScreenWidth > 600 ? 20.h : 20,
                                    )),
                                Flexible(
                                    flex: 5,
                                    fit: FlexFit.tight,
                                    child: Text(
                                      'ดูผลตรวจสุขภาพ',
                                      style: TextStyle(
                                          color: ColorDefaultApp0,
                                          fontSize: font20,
                                          fontFamily: 'RSU_Regular'),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: fullScreenWidth > 600 ? 20.h : 15,
                        ),
                        SizedBox(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    settings: const RouteSettings(
                                        name: 'TNH_HeallthArticles_Screen'),
                                    builder: (context) =>
                                        const HeallthArticlesScreen()),
                              );
                            },
                            child: Row(
                              children: [
                                Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Image(
                                      image: const AssetImage(
                                          'assets/icons/IconDrawer4@3x.png'),
                                      height: fullScreenWidth > 600 ? 20.h : 20,
                                      width: fullScreenWidth > 600 ? 20.h : 20,
                                    )),
                                Flexible(
                                    flex: 5,
                                    fit: FlexFit.tight,
                                    child: Text(
                                      'บทความสุขภาพ',
                                      style: TextStyle(
                                          color: ColorDefaultApp0,
                                          fontSize: font20,
                                          fontFamily: 'RSU_Regular'),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: fullScreenWidth > 600 ? 20.h : 15,
                        ),
                        SizedBox(
                          child: InkWell(
                            onTap: () {
                              forgotPass();
                            },
                            child: Row(
                              children: [
                                Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Image(
                                      image: const AssetImage(
                                          'assets/icons/unlock-anticon@3x.png'),
                                      height: fullScreenWidth > 600 ? 20.h : 20,
                                      width: fullScreenWidth > 600 ? 20.h : 20,
                                    )),
                                Flexible(
                                    flex: 5,
                                    fit: FlexFit.tight,
                                    child: Text(
                                      'เปลี่ยนรหัสผ่าน',
                                      style: TextStyle(
                                          color: ColorDefaultApp0,
                                          fontSize: font20,
                                          fontFamily: 'RSU_Regular'),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: fullScreenWidth > 600 ? 20.h : 10,
                        ),
                        SizedBox(
                          child: Row(
                            children: [
                              Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Image(
                                    image: const AssetImage(
                                        'assets/icons/notification-anticon@3x.png'),
                                    height: fullScreenWidth > 600 ? 20.h : 20,
                                    width: fullScreenWidth > 600 ? 20.h : 20,
                                  )),
                              Flexible(
                                  flex: 3,
                                  fit: FlexFit.tight,
                                  child: Text(
                                    'ปิด/เปิด การแจ้งเตือน',
                                    style: TextStyle(
                                        color: ColorDefaultApp0,
                                        fontSize: font20,
                                        fontFamily: 'RSU_Regular'),
                                  )),
                              const Flexible(
                                  flex: 2,
                                  fit: FlexFit.tight,
                                  child: SwitchExample()),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: fullScreenWidth > 600 ? 20.h : 10,
                        ),
                        SizedBox(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    settings: const RouteSettings(
                                        name: 'TNH_Contact_Screen'),
                                    builder: (context) =>
                                        const ContactScreen()),
                              );
                            },
                            child: Row(
                              children: [
                                Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Image(
                                      image: const AssetImage(
                                          'assets/icons/contacts-anticon@3x.png'),
                                      height: fullScreenWidth > 600 ? 20.h : 20,
                                      width: fullScreenWidth > 600 ? 20.h : 20,
                                    )),
                                Flexible(
                                    flex: 5,
                                    fit: FlexFit.tight,
                                    child: Text(
                                      'ติดต่อเรา',
                                      style: TextStyle(
                                          color: ColorDefaultApp0,
                                          fontSize: font20,
                                          fontFamily: 'RSU_Regular'),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: fullScreenWidth > 600 ? 20.h : 15,
                        ),
                        SizedBox(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    settings: const RouteSettings(
                                        name: 'TNH_Policy_Screen'),
                                    builder: (context) =>
                                        const PolicyScreen("update", "1")),
                              );
                            },
                            child: Row(
                              children: [
                                Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Image(
                                      image: const AssetImage(
                                          'assets/icons/safety-anticon@3x.png'),
                                      height: fullScreenWidth > 600 ? 20.h : 20,
                                      width: fullScreenWidth > 600 ? 20.h : 20,
                                    )),
                                Flexible(
                                    flex: 5,
                                    fit: FlexFit.tight,
                                    child: Text(
                                      'เงื่อนไขการใช้งานแอปพลิเคชัน',
                                      style: TextStyle(
                                          color: ColorDefaultApp0,
                                          fontSize: font20,
                                          fontFamily: 'RSU_Regular'),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: fullScreenWidth > 600 ? 20.h : 15,
                        ),
                        SizedBox(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    settings: const RouteSettings(
                                        name: 'TNH_Policy_Screen'),
                                    builder: (context) =>
                                        const PolicyScreen("update", "2")),
                              );
                            },
                            child: Row(
                              children: [
                                Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Image(
                                      image: const AssetImage(
                                          'assets/icons/safety-anticon@3x.png'),
                                      height: fullScreenWidth > 600 ? 20.h : 20,
                                      width: fullScreenWidth > 600 ? 20.h : 20,
                                    )),
                                Flexible(
                                    flex: 5,
                                    fit: FlexFit.tight,
                                    child: Text(
                                      'นโยบายข้อมูลส่วนบุคคล',
                                      style: TextStyle(
                                          color: ColorDefaultApp0,
                                          fontSize: font20,
                                          fontFamily: 'RSU_Regular'),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: fullScreenWidth > 600 ? 20.h : 15,
                        ),
                        SizedBox(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    settings: const RouteSettings(
                                        name: 'TNH_Policy_Screen'),
                                    builder: (context) =>
                                        const PolicyScreen("update", "3")),
                              );
                            },
                            child: Row(
                              children: [
                                Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Image(
                                      image: const AssetImage(
                                          'assets/icons/safety-anticon@3x.png'),
                                      height: fullScreenWidth > 600 ? 20.h : 20,
                                      width: fullScreenWidth > 600 ? 20.h : 20,
                                    )),
                                Flexible(
                                    flex: 5,
                                    fit: FlexFit.tight,
                                    child: Text(
                                      'การยินยอมเปิดเผยข้อมูลสุขภาพ',
                                      style: TextStyle(
                                          color: ColorDefaultApp0,
                                          fontSize: font20,
                                          fontFamily: 'RSU_Regular'),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: fullScreenWidth > 600 ? 20.h : 15,
                        ),
                        SizedBox(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    settings: const RouteSettings(
                                        name: 'TNH_Policy_Screen'),
                                    builder: (context) =>
                                        const PolicyScreen("update", "4")),
                              );
                            },
                            child: Row(
                              children: [
                                Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Image(
                                      image: const AssetImage(
                                          'assets/icons/safety-anticon@3x.png'),
                                      height: fullScreenWidth > 600 ? 20.h : 20,
                                      width: fullScreenWidth > 600 ? 20.h : 20,
                                    )),
                                Flexible(
                                    flex: 5,
                                    fit: FlexFit.tight,
                                    child: Text(
                                      'การยินยอมเปิดเผยข้อมูลการตลาด',
                                      style: TextStyle(
                                          color: ColorDefaultApp0,
                                          fontSize: font20,
                                          fontFamily: 'RSU_Regular'),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: fullScreenWidth > 600 ? 20.h : 15,
                        ),
                        SizedBox(
                            child: InkWell(
                          onTap: () {
                            deletAcc();
                          },
                          child: Row(
                            children: [
                              Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Image(
                                    image: const AssetImage(
                                        'assets/icons/minus-circle-o-anticon@3x.png'),
                                    height: fullScreenWidth > 600 ? 20.h : 20,
                                    width: fullScreenWidth > 600 ? 20.h : 20,
                                  )),
                              Flexible(
                                  flex: 5,
                                  fit: FlexFit.tight,
                                  child: Text(
                                    'ลบบัญชีผู้ใช้',
                                    style: TextStyle(
                                        color: const Color(0xffff6742),
                                        fontSize: font20,
                                        fontFamily: 'RSU_Regular'),
                                  )),
                            ],
                          ),
                        )),
                      ],
                    ),
                  ),
                ))),
            const Divider(
              color: ColorDivider,
              thickness: 1,
              endIndent: 0,
            ),
            SizedBox(
                height: 50,
                child: InkWell(
                  onTap: () {
                    logOut();
                  },
                  child: Row(
                    children: [
                      Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Image(
                            image: const AssetImage(
                                'assets/icons/power-simple-line-icons@3x.png'),
                            height: fullScreenWidth > 600 ? 20.h : 20,
                            width: 21,
                          )),
                      Flexible(
                          flex: 5,
                          fit: FlexFit.tight,
                          child: Text(
                            'ออกจากระบบ',
                            style: TextStyle(
                                color: const Color(0xffff6742),
                                fontSize: font20,
                                fontFamily: 'RSU_Regular'),
                          )),
                    ],
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Version. ${ApiConstants.versionName}',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 175, 174, 180),
                        fontSize: font17,
                        fontFamily: 'RSU_Regular'))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 10),
                  child: Image(
                    image: AssetImage('assets/images/iamgeDrawer@3x.png'),
                    height: 57,
                    width: 200,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
