import 'package:app_tnh2/controller/api.dart';
import 'package:app_tnh2/helper/checkDate.dart';
import 'package:app_tnh2/model/healthResult/modelHealthReport.dart';
import 'package:app_tnh2/model/tabBarModel.dart';
import 'package:app_tnh2/screens/home/healthResult/tabHealthLatest/tabHealthResult0.dart';
import 'package:app_tnh2/screens/home/healthResult/widget/compareResults.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:app_tnh2/widgets/stateScreenDetails.dart';
import 'package:app_tnh2/widgets/tabMenuScroll.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:app_tnh2/screens/stores/authStore.dart';
import 'package:app_tnh2/config/keyStorages.dart';

class HealthResultScreen extends StatefulWidget {
  const HealthResultScreen({super.key});

  @override
  State<HealthResultScreen> createState() => _HealthResultScreenState();
}

class _HealthResultScreenState extends State<HealthResultScreen> {
  int tabSelect = 0; //ค่าเวลาเลือกแต่ละ tab
  bool isLoading = false; //โหลดหน้า

  //////////////////////tab<-----------------
  List<TabBarModel> tabTitelList = getTabTite();
  int counter = 0;
  final scrollDirection = Axis.horizontal;
  late Service postService;
  late AutoScrollController controller;
  String hnTemp = '';
  String hnName = '';
  dynamic funGetHealthReport = '';
  dynamic funGetHealthReportHis = '';
  dynamic funGetHealthReportDetail2 = '';
  static List<TabBarModel> getTabTite() {
    const data = [
      {"id": 0, "titel": "ผลตรวจล่าสุด"},
      {"id": 1, "titel": "ผลตรวจย้อนหลัง"},
      {"id": 2, "titel": "เปรียบเทียบผลตรวจ"},
    ];

    return data.map<TabBarModel>(TabBarModel.fromJson).toList();
  }

  Future _nextCounter(counter) {
    setState(() => counter = counter);
    return _scrollToCounter();
  }

  Future _scrollToCounter() async {
    await controller.scrollToIndex(counter,
        preferPosition: AutoScrollPosition.middle);
    controller.highlight(counter);
  }

  dynamic GetHealthReportArray = '';
  var requestNoArray = [];
  var visitDateArray = [];
  var vnArray = [];

  Future loadName() async {
    hnTemp = await accessTokenStore(key: KeyStorages.profileHn);
    getValue(hnTemp);
    funGetHealthReport = postService.funHealthReport('1', hnTemp);
    funGetHealthReportHis = postService.funHealthReport('2', hnTemp);
    GetHealthReportArray = await funGetHealthReportHis;
    for (var i = 0; i < GetHealthReportArray.resData.length; i++) {
      requestNoArray.add(GetHealthReportArray.resData[i].requestNo);
      String? month = '';
      String? dayt = '';
      if (GetHealthReportArray.resData[i].visitDate?.month < 10) {
        month = '0${GetHealthReportArray.resData[i].visitDate?.month}';
      } else {
        month = GetHealthReportArray.resData[i].visitDate?.month.toString();
      }
      if (GetHealthReportArray.resData[i].visitDate?.day < 10) {
        dayt = '0${GetHealthReportArray.resData[i].visitDate?.day}';
      } else {
        dayt = GetHealthReportArray.resData[i].visitDate?.day.toString();
      }
      String dt =
          '${GetHealthReportArray.resData[i].visitDate?.year}-$month-$dayt';
      visitDateArray.add('${dt}T00:00:00');
      vnArray.add(GetHealthReportArray.resData[i].vn);
    }
    funGetHealthReportDetail2 = postService.funHealthReportDetail(
      requestNoArray.join(','),
      visitDateArray.join(','),
      vnArray.join(','),
    );
    setState(() {
      hnName = hnTemp;
    });
  }
  /////////////////////--------------------->

  final requestNo = [];
  final variDate = [];
  final vn = [];
  void getValue(hnTemp) async {
    postService
        .funHealthReport('2', hnTemp)
        .then((value) => value?.resData.forEach((element) {
              requestNo.add(element.requestNo);
              variDate.add(element.visitDate);
              vn.add(element.vn);
            }));
  }

  //กรณีเลือก tab
  switchCaseTab(
    selectTab,
    ModelHealthReport? item,
  ) {
    switch (selectTab) {
      case 0:
        return buildItemTab(item!.resData);
      case 1:
        return buildItemTab(item!.resData);
      case 2:
        return buildItemTab3(item!.resData);
    }
  }

