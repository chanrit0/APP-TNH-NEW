import 'dart:io';

import 'package:app_tnh2/config/constants.dart';
import 'package:app_tnh2/controller/api.dart';
import 'package:app_tnh2/model/article/modelArticle.dart';
import 'package:app_tnh2/model/banner/modelBanner.dart';
import 'package:app_tnh2/model/profile/modelProfileName.dart';
import 'package:app_tnh2/provider/providerHome.dart';
import 'package:app_tnh2/screens/healthArticles/healthArticles.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:app_tnh2/widgets/Alert/alertLogout.dart';
import 'package:app_tnh2/screens/home/widget/widgetArticle.dart';
import 'package:app_tnh2/screens/home/appointment/appointment.dart';
import 'package:app_tnh2/screens/home/healthResult/healthResult.dart';
import 'package:app_tnh2/screens/home/noti/noti.dart';
import 'package:app_tnh2/screens/home/widget/widgetDrawer.dart';
import 'package:app_tnh2/screens/home/widget/widgetNew.dart';
import 'package:app_tnh2/screens/personalInfo/personalInfo.dart';
import 'package:app_tnh2/screens/personalInfo/widget/latestResults.dart';
import 'package:app_tnh2/screens/personalInfo/widget/latestAppointment.dart';
import 'package:app_tnh2/screens/signUp/policy.dart';
import 'package:app_tnh2/screens/stores/authStore.dart';
import 'package:app_tnh2/widgets/Alert/alertResetPassword.dart';
import 'package:app_tnh2/widgets/Alert/alertDeleteAccount.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:app_tnh2/widgets/Alert/alertUpdateVersion.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:app_tnh2/config/keyStorages.dart';
import 'package:app_tnh2/widgets/Alert/alertSignUpSuccess.dart';
import 'package:app_tnh2/helper/notification_service.dart';

class HomeScreen extends StatefulWidget {
  final bool statusSignUp;
  const HomeScreen({super.key, required this.statusSignUp});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkeyMenu = GlobalKey(); ////keyDrawer

  dynamic funGetAppointment = '';
  dynamic funGetArticle = '';
  dynamic funGetBanner = '';
  dynamic funGetCate = '';
  dynamic funGetProfile = '';
  double countH = 130;
  late Service postService;
  String hnTemp = '';
  String hnName = '';
  dynamic funGetHealthReport = '';
  dynamic funGetHealthReportDetail2;
  dynamic getHealthReportArray = '';
  dynamic getHN = '';
  var requestNoArray = [];
  var visitDateArray = [];
  var vnArray = [];
  String fake = '';
  late dynamic sdsd;

  //opem link
  void _launchUrl(uri) async {
    var urllaunchable = await canLaunch(uri);
    if (urllaunchable) {
      await launch(uri);
    } else {
      print("URL can't be launched. $uri");
    }
  }

  void deleteAcc() async {
    alertDeleteAccount(context, postService);
  }

  void getNotiCount() async {
    postService.funGetNotiCount().then((value) => {
          if (value?.resCode == '00')
            {
              Provider.of<ProviderHome>(context, listen: false).setNotiCount =
                  value?.resData?.count
            }
          else
            {print('Noti Count Error!')}
        });
  }

  void logOut() {
    alertLogout(context, postService);
  }

  void forgotPass() async {
    final String cardId = await accessTokenStore(key: KeyStorages.cardId);
    // ignore: use_build_context_synchronously
    alertResetPassword(context, postService, cardId);
  }

