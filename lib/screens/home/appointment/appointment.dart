import 'package:app_tnh2/controller/api.dart';
import 'package:app_tnh2/model/appointment/modelAppointment.dart';
import 'package:app_tnh2/model/tabBarModel.dart';
import 'package:app_tnh2/screens/CheckAuth.dart';
import 'package:app_tnh2/screens/home/appointment/startAppoint/AppointmentCard.dart/appointmentCard.dart';
import 'package:app_tnh2/screens/home/appointment/startAppoint/appointmentStep1.dart';
import 'package:app_tnh2/screens/home/appointment/startAppoint/appointmentStep2.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:app_tnh2/widgets/stateScreenDetails.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:app_tnh2/config/keyStorages.dart';
import 'package:app_tnh2/screens/stores/authStore.dart';
import 'package:app_tnh2/plugin/buddhist_datetime_dateformat.dart';

class AppointmentScreen extends StatefulWidget {
  final bool statusAppoinment;
  const AppointmentScreen({
    super.key,
    required this.statusAppoinment,
  });

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  int appointmentSelect = 0; //ค่าเวลาเลือกแต่ละ tab

  //tab
  late List<TabBarModel> tabTitelList = [];
  static List<TabBarModel> getTabTitelList() {
    const data = [
      {"id": 0, "titel": "Package"},
      {"id": 1, "titel": "เร็ว ๆ นี้"},
      {"id": 2, "titel": "เสร็จสิ้นแล้ว"},
      {"id": 3, "titel": "ยกเลิกนัด"}
    ];

    return data.map<TabBarModel>(TabBarModel.fromJson).toList();
  }

  static List<TabBarModel> getTabTitelListNoPack() {
    const data = [
      {"id": 0, "titel": "เร็ว ๆ นี้"},
      {"id": 1, "titel": "เสร็จสิ้นแล้ว"},
      {"id": 2, "titel": "ยกเลิกนัด"}
    ];

    return data.map<TabBarModel>(TabBarModel.fromJson).toList();
  }

  //fun tab sroll
  late AutoScrollController controller;
  Future _nextCounter(counter) {
    setState(() => counter = counter);
    return _scrollToCounter();
  }

  final scrollDirection = Axis.horizontal;
  int counter = 0;
  Future _scrollToCounter() async {
    await controller.scrollToIndex(counter,
        preferPosition: AutoScrollPosition.middle);
    controller.highlight(counter);
  }

  //////////////////////
  dynamic funGetPackage = '';
  dynamic funGetPackage2;
  dynamic funGetAppointment = '';
  late Service postService;
  @override
  initState() {
    super.initState();
    initializeDateFormatting();
    controller = AutoScrollController(axis: scrollDirection);
    postService = Service(context: context);
    funGetPackage = postService.funGetPackage();
    otherFunction(funGetPackage);
    funGetAppointment = postService.funGetAppointment('2');
  }

  otherFunction(loadPack) async {
    funGetPackage2 = await loadPack;
    dynamic accessToken =
        await accessTokenStore(key: KeyStorages.tabAppointment);

    if (accessToken == null || accessToken == '') {
      if (funGetPackage2 != null) {
        if (funGetPackage2.resCode == "00") {
          tabTitelList = getTabTitelList();
        } else {
          tabTitelList = getTabTitelListNoPack();
        }
      } else {
        tabTitelList = getTabTitelListNoPack();
      }
      setState(() {
        setState(() => {appointmentSelect = 0});
      });
    } else {
      if (funGetPackage2 != null) {
        if (funGetPackage2.resCode == "00") {
          tabTitelList = getTabTitelList();
          setState(() {
            setState(() => {appointmentSelect = int.parse(accessToken)});
          });
          _nextCounter(counter = int.parse(accessToken));
        } else {
          tabTitelList = getTabTitelListNoPack();
          setState(() {
            setState(() => {appointmentSelect = int.parse(accessToken) - 1});
          });
          _nextCounter(counter = int.parse(accessToken) - 1);
        }
      } else {
        tabTitelList = getTabTitelListNoPack();
        setState(() {
          setState(() => {appointmentSelect = int.parse(accessToken) - 1});
        });
        _nextCounter(counter = int.parse(accessToken));
      }

      await accessTokenStore(
          key: KeyStorages.tabAppointment, action: "set", value: '');
    }
  }

  //กรณีเลือก tab
  switchCaseTab(
    selectTab,
  ) {
    switch (selectTab) {
      case 0:
        return tab0();
      case 1:
        return tab1();
      case 2:
        return tab2();
      case 3:
        return tab3();
    }
  }