  @override
  initState() {
    super.initState();
    controller = AutoScrollController(axis: scrollDirection);
    postService = Service(context: context);
    loadName();
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
                          Navigator.pop(context);
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
                        'ดูผลตรวจสุขภาพ',
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
          SizedBox(
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
          funGetHealthReport != ''
              ? Flexible(
                  flex: 5,
                  fit: FlexFit.tight,
                  child: Container(
                    child: resultLatestFutureBuilder(),
                  ))
              : const Flexible(
                  flex: 5,
                  fit: FlexFit.tight,
                  child: Center(child: SpinKitRing(color: ColorDefaultApp1)))
        ],
      )),
    );
  }

  //render item tab 1 กับ 2
  Widget buildItemTab(
    List<ResHealthReport> data,
  ) =>
      ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final item = data[index];
            if (tabSelect == 1 && index == 0) {
              return const SizedBox();
            }
            final fullScreenWidth = MediaQuery.of(context).size.width;
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      child: Container(
                          decoration: tabSelect == 1
                              ? const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/backgroundAppointItem2@3x.png'),
                                      fit: BoxFit.cover),
                                )
                              : const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/backgroundAppointItem@3x.png'),
                                      fit: BoxFit.cover),
                                ),
                          width: MediaQuery.of(context).size.width,
                          height: fullScreenWidth > 600
                              ? 130.h
                              : fullScreenWidth < 330
                                  ? 150
                                  : 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: fullScreenWidth > 600
                                              ? 20.h
                                              : 20),
                                      child: Row(
                                        children: [
                                          Flexible(
                                              flex: 2,
                                              fit: FlexFit.tight,
                                              child: Text(
                                                'คุณ ${item.name}',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: font20,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              )),
                                          Flexible(
                                            flex: 0,
                                            fit: FlexFit.tight,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    settings: const RouteSettings(
                                                        name:
                                                            'TNH_TabHealthResult_Screen'),
                                                    builder: (context) =>
                                                        TabHealthResult0(
                                                      item: item,
                                                      img: tabSelect == 1
                                                          ? 'assets/images/backgroundAppointItem2@3x.png'
                                                          : 'assets/images/backgroundAppointItem@3x.png',
                                                      tab: tabSelect,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'ดูเพิ่มเติม ',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: font18,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: fullScreenWidth < 330 ? 0 : 10),
                                      child: Container(
                                        child: fullScreenWidth < 330
                                            ? Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'วันที่ ',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: font18),
                                                      ),
                                                      Text(
                                                        '${item.visitDate.day} ${CheckDate.mounth(item.visitDate.month)} ${CheckDate.year(item.visitDate.year)}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            color: tabSelect ==
                                                                    0
                                                                ? ColorGreyishTeal
                                                                : ColorDefaultApp0,
                                                            fontSize: font18),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'เวลา ',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: font18),
                                                      ),
                                                      Text(
                                                        '${item.time!.split(':')[0]}:${item.time!.split(':')[1]}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            color: tabSelect ==
                                                                    0
                                                                ? ColorGreyishTeal
                                                                : ColorDefaultApp0,
                                                            fontSize: font18),
                                                      ),
                                                      Text(
                                                        ' น.',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: font18),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              )
                                            : Row(
                                                children: [
                                                  Flexible(
                                                    flex: 1,
                                                    fit: FlexFit.tight,
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'วันที่ ',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: font18),
                                                        ),
                                                        Text(
                                                          '${item.visitDate.day} ${CheckDate.mounth(item.visitDate.month)} ${CheckDate.year(item.visitDate.year)}',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              color: tabSelect ==
                                                                      0
                                                                  ? ColorGreyishTeal
                                                                  : ColorDefaultApp0,
                                                              fontSize: font18),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Flexible(
                                                      flex: 0,
                                                      fit: FlexFit.tight,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
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
                                                            '${item.time!.split(':')[0]}:${item.time!.split(':')[1]}',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                                color: tabSelect ==
                                                                        0
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
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: fullScreenWidth < 330 ? 0 : 10),
                                      child: Row(
                                        children: [
                                          Text(
                                            item.docterName == null ||
                                                    item.docterName == 'ไม่ระบุ'
                                                ? 'ศูนย์ตรวจสุขภาพ'
                                                : '${item.docterName}',
                                            style: TextStyle(
                                                color: tabSelect == 0
                                                    ? ColorGreyishTeal
                                                    : ColorDefaultApp0,
                                                fontSize: font18),
                                          )
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
                  padding: EdgeInsets.only(
                      top: fullScreenWidth > 600
                          ? 130.h
                          : fullScreenWidth < 330
                              ? 150
                              : 130,
                      left: 20,
                      right: 20,
                      bottom: 10),
                  child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                        color: Colors.white,
                      ),
                      width: double.infinity,
                      height: fullScreenWidth < 330 ? 240 : 200,
                      child: Column(
                        children: [
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'สถานะผลตรวจ',
                                        style: TextStyle(
                                            color: ColorDefaultApp0,
                                            fontSize: font18),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${item.requestDoctor}',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: font14),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                      child: fullScreenWidth < 330
                                          ? Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Check up No. : ${item.requestNo}',
                                                      style: TextStyle(
                                                          color:
                                                              ColorDefaultApp1,
                                                          fontSize: font18),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'VN : ${item.vn}',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          color:
                                                              ColorDefaultApp1,
                                                          fontSize: font18),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  fit: FlexFit.tight,
                                                  flex: 2,
                                                  child: Text(
                                                    'Check up No. : ${item.requestNo}',
                                                    style: TextStyle(
                                                        color: ColorDefaultApp1,
                                                        fontSize: font18),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                                Flexible(
                                                  fit: FlexFit.tight,
                                                  flex: 1,
                                                  child: Text(
                                                    'VN : ${item.vn}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        color: ColorDefaultApp1,
                                                        fontSize: font18),
                                                  ),
                                                ),
                                              ],
                                            ))
                                ],
                              ),
                            ),
                          ),
                          const Divider(
                            color: ColorDivider,
                            thickness: 1,
                            endIndent: 0,
                          ),
                          Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 0, right: 0, top: 9),
                                child: Column(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 30, right: 30, top: 0),
                                        child: Row(
                                          children: [
                                            Column(
                                              children: [
                                                Image(
                                                  image: AssetImage(item
                                                              .vitalsignStatus ==
                                                          1
                                                      ? 'assets/icons/statusHealth1@3x.png'
                                                      : 'assets/icons/statusHealth2@3x.png'),
                                                  height: 40,
                                                  width: 40,
                                                )
                                              ],
                                            ),
                                            Flexible(
                                              flex: 1,
                                              fit: FlexFit.tight,
                                              child: Container(
                                                width: 50,
                                                height: 1,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color:
                                                            ColorDefaultApp1)),
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Image(
                                                  image: AssetImage(item
                                                              .labStatus ==
                                                          1
                                                      ? 'assets/icons/statusHealth1@3x.png'
                                                      : 'assets/icons/statusHealth2@3x.png'),
                                                  height: 40,
                                                  width: 40,
                                                )
                                              ],
                                            ),
                                            Flexible(
                                              flex: 1,
                                              fit: FlexFit.tight,
                                              child: Container(
                                                width: 50,
                                                height: 1,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color:
                                                            ColorDefaultApp1)),
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Image(
                                                  image: AssetImage(item
                                                              .xrayStatus ==
                                                          1
                                                      ? 'assets/icons/statusHealth1@3x.png'
                                                      : 'assets/icons/statusHealth2@3x.png'),
                                                  height: 40,
                                                  width: 40,
                                                )
                                              ],
                                            ),
                                            Flexible(
                                              flex: 1,
                                              fit: FlexFit.tight,
                                              child: Container(
                                                width: 50,
                                                height: 1,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color:
                                                            ColorDefaultApp1)),
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Image(
                                                  image: AssetImage(item
                                                              .summaryStatus ==
                                                          1
                                                      ? 'assets/icons/statusHealth1@3x.png'
                                                      : 'assets/icons/statusHealth2@3x.png'),
                                                  height: 40,
                                                  width: 40,
                                                )
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20, top: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                'Vital Sign',
                                                style: TextStyle(
                                                    fontSize: font16,
                                                    color: ColorBtRegister),
                                              )
                                            ],
                                          ),
                                          Flexible(
                                            flex: 1,
                                            fit: FlexFit.tight,
                                            child: Container(),
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                'ผล Lab',
                                                style: TextStyle(
                                                    fontSize: font16,
                                                    color: ColorBtRegister),
                                              )
                                            ],
                                          ),
                                          Flexible(
                                            flex: 1,
                                            fit: FlexFit.tight,
                                            child: Container(),
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                'ผล X-ray',
                                                style: TextStyle(
                                                    fontSize: font16,
                                                    color: ColorBtRegister),
                                              )
                                            ],
                                          ),
                                          Flexible(
                                            flex: 1,
                                            fit: FlexFit.tight,
                                            child: Container(),
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                'แพทย์สรุปผล',
                                                style: TextStyle(
                                                    fontSize: font16,
                                                    color: ColorBtRegister),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ],
                      )),
                ),
              ],
            );
          });

  //render item tab 3
  Widget buildItemTab3(
    List<ResHealthReport> data,
  ) {
    return FutureBuilder(
      future: funGetHealthReportDetail2,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: SpinKitRing(color: ColorDefaultApp1));
        } else {
          var item = snapshot.data;
          if (item == null) {
            return tabNotData();
          } else {
            return CompareResults(
              item: item,
            );
          }
        }
      },
    );
  }

  //render buttom tab
  Widget _getRow(int id, String titel) {
    void nextCounter() {
      _nextCounter(counter = id);
      setState(() {
        tabSelect = id;
      });
    }

    return TabMenuScroll(
        controller: controller,
        id: id,
        titel: titel,
        tabSelect: tabSelect,
        nextCounter: nextCounter,
        counter: counter);
  }

  FutureBuilder<dynamic> resultLatestFutureBuilder() {
    return FutureBuilder(
      future: tabSelect == 0 ? funGetHealthReport : funGetHealthReportHis,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: SpinKitRing(color: ColorDefaultApp1));
        } else {
          var result = snapshot.data;
          if (result.resData.length == 0) {
            return tabNotData();
          }
          return Container(child: switchCaseTab(tabSelect, result));
        }
      },
    );
  }

  //tab ไม่มีข้อมูล
  Column tabNotData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Image(
          image: AssetImage('assets/images/nocheckup@3x.png'),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'ท่านไม่มีผลตรวจสุขภาพ',
          style: TextStyle(color: Colors.grey, fontSize: font20),
        )
      ],
    );
  }
}