  void checkUpdate() async {
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
        print('${value?.resCode}');
      }
    });
  }

  void checkPolicy() async {
    String? updatePolicy =
        await accessTokenStore(key: KeyStorages.verifyStatus);

    if (updatePolicy == 'notactive') {
      // ignore: use_build_context_synchronously
      Provider.of<ProviderHome>(context, listen: false).setUpdatePolicy =
          updatePolicy;
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.push(
          context,
          MaterialPageRoute(
              settings: const RouteSettings(name: 'TNH_Policy_Screen'),
              builder: (context) => const PolicyScreen('save', '2')),
        );
      });
    } else {
      // print(updatePolicy);
    }
  }

  @override
  void initState() {
    super.initState();
    postService = Service(context: context);
    getNotiCount();
    initializeDateFormatting();
    funGetAppointment = postService.funGetAppointment('1');
    funGetArticle = postService.funGetArticle('', 0, '');
    funGetBanner = postService.funGetBanner(0);
    funGetCate = postService.funGetBanner(1);
    funGetProfile = postService.funGetProfileName();
    loadName();
    FireBaseApi.pushNotification(context);
    checkPolicy();
    checkUpdate();
    Future.delayed(const Duration(seconds: 1), () async {
      if (widget.statusSignUp) {
        await postService.funGetAgreementSave('1', true);
        await postService.funGetAgreementSave('3', true);
        await postService.funGetAgreementSave('4', true);
        // ignore: use_build_context_synchronously
        AlertSignUpSuccess(context);
      }
    });
  }

  Future loadName() async {
    postService.funOnNoti('on');
    await accessTokenStore(
        key: KeyStorages.onOffNotiStore, action: "set", value: 'on');
    getHN = await funGetProfile;
    if (getHN != null) {
      if (getHN.hn != null) {
        funGetHealthReport = postService.funHealthReport('1', getHN.hn);
        getHealthReportArray = await funGetHealthReport;
        for (var i = 0; i < getHealthReportArray.resData.length; i++) {
          requestNoArray.add(getHealthReportArray.resData[i].requestNo);
          String? month = '';
          String? dayt = '';
          if (getHealthReportArray.resData[i].visitDate.month < 10) {
            month = '0${getHealthReportArray.resData[i].visitDate.month}';
          } else {
            month = getHealthReportArray.resData[i].visitDate.month.toString();
          }
          if (getHealthReportArray.resData[i].visitDate.day < 10) {
            dayt = '0${getHealthReportArray.resData[i].visitDate.day}';
          } else {
            dayt = getHealthReportArray.resData[i].visitDate.day.toString();
          }
          String dt =
              '${getHealthReportArray.resData[i].visitDate.year}-$month-$dayt';
          visitDateArray.add('${dt}T00:00:00');
          vnArray.add(getHealthReportArray.resData[i].vn);
        }
        if (requestNoArray.isNotEmpty) {
          funGetHealthReportDetail2 = postService.funHealthReportDetail(
            requestNoArray.join(','),
            visitDateArray.join(','),
            vnArray.join(','),
          );
        }
        setState(() {
          fake = '123';
        });
      }
    }
  }

  void refresh() {
    funGetAppointment = postService.funGetAppointment('1');
    funGetArticle = postService.funGetArticle('', 0, '');
    funGetBanner = postService.funGetBanner(0);
    funGetCate = postService.funGetBanner(1);
    funGetProfile = postService.funGetProfileName();
    loadName();
    checkPolicy();
    checkUpdate();
    getNotiCount();
  }

  @override
  Widget build(BuildContext context) {
    final fullScreenWidth = MediaQuery.of(context).size.width;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        key: _scaffoldkeyMenu,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/backgroundHome@3x.png'),
                fit: BoxFit.cover),
          ),
          child: SafeArea(
              left: false,
              right: false,
              bottom: false,
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: RefreshIndicator(
                        onRefresh: () async {
                          refresh();
                        },
                        child: SizedBox(
                          child: SingleChildScrollView(
                              child: Column(
                            children: [
                              FutureBuilder(
                                future: funGetProfile,
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (snapshot.data == null) {
                                      return const SizedBox();
                                    }
                                    ProfileName item = snapshot.data;
                                    accessTokenStore(
                                        key: KeyStorages.profileName,
                                        action: "set",
                                        value: '${item.fname} ${item.lname}');
                                    accessTokenStore(
                                        key: KeyStorages.profileHn,
                                        action: "set",
                                        value: item.hn ?? '');
                                    return buildHeader(item);
                                  }
                                  return buildHeader(ProfileName(
                                      fname: '', lname: '', hn: '-'));
                                },
                              ),
                              AnimatedSize(
                                curve: Curves.easeInCubic,
                                duration: const Duration(seconds: 1),
                                child: FutureBuilder(
                                  future: funGetAppointment,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      var result = snapshot.data;
                                      if (result == null || result.length < 1) {
                                        return AnimatedSize(
                                            curve: Curves.easeInCubic,
                                            duration:
                                                const Duration(seconds: 1),
                                            child: funGetHealthReportDetail2 !=
                                                        '' &&
                                                    funGetHealthReportDetail2 !=
                                                        null
                                                ? LatestResulte(
                                                    data:
                                                        funGetHealthReportDetail2,
                                                    detail: getHealthReportArray !=
                                                            ''
                                                        ? getHealthReportArray
                                                                    .resData
                                                                    .length >
                                                                0
                                                            ? getHealthReportArray
                                                                .resData[0]
                                                            : ''
                                                        : '')
                                                : const SizedBox());
                                      } else {
                                        return LatestAppointment(result[0]);
                                      }
                                    } else {
                                      return const Center();
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  children: [
                                    Flexible(
                                        flex: 1,
                                        fit: FlexFit.tight,
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8)),
                                          child: Material(
                                              child: InkWell(
                                                  splashColor: ColorDefaultApp1
                                                      .withOpacity(0.5),
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          settings:
                                                              const RouteSettings(
                                                                  name:
                                                                      'TNH_Appointment_Screen'),
                                                          builder: (context) =>
                                                              const AppointmentScreen(
                                                                statusAppoinment:
                                                                    false,
                                                              )),
                                                    );
                                                  },
                                                  child: Ink(
                                                      width: double.infinity,
                                                      height:
                                                          fullScreenWidth > 600
                                                              ? 160.h
                                                              : 160,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        image:
                                                            const DecorationImage(
                                                          image: AssetImage(
                                                              'assets/images/appointmentBG@3x.png'),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          Flexible(
                                                              flex: 1,
                                                              fit:
                                                                  FlexFit.tight,
                                                              child: SizedBox(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              20),
                                                                  child: Row(
                                                                    children: [
                                                                      Image(
                                                                        image: const AssetImage(
                                                                            'assets/images/health-check@3x.png'),
                                                                        height: fullScreenWidth >
                                                                                600
                                                                            ? 45.h
                                                                            : 54,
                                                                        width: fullScreenWidth >
                                                                                600
                                                                            ? 40.w
                                                                            : 50,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              )),
                                                          Flexible(
                                                              flex: 1,
                                                              fit:
                                                                  FlexFit.tight,
                                                              child: SizedBox(
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Text(
                                                                      'นัดหมายแพทย์\nเพื่อตรวจสุขภาพ',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              font22,
                                                                          color:
                                                                              Colors.white),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      maxLines:
                                                                          2,
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 8,
                                                                    )
                                                                  ],
                                                                ),
                                                              )),
                                                        ],
                                                      )))),
                                        )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                        flex: 1,
                                        fit: FlexFit.tight,
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8)),
                                          child: Material(
                                              child: InkWell(
                                                  splashColor: ColorBtRegister
                                                      .withOpacity(0.5),
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          settings:
                                                              const RouteSettings(
                                                                  name:
                                                                      'TNH_HealthResult_Screen'),
                                                          builder: (context) =>
                                                              const HealthResultScreen()),
                                                    );
                                                  },
                                                  child: Ink(
                                                    width: double.infinity,
                                                    height:
                                                        fullScreenWidth > 600
                                                            ? 160.h
                                                            : 160,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      image:
                                                          const DecorationImage(
                                                        image: AssetImage(
                                                            'assets/images/health_checkBG@3x.png'),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Flexible(
                                                            flex: 1,
                                                            fit: FlexFit.tight,
                                                            child: SizedBox(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            20),
                                                                child: Row(
                                                                  children: [
                                                                    Image(
                                                                      image: const AssetImage(
                                                                          'assets/images/appointment@3x.png'),
                                                                      height: fullScreenWidth >
                                                                              600
                                                                          ? 45.h
                                                                          : 54,
                                                                      width: fullScreenWidth >
                                                                              600
                                                                          ? 40.w
                                                                          : 50,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )),
                                                        Flexible(
                                                            flex: 1,
                                                            fit: FlexFit.tight,
                                                            child: SizedBox(
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Text(
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    fullScreenWidth <
                                                                            330
                                                                        ? 'ดูผลตรวจ\nสุขภาพ'
                                                                        : 'ดูผลตรวจสุขภาพ',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            font22,
                                                                        color: Colors
                                                                            .white),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    maxLines: 2,
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 8,
                                                                  )
                                                                ],
                                                              ),
                                                            )),
                                                      ],
                                                    ),
                                                  ))),
                                        )),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              FutureBuilder(
                                future: funGetBanner,
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    List<DataBanner>? item = snapshot.data;
                                    if (item!.isEmpty) {
                                      return Container();
                                    }
                                    return CarouselSlider(
                                      options: CarouselOptions(
                                        height:
                                            fullScreenWidth > 600 ? 190 : 120,
                                        autoPlay: true,
                                        enlargeStrategy:
                                            CenterPageEnlargeStrategy.height,
                                      ),
                                      items: item.map<Widget>((i) {
                                        return Builder(
                                          builder: (BuildContext context) {
                                            return Container(
                                                color: Colors.amber,
                                                margin: const EdgeInsets.only(
                                                    left: 5, right: 5),
                                                alignment: Alignment.center,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    90 /
                                                    100,
                                                child: Container(
                                                    height:
                                                        fullScreenWidth > 600
                                                            ? 190
                                                            : 120,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.5),
                                                          spreadRadius: 1,
                                                          blurRadius: 1,
                                                          offset: const Offset(
                                                              2, 2),
                                                        ),
                                                      ],
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  8)),
                                                      child: SizedBox(
                                                          height:
                                                              fullScreenWidth >
                                                                      600
                                                                  ? 190
                                                                  : 120,
                                                          child: InkWell(
                                                              onTap: () {
                                                                _launchUrl(
                                                                    i.url);
                                                              },
                                                              child: Image.network(
                                                                  '${i.img}',
                                                                  fit: BoxFit
                                                                      .cover))),
                                                    )));
                                          },
                                        );
                                      }).toList(),
                                    );
                                  } else {
                                    return const ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        child: Stack(
                                          children: [
                                            SizedBox(
                                              height: 0,
                                              child: LinearProgressIndicator(),
                                            )
                                          ],
                                        ));
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: fullScreenWidth > 600
                                    ? fullScreenWidth > 750 ||
                                            fullScreenWidth < 800
                                        ? 130
                                        : 170
                                    : 136,
                                child: FutureBuilder(
                                  future: funGetCate,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      var result = snapshot.data;
                                      if (result == null) {
                                        return const SizedBox();
                                      } else {
                                        return ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: result.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              final item = result[index];
                                              return Article(
                                                urlImage: item.icon,
                                                category: item.category,
                                                cateId: item.cateId.toString(),
                                              );
                                            });
                                      }
                                    }
                                    return ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 1,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Article(
                                            urlImage: '',
                                            category: '',
                                            cateId: '',
                                          );
                                        });
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 20),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Image(
                                      image: AssetImage(
                                          'assets/icons/addArticle@3x.png'),
                                      height: 14,
                                      width: 14,
                                    ),
                                    Text(
                                      ' บทความสุขภาพ',
                                      style: TextStyle(
                                          color: ColorDefaultApp1,
                                          fontSize: font20),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: FutureBuilder(
                                  future: funGetArticle,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      List<ResDatum>? result = snapshot.data;

                                      if (result == null) {
                                        return const SizedBox();
                                      } else {
                                        double sizedBox = fullScreenWidth > 600
                                            ? fullScreenWidth > 750 ||
                                                    fullScreenWidth < 800
                                                ? 210.h
                                                : 160.h
                                            : 120;
                                        countH = result.length * sizedBox;

                                        return SizedBox(
                                            height: countH,
                                            child: ListView.builder(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: result.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Row(
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          children: [
                                                            New(
                                                                result[index]
                                                                    .img,
                                                                result[index]
                                                                    .title,
                                                                result[index]
                                                                    .detail,
                                                                result[index]
                                                                    .url),
                                                            const SizedBox(
                                                              height: 10,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                }));
                                      }
                                    }
                                    return SizedBox(
                                        height: countH,
                                        child: ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: 1,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Row(
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        New('', '', '', ''),
                                                        const SizedBox(
                                                          height: 10,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }));
                                  },
                                ),
                              ),
                            ],
                          )),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 10,
                            right: 10,
                            bottom: Platform.isIOS ? 20 : 10,
                            top: 10),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: InkWell(
                                  onTap: () {
                                    print('หน้าหลัก');
                                  },
                                  child: Column(
                                    children: [
                                      const Image(
                                        image: AssetImage(
                                            'assets/icons/home@3x.png'),
                                        height: 20,
                                        width: 20,
                                      ),
                                      Text(
                                        'หน้าหลัก',
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: ColorDefaultApp1,
                                            fontSize: font14),
                                      )
                                    ],
                                  )),
                            ),
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
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
                                  child: Column(
                                    children: [
                                      Image(
                                        image: const AssetImage(
                                            'assets/icons/health-check@3x.png'),
                                        height: 20.h,
                                        width: 20.w,
                                      ),
                                      Text(
                                        'ตรวจสุขภาพ',
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: ColorDefaultApp0,
                                            fontSize: font14),
                                      )
                                    ],
                                  )),
                            ),
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          settings: const RouteSettings(
                                              name:
                                                  'TNH_HeallthArticles_Screen'),
                                          builder: (context) =>
                                              const HeallthArticlesScreen()),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      Image(
                                        image: const AssetImage(
                                            'assets/icons/health-articles@3x.png'),
                                        height: 20.h,
                                        width: 20.w,
                                      ),
                                      Text('บทความสุขภาพ',
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: ColorDefaultApp0,
                                              fontSize: font14))
                                    ],
                                  )),
                            ),
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          settings: const RouteSettings(
                                              name: 'TNH_PersonalInfo_Screen'),
                                          builder: (context) =>
                                              PersonalInfoScreen(
                                                  data:
                                                      funGetHealthReportDetail2,
                                                  detail: getHealthReportArray !=
                                                          ''
                                                      ? getHealthReportArray
                                                                  .resData
                                                                  .length >
                                                              0
                                                          ? getHealthReportArray
                                                              .resData[0]
                                                          : ''
                                                      : '')),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      Image(
                                        image: const AssetImage(
                                            'assets/icons/user-anticon@3x.png'),
                                        height: 20.h,
                                        width: 20.w,
                                      ),
                                      Text('ข้อมูลส่วนตัว',
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: ColorDefaultApp0,
                                              fontSize: font14))
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
        endDrawer: Drawer(
          width: MediaQuery.of(context).size.width / 1.2,
          child: SafeArea(
              child: Column(
            children: [
              SizedBox(
                height: 40.h,
                child: Row(
                  children: [
                    const Flexible(
                        flex: 1, fit: FlexFit.tight, child: Text('')),
                    Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Row(
                          children: [
                            Text(
                              'Menu',
                              style: TextStyle(
                                  color: ColorDefaultApp1, fontSize: font20),
                            ),
                          ],
                        )),
                    Flexible(
                      flex: 0,
                      fit: FlexFit.tight,
                      child: InkWell(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Image(
                              image: const AssetImage(
                                  'assets/icons/menuDrawerun@3x.png'),
                              height: fullScreenWidth > 600 ? 25.h : 30,
                              width: fullScreenWidth > 600 ? 25.w : 30,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                          }),
                    )
                  ],
                ),
              ),
              MenuDrawer(
                  logOut: logOut,
                  deletAcc: deleteAcc,
                  forgotPass: forgotPass,
                  checkup: funGetHealthReportDetail2,
                  detail: getHealthReportArray != ''
                      ? getHealthReportArray.resData.length > 0
                          ? getHealthReportArray.resData[0]
                          : ''
                      : '')
            ],
          )),
        ),
      ),
    );
  }

  Widget buildHeader(ProfileName item) {
    final fullScreenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Row(
                  children: [
                    Text(
                      'สวัสดี ',
                      style:
                          TextStyle(color: ColorBtRegister, fontSize: font18),
                    ),
                    Text(
                      item.fname != '' ? 'คุณ ${item.fname}' : '',
                      style:
                          TextStyle(color: ColorDefaultApp1, fontSize: font24),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Expanded(
                      child: Text(
                        ' ${item.lname}',
                        style: TextStyle(
                            color: ColorDefaultApp1, fontSize: font24),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    )
                  ],
                ),
              ),
              Flexible(
                  flex: 0,
                  fit: FlexFit.tight,
                  child: Consumer<ProviderHome>(
                    builder: (context, value, child) => Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  settings: const RouteSettings(
                                      name: 'TNH_ Noti_Screen'),
                                  builder: (context) => const NotiScreen()),
                            );
                          },
                          child: value.notiCount > 0
                              ? Image(
                                  image: const AssetImage(
                                      'assets/icons/notiOn@3x.png'),
                                  height: fullScreenWidth > 600 ? 25.h : 30,
                                  width: fullScreenWidth > 600 ? 25.w : 30,
                                )
                              : Image(
                                  image: const AssetImage(
                                      'assets/icons/noti@3x.png'),
                                  height: fullScreenWidth > 600 ? 25.h : 30,
                                  width: fullScreenWidth > 600 ? 25.w : 30,
                                ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {
                            _scaffoldkeyMenu.currentState?.openEndDrawer();
                          },
                          child: Image(
                            image: const AssetImage(
                                'assets/icons/menuDrawer@3x.png'),
                            height: fullScreenWidth > 600 ? 25.h : 30,
                            width: fullScreenWidth > 600 ? 25.w : 30,
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            children: [
              Text(
                'HN : ',
                style: TextStyle(color: ColorDefaultApp1, fontSize: font20),
              ),
              Text(
                item.hn ?? '-',
                style: TextStyle(color: ColorDefaultApp1, fontSize: font20),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