  switchCaseTabNoPack(
    selectTab,
  ) {
    switch (selectTab) {
      case 0:
        return tab1();
      case 1:
        return tab2();
      case 2:
        return tab3();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: StateScreenDetails(
          child: Column(
        children: [
          Row(
            children: [
              Flexible(
                  flex: 0,
                  fit: FlexFit.tight,
                  child: Row(
                    children: [
                      IconButton(
                        iconSize: 33,
                        icon: const Icon(Icons.chevron_left),
                        color: ColorDefaultApp0,
                        onPressed: () {
                          if (widget.statusAppoinment) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  settings: const RouteSettings(
                                      name: 'TNH_SignIn_Screen'),
                                  builder: (BuildContext context) =>
                                      const CheckAuth()),
                              ModalRoute.withName('/'),
                            );
                          } else {
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ],
                  )),
              Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'นัดหมายแพทย์เพื่อตรวจสุขภาพ',
                        style: TextStyle(
                            fontSize: font20, color: ColorDefaultApp0),
                      ),
                      const SizedBox(
                        width: 50,
                      )
                    ],
                  )),
            ],
          ),
          tabTitelList.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      scrollDirection: scrollDirection,
                      controller: controller,
                      children: tabTitelList.map<Widget>((item) {
                        return _getRow(item.id, item.titel);
                      }).toList(),
                    ),
                  ),
                )
              : const SizedBox(),
          funGetPackage2 != null
              ? Flexible(
                  flex: 5,
                  fit: FlexFit.tight,
                  child: Container(
                    child: funGetPackage2.resCode == "01"
                        ? switchCaseTabNoPack(appointmentSelect)
                        : switchCaseTab(appointmentSelect),
                  ))
              : Container(),
          funGetPackage2 != null &&
                  funGetPackage2.resCode == "00" &&
                  appointmentSelect == 0
              ? Container()
              : funGetPackage2 != null
                  ? Flexible(
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
                                child: Column(
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  settings: const RouteSettings(
                                                      name:
                                                          'TNH_AppointmentStep2_Screen'),
                                                  builder: (context) =>
                                                      AppointmentStep2Screen(
                                                          '', '')));
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
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Image(
                                              image: AssetImage(
                                                  'assets/icons/calendar-simple@3x.png'),
                                              height: 20,
                                              width: 20,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'เริ่มนัดหมาย',
                                              style: TextStyle(
                                                  fontSize: font18,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container()
        ],
      )),
    );
  }

  //tab ไม่มีข้อมูล
  Column tabNotData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Image(
          image: AssetImage('assets/icons/calendar-simple-line-icons@3x.png'),
          height: 50,
          width: 50,
        ),
        const SizedBox(
          height: 11,
        ),
        Text(
          'ท่านยังไม่มีการนัดหมาย',
          style: TextStyle(color: Colors.grey, fontSize: font20),
        )
      ],
    );
  }

  //tab package
  Column tab0() {
    return Column(children: [buildItemTabPackage(funGetPackage)]);
  }

  //tab เร็ว ๆ นี้
  Center tab1() {
    return Center(child: buildItemTab(funGetAppointment, "0"));
  }

  //tab เสร็จสิ้นแล้ว
  Center tab2() {
    return Center(child: buildItemTab(funGetAppointment, "1"));
  }

  //tab ยกเลิกนัด
  Center tab3() {
    // return Center(child: tabNotData());
    return Center(child: buildItemTab(funGetAppointment, "2"));
  }

  //render item นัดหมาย package
  Widget buildItemTabPackage(
    appointmentData,
  ) =>
      FutureBuilder(
        future: appointmentData,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var result = snapshot.data;
            if (result.resCode == '01') {
              return const SizedBox();
            }

            return Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          settings: const RouteSettings(
                              name: 'TNH_AppointmentStep1_Screen'),
                          builder: (context) =>
                              AppointmentStep1Screen(result)));
                },
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 20,
                        offset: const Offset(5, 0),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 0),
                              ),
                            ],
                            image: const DecorationImage(
                                image: AssetImage(
                                    'assets/images/backgroundListNoti2@3x.png'),
                                fit: BoxFit.cover),
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: 130,
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, top: 10, bottom: 10, right: 20),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Package ตรวจสุขภาพประจำปีบริษัทคู่สัญญา',
                                                style: TextStyle(
                                                    color: ColorDefaultApp0,
                                                    fontSize: font20),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                result.companyName,
                                                style: TextStyle(
                                                    color: ColorBtRegister,
                                                    fontSize: font16,
                                                    fontFamily: 'RSU_light'),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  ElevatedButton(
                                      onPressed: result.packageAllow
                                          ? () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      settings: const RouteSettings(
                                                          name:
                                                              'TNH_AppointmentStep1_Screen'),
                                                      builder: (context) =>
                                                          AppointmentStep1Screen(
                                                              result)));
                                            }
                                          : null,
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
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Image(
                                            image: AssetImage(
                                                'assets/icons/calendar-simple@3x.png'),
                                            height: 17,
                                            width: 17,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            textAlign: TextAlign.center,
                                            'นัดหมายทันที',
                                            style: TextStyle(
                                                fontSize: font18,
                                                color: Colors.white),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          )
                                        ],
                                      )),
                                ],
                              )))),
                ),
              ),
            );
          }
          return const LinearProgressIndicator();
        },
      );

  //render item นัดหมาย ทั้ง 3 เลย
  Widget buildItemTab(
    appointmentData,
    page,
  ) =>
      FutureBuilder(
        future: appointmentData,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var result = [];
            DateTime now = DateTime.now();
            DateTime date = DateTime(now.year, now.month, now.day);
            // status 0 น่าจะกำลังดำเนินการ รอหลังบ้านยืนยัน
            // 1 ยืนยันนัดแล้ว
            // 2 ยกเลิกนัด
            // 3 เลื่อนนัด
            // print(funGetPackage2.resCode == "00");
            if (page == "0") {
              result = snapshot.data
                  .where((i) =>
                      (i.status == "0" || i.status == "1" || i.status == "3") &&
                      DateFormat('yyyy-MM-dd').format(date).compareTo(
                              DateFormat('yyyy-MM-dd').format(i.date)) <=
                          0)
                  .toList();
            } else if (page == "1") {
              result = snapshot.data
                  .where((i) =>
                      i.status == "1" &&
                      DateFormat('yyyy-MM-dd').format(date).compareTo(
                              DateFormat('yyyy-MM-dd').format(i.date)) >
                          0)
                  .toList();
            } else if (page == "2") {
              result = snapshot.data.where((i) => i.status == "2").toList();
            }

            if (result.isEmpty) {
              return tabNotData();
            }

            return ListView.builder(
                itemCount: result.length,
                itemBuilder: (context, index) {
                  ResAppointment item = result[index];
                  return Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 3,
                            blurRadius: 10,
                            offset: const Offset(5, 5),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 10),
                            child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                child: Container(
                                    decoration: appointmentSelect ==
                                            (funGetPackage2.resCode == "00"
                                                ? 1
                                                : 0)
                                        ? const BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/backgroundAppointItem@3x.png'),
                                                fit: BoxFit.cover),
                                          )
                                        : const BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/backgroundAppointItem2@3x.png'),
                                                fit: BoxFit.cover),
                                          ),
                                    width: MediaQuery.of(context).size.width,
                                    height: 150,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 20,
                                                    right: 20,
                                                    top: 20),
                                                child: Row(
                                                  children: [
                                                    Flexible(
                                                        flex: 1,
                                                        fit: FlexFit.tight,
                                                        child: Text(
                                                          'คุณ ${item.name}',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: font20,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                        )),
                                                    Flexible(
                                                        flex: 0,
                                                        fit: FlexFit.tight,
                                                        child: InkWell(
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                'ดูเพิ่มเติม ',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      font18,
                                                                ),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 1,
                                                              ),
                                                              const Image(
                                                                image: AssetImage(
                                                                    'assets/icons/arrow-left-anticon@3x.png'),
                                                                height: 20,
                                                                width: 21,
                                                              ),
                                                            ],
                                                          ),
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    settings: const RouteSettings(
                                                                        name:
                                                                            'TNH_AppointmentCard_Screen'),
                                                                    builder: (context) =>
                                                                        AppointmentCardScreen(
                                                                            item,
                                                                            page)));
                                                          },
                                                        ))
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20,
                                                    right: 20,
                                                    top: 10),
                                                child: Row(
                                                  children: [
                                                    Flexible(
                                                      flex: 1,
                                                      fit: FlexFit.tight,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'วันที่ ',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    font18),
                                                          ),
                                                          Text(
                                                            DateFormat.yMMMd(
                                                                    'th')
                                                                .formatInBuddhistCalendarThai(
                                                                    item.date),
                                                            style: TextStyle(
                                                                color: appointmentSelect ==
                                                                        (funGetPackage2.resCode ==
                                                                                "00"
                                                                            ? 1
                                                                            : 0)
                                                                    ? ColorGreyishTeal
                                                                    : ColorDefaultApp0,
                                                                fontSize:
                                                                    font18),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Flexible(
                                                        flex: 0,
                                                        fit: FlexFit.tight,
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              'เวลา ',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      font18),
                                                            ),
                                                            Text(
                                                              '${item.time.split(':')[0]}:${item.time.split(':')[1]}',
                                                              style: TextStyle(
                                                                  color: appointmentSelect ==
                                                                          (funGetPackage2.resCode == "00"
                                                                              ? 1
                                                                              : 0)
                                                                      ? ColorGreyishTeal
                                                                      : ColorDefaultApp0,
                                                                  fontSize:
                                                                      font18),
                                                            ),
                                                            Text(
                                                              ' น.',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      font18),
                                                            ),
                                                          ],
                                                        ))
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20,
                                                    right: 20,
                                                    top: 10),
                                                child: Row(
                                                  children: [
                                                    Image(
                                                      image: AssetImage(appointmentSelect ==
                                                              (funGetPackage2
                                                                          .resCode ==
                                                                      "00"
                                                                  ? 1
                                                                  : 0)
                                                          ? 'assets/icons/environment-anticon@3x.png'
                                                          : 'assets/icons/environment-anticon-gray@3x.png'),
                                                      height: 13,
                                                      width: 12,
                                                    ),
                                                    Flexible(
                                                        flex: 1,
                                                        fit: FlexFit.tight,
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              item.workplace !=
                                                                      null
                                                                  ? ' ${item.workplace}'
                                                                  : ' -',
                                                              style: TextStyle(
                                                                  color: appointmentSelect ==
                                                                          (funGetPackage2.resCode == "00"
                                                                              ? 1
                                                                              : 0)
                                                                      ? ColorGreyishTeal
                                                                      : ColorDefaultApp0,
                                                                  fontSize:
                                                                      font18),
                                                            )
                                                          ],
                                                        ))
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ))),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 150, left: 20, right: 20),
                            child: Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  ),
                                  color: Colors.white,
                                ),
                                width: double.infinity,
                                height: 100,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            settings: const RouteSettings(
                                                name:
                                                    'TNH_AppointmentCard_Screen'),
                                            builder: (context) =>
                                                AppointmentCardScreen(
                                                    item, page)));
                                  },
                                  child: Row(
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        fit: FlexFit.tight,
                                        child: Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: NetworkImage(item.img),
                                                  onError:
                                                      (error, stackTrace) =>
                                                          print(error),
                                                  fit: BoxFit.cover)),
                                        ),
                                      ),
                                      Flexible(
                                          flex: 3,
                                          fit: FlexFit.tight,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              item.doctorName == 'ไม่ระบุ'
                                                  ? const SizedBox()
                                                  : Row(
                                                      children: [
                                                        Text(
                                                          item.doctorName,
                                                          style: TextStyle(
                                                              color:
                                                                  ColorDefaultApp1,
                                                              fontSize: font18),
                                                        ),
                                                      ],
                                                    ),
                                              Row(
                                                children: [
                                                  Text(
                                                    item.clinicNameth,
                                                    style: TextStyle(
                                                        color: ColorDefaultApp0,
                                                        fontSize: font18),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: item.status == "0"
                                                          ? ColorWait
                                                          : item.status == "1"
                                                              ? ColorBtRegister
                                                              : item.status ==
                                                                      "2"
                                                                  ? ColorCansel
                                                                  : ColorWait,
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5,
                                                              right: 5),
                                                      child: Text(
                                                        item.status == "0"
                                                            ? 'รอดำเนินการ'
                                                            : item.status == "1"
                                                                ? 'ยืนยันการนัด'
                                                                : item.status ==
                                                                        "2"
                                                                    ? 'ยกเลิกนัด'
                                                                    : 'ขอเลื่อนนัด',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: font12),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ))
                                    ],
                                  ),
                                )),
                          ),
                        ],
                      ));
                });
          }
          return const Center(child: SpinKitRing(color: ColorDefaultApp1));
        },
      );

  //render buttom tab
  Widget _getRow(
    int id,
    String titel,
  ) {
    return _wrapScrollTag(
        index: id,
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _nextCounter(counter = id);
                  setState(() {
                    appointmentSelect = id;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      appointmentSelect == id ? ColorBtRegister : Colors.white,
                  shadowColor: ColorDefaultApp1,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  minimumSize: const Size(140, 44),
                ),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      tabTitelList.length == 4 && id == 0
                          ? Image(
                              image: AssetImage(appointmentSelect == id
                                  ? 'assets/images/icon-gift@3x.png'
                                  : 'assets/images/icon-gift-active@3x.png'),
                              height: 17,
                              width: 17,
                            )
                          : const SizedBox(),
                      tabTitelList.length == 4 && id == 0
                          ? const SizedBox(
                              width: 5,
                            )
                          : const SizedBox(),
                      Text(
                        titel,
                        style: TextStyle(
                            fontSize: font18,
                            color: appointmentSelect == id
                                ? Colors.white
                                : ColorBtRegister),
                      ),
                    ]),
              ),
            ],
          ),
        ));
  }

  //fuc srcoll auto
  Widget _wrapScrollTag({required int index, required Widget child}) =>
      AutoScrollTag(
        key: ValueKey(index),
        controller: controller,
        index: index,
        child: child,
      );
}
