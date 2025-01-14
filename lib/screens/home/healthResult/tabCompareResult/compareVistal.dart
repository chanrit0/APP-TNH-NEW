import 'package:app_tnh2/helper/checkDate.dart';
import 'package:app_tnh2/model/healthResult/modelHealthReportDetail.dart';
import 'package:app_tnh2/model/tabBarModel.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:app_tnh2/widgets/stateScreenDetails.dart';
import 'package:app_tnh2/widgets/tabMenuScroll.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CompareTableScreen extends StatefulWidget {
  final List<Vitalsign>? item;
  const CompareTableScreen({super.key, required this.item});

  @override
  State<CompareTableScreen> createState() => _CompareTableScreenState();
}

class _CompareTableScreenState extends State<CompareTableScreen> {
  static int tabGraphSelect = 0; //ค่าเวลาเลือกแต่ละ tab
  static int selectTableOrGraph = 0; //เลือกตารางหรือกราฟ

  List<SalesData> chartData0 = []; //ตัวแปลกราฟน้ำหนัก
  List<SalesData> chartData1 = []; //ตัวแปลกราฟส่วนสูง
  List<SalesData> chartData2 = []; //ตัวแปลกราฟอัตร่ชีพจร
  List<SalesData> chartData3_1 = []; //ตัวแปลกราฟความดันโลกิตบน
  List<SalesData> chartData3_2 = []; //ตัวแปลกราฟกดันโลกิตล่าง
  List<SalesData> chartData4 = []; //ตัวแปลกราฟอุณหภูมิ
  List<SalesData> chartData5 = []; //ตัวแปลกราฟดัชนีมวลกาย
  List<SalesData> chartData6 = []; //ตัวแปลกราฟอัตราการหายใจ
  //การเพิ่มข้อมูลเข้ากราฟแต่ละตัว

  void loadSalesData0() {
    widget.item?.forEach((item) {
      chartData0.add(SalesData(
          '${item.visitdate.day}\n${CheckDate.mounth(item.visitdate.month)}\n${CheckDate.year(item.visitdate.year)}',
          double.parse('${item.bodyWeight}')));
      chartData1.add(SalesData(
          '${item.visitdate.day}\n${CheckDate.mounth(item.visitdate.month)}\n${CheckDate.year(item.visitdate.year)}',
          double.parse('${item.height}')));
      chartData2.add(SalesData(
          '${item.visitdate.day}\n${CheckDate.mounth(item.visitdate.month)}\n${CheckDate.year(item.visitdate.year)}',
          double.parse('${item.pulseRate}')));
      chartData3_1.add(
        SalesData(
            '${item.visitdate.day}\n${CheckDate.mounth(item.visitdate.month)}\n${CheckDate.year(item.visitdate.year)}',
            double.parse('${item.highpulserate}')),
      );
      chartData3_2.add(SalesData(
          '${item.visitdate.day}\n${CheckDate.mounth(item.visitdate.month)}\n${CheckDate.year(item.visitdate.year)}',
          double.parse('${item.lowpulserate}')));
      chartData4.add(SalesData(
          '${item.visitdate.day}\n${CheckDate.mounth(item.visitdate.month)}\n${CheckDate.year(item.visitdate.year)}',
          double.parse('${item.temperature}')));
      chartData5.add(SalesData(
          '${item.visitdate.day}\n${CheckDate.mounth(item.visitdate.month)}\n${CheckDate.year(item.visitdate.year)}',
          double.parse('${item.bmiValue}')));
      chartData6.add(SalesData(
          '${item.visitdate.day}\n${CheckDate.mounth(item.visitdate.month)}\n${CheckDate.year(item.visitdate.year)}',
          double.parse('${item.respirationRate}')));
    });
  }

//กรณีเลือก tab
  switchCaseTab(selectTab) {
    switch (selectTab) {
      case 0:
        return chartData0;
      case 1:
        return chartData1;
      case 2:
        return chartData2;
      case 3:
        return chartData3_1;
      case 4:
        return chartData4;
      case 5:
        return chartData5;
      case 6:
        return chartData6;
    }
  }

  //กรณีเลือก tab แล้วส่งหัวข้อไปให้
  switchCaseTabName(selectTab) {
    switch (selectTab) {
      case 0:
        return ['น้ำหนัก'];
      case 1:
        return ['ส่วนสูง'];
      case 2:
        return ['อัตราชีพจร'];
      case 3:
        return ['Systolic (ค่าความดันตัวบน)', 'Diastolic (ค่าความดันตัวล่าง)'];
      case 4:
        return ['อุณหภมิ'];
      case 5:
        return ['ดัชนีมวลกาย'];
      case 6:
        return ['อัตราการหายใจ'];
    }
  }

  //กรณีเลือก tab แล้วส่งค่าปกติไปใช่
  switchCaseTabSubName(selectTab) {
    switch (selectTab) {
      case 0:
        return '';
      case 1:
        return '';
      case 2:
        return '60-120 / นาที';
      case 3:
        return '130-110 / 90-60';
      case 4:
        return '36.0 - 37.5';
      case 5:
        return '18.6 - 24.9';
      case 6:
        return '16 - 20 / นาที';
    }
  }

  //กรณีเลือก tab แล้วส่งค่าล่าสุดข้อ tab ไปใช้
  switchCaseTabDataLatest(selectTab) {
    switch (selectTab) {
      case 0:
        return chartData0[0].datay;
      case 1:
        return chartData1[0].datay;
      case 2:
        return chartData2[0].datay.toInt();
      case 3:
        return chartData3_1[0].datay.toInt();
      case 4:
        return chartData4[0].datay;
      case 5:
        return chartData5[0].datay;
      case 6:
        return chartData6[0].datay;
    }
  }

  //กรณีเลือก tab แล้วส่งค่าหน่วยไปใช่
  switchCaseTabDataUnit(selectTab) {
    switch (selectTab) {
      case 0:
        return 'กก.';
      case 1:
        return 'ซม.';
      case 2:
        return '/ นาที';
      case 3:
        return '';
      case 4:
        return '°C';
      case 5:
        return '';
      case 6:
        return '';
    }
  }

  //tab Graph
  List<TabBarModel> tabTitelListVital = getTabVital();
  static List<TabBarModel> getTabVital() {
    const data = [
      {"id": 0, "titel": "น้ำหนัก"},
      {"id": 1, "titel": "ส่วนสูง"},
      {"id": 2, "titel": "อัตราชีพจร"},
      {"id": 3, "titel": "ความดันโลหิต"},
      {"id": 4, "titel": "อุณหภูมิ"},
      {"id": 5, "titel": "ดัชนีมวลกาย"},
      {"id": 6, "titel": "อัตราการหายใจ"}
    ];

    return data.map<TabBarModel>(TabBarModel.fromJson).toList();
  }

  final scrollDirection = Axis.horizontal; //scroll แนวนอน
  int counter = 0; //ค่านับจำนวน scroll
  Future _scrollToCounter() async {
    await controller.scrollToIndex(counter,
        preferPosition: AutoScrollPosition.middle);
    controller.highlight(counter);
  }

  late AutoScrollController controller;
  Future _nextCounter(counter) {
    setState(() => counter = counter);
    return _scrollToCounter();
  }

  /////////////////////////////////////

  void onOrientationChange() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  initState() {
    super.initState();
    controller = AutoScrollController(axis: scrollDirection);
    loadSalesData0();
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
                          onOrientationChange();
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
                        'เปรียบเทียบผลตรวจ Vital Sign',
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
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            child: SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Text(
                              'ผลตรวจล่าสุด : ',
                              style: TextStyle(
                                  color: ColorDefaultApp0, fontSize: font18),
                            ),
                            Expanded(
                              child: Text(
                                '${widget.item?[0].visitdate.day} ${CheckDate.mounth(widget.item?[0].visitdate.month)} ${CheckDate.year(widget.item?[0].visitdate.year)}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    color: ColorDefaultApp1, fontSize: font18),
                              ),
                            )
                          ],
                        ),
                      )),
                  Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectTableOrGraph = 0;
                                });
                              },
                              child: Image(
                                image: AssetImage(selectTableOrGraph == 0
                                    ? 'assets/icons/tabelNavigitor@3x.png'
                                    : 'assets/icons/tableDis@3x.png'),
                                height: 30,
                                width: 30,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectTableOrGraph = 1;
                                });
                              },
                              child: Image(
                                image: AssetImage(selectTableOrGraph == 1
                                    ? 'assets/icons/graph@3x.png'
                                    : 'assets/icons/graphNavigator@3x.png'),
                                height: 30,
                                width: 30,
                              ),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
          selectTableOrGraph == 1
              ? SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    scrollDirection: scrollDirection,
                    controller: controller,
                    children: tabTitelListVital.map<Widget>((item) {
                      return _getRow(item.id, item.titel);
                    }).toList(),
                  ),
                )
              : const SizedBox(),
          const SizedBox(
            height: 10,
          ),
          Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                    child: switcTableOrGraph(selectTableOrGraph)),
              )),
        ],
      )),
    );
  }

  //กรณีเลือก tab หรือ graph
  switcTableOrGraph(
    select,
  ) {
    switch (select) {
      case 0:
        return table();
      case 1:
        return graph();
    }
  }

  Row table() {
    final fullScreenWidth = MediaQuery.of(context).size.width;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Row(
                    children: [
                      Container(
                          decoration: const BoxDecoration(
                            color: ColorBtRegister,
                          ),
                          width: fullScreenWidth > 600 ? 250 : 150,
                          height: 110,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20, left: 15),
                            child: Text(
                              textAlign: TextAlign.left,
                              'Check up No. ',
                              style: TextStyle(
                                  color: Colors.white, fontSize: font24),
                            ),
                          )),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(blurRadius: 3.0),
                          BoxShadow(color: Colors.white, offset: Offset(10, 0)),
                          BoxShadow(
                              color: Colors.white, offset: Offset(-10, 0)),
                        ],
                      ),
                      width: fullScreenWidth > 600 ? 250 : 150,
                      height: 50,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: InkWell(
                              onTap: () {
                                onOrientationChange();
                              },
                              child: const Image(
                                image:
                                    AssetImage('assets/icons/tableIcon@3x.png'),
                                height: 30,
                                width: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
                children: tabTitelListVital.map((i) {
              return Container(
                  decoration: const BoxDecoration(
                    color: ColorBtRegister,
                  ),
                  width: fullScreenWidth > 600 ? 250 : 150,
                  height: fullScreenWidth > 600 ? 120 : 110,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              i.titel,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.white, fontSize: font24),
                            ),
                          )
                        ],
                      ),
                    ],
                  ));
            }).toList())
          ],
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Row(
                        children: widget.item!.map<Widget>((i) {
                          return Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                    right: BorderSide(
                                  color: ColorDivider,
                                  width: 2,
                                )),
                              ),
                              width: fullScreenWidth > 600 ? 250 : 180,
                              height: fullScreenWidth > 600 ? 120 : 110,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    textAlign: TextAlign.center,
                                    '${i.requestNo}',
                                    style: TextStyle(
                                        color: ColorDefaultApp0,
                                        fontSize: font24),
                                  ),
                                ],
                              ));
                        }).toList(),
                      ),
                    ),
                    Row(
                      children: widget.item!.map<Widget>((i) {
                        return Container(
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  right: BorderSide(
                                color: ColorDivider,
                                width: 2,
                              )),
                              boxShadow: [
                                BoxShadow(blurRadius: 3.0),
                                BoxShadow(
                                    color: Colors.white, offset: Offset(10, 0)),
                                BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(-10, 0)),
                              ],
                            ),
                            width: fullScreenWidth > 600 ? 250 : 180,
                            height: 50,
                            child: Text(
                              '${i.visitdate.day} ${CheckDate.mounth(i.visitdate.month)} ${CheckDate.year(i.visitdate.year)}',
                              style: TextStyle(
                                  color: ColorDefaultApp1, fontSize: font20),
                            ));
                      }).toList(),
                    ),
                  ],
                ),
                //ตัวแปลกราฟน้ำหนัก
                Row(
                  children: widget.item!.map<Widget>((i) {
                    return Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              right: BorderSide(
                            color: ColorDivider,
                            width: 2,
                          )),
                        ),
                        width: fullScreenWidth > 600 ? 250 : 180,
                        height: fullScreenWidth > 600 ? 120 : 110,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              '${i.bodyWeight} ${switchCaseTabDataUnit(0)}',
                              style: TextStyle(
                                  color: ColorDefaultApp0, fontSize: font24),
                            ),
                          ],
                        ));
                  }).toList(),
                ),
                //ตัวแปลกราฟส่วนสูง
                Row(
                  children: widget.item!.map<Widget>((i) {
                    return Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              right: BorderSide(
                            color: ColorDivider,
                            width: 2,
                          )),
                        ),
                        width: fullScreenWidth > 600 ? 250 : 180,
                        height: fullScreenWidth > 600 ? 120 : 110,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              '${i.height} ${switchCaseTabDataUnit(1)}',
                              style: TextStyle(
                                  color: ColorDefaultApp0, fontSize: font24),
                            ),
                          ],
                        ));
                  }).toList(),
                ),
                //ตัวแปลกราฟอัตร่ชีพจร
                Row(
                  children: widget.item!.map<Widget>((i) {
                    return Container(
                        alignment: Alignment.center,
                        width: fullScreenWidth > 600 ? 250 : 180,
                        height: fullScreenWidth > 600 ? 120 : 110,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                right: BorderSide(
                              color: ColorDivider,
                              width: 2,
                            ))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                textAlign: TextAlign.center,
                                '${i.pulseRate.toInt()} ${switchCaseTabDataUnit(2)}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    color: double.parse('${i.pulseRate}') >
                                                120 ||
                                            double.parse('${i.pulseRate}') < 60
                                        ? ColorOreng
                                        : ColorDefaultApp0,
                                    fontSize: font24),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                textAlign: TextAlign.center,
                                'ค่าปกติ ${switchCaseTabSubName(2)}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    color: ColorDefaultApp0,
                                    fontSize: font14,
                                    fontFamily: 'RSU_light'),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ));
                  }).toList(),
                ),
                //ตัวแปลกราฟความดันโลหิต
                Row(
                  children: widget.item!.map<Widget>((i) {
                    return Container(
                        alignment: Alignment.center,
                        width: fullScreenWidth > 600 ? 250 : 180,
                        height: fullScreenWidth > 600 ? 120 : 110,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                right: BorderSide(
                              color: ColorDivider,
                              width: 2,
                            ))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                textAlign: TextAlign.center,
                                '${i.highpulserate?.toInt()} / ${i.lowpulserate?.toInt()}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    color: double.parse('${i.highpulserate}') >
                                                130 ||
                                            double.parse('${i.highpulserate}') <
                                                110 ||
                                            double.parse('${i.lowpulserate}') >
                                                90 ||
                                            double.parse('${i.lowpulserate}') <
                                                60
                                        ? ColorOreng
                                        : ColorBtRegister,
                                    fontSize: font24),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                textAlign: TextAlign.center,
                                'ค่าปกติ ${switchCaseTabSubName(3)}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    color: ColorDefaultApp0,
                                    fontSize: font14,
                                    fontFamily: 'RSU_light'),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ));
                  }).toList(),
                ),
                //ตัวแปลกราฟอุณหภูมิ
                Row(
                  children: widget.item!.map<Widget>((i) {
                    return Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              right: BorderSide(
                            color: ColorDivider,
                            width: 2,
                          )),
                        ),
                        width: fullScreenWidth > 600 ? 250 : 180,
                        height: fullScreenWidth > 600 ? 120 : 110,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              '${i.temperature}',
                              style: TextStyle(
                                  color:
                                      double.parse('${i.temperature}') > 37.5 ||
                                              double.parse('${i.temperature}') <
                                                  36.0
                                          ? ColorOreng
                                          : ColorDefaultApp0,
                                  fontSize: font24),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                textAlign: TextAlign.center,
                                'ค่าปกติ ${switchCaseTabSubName(4)}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    color: ColorDefaultApp0,
                                    fontSize: font14,
                                    fontFamily: 'RSU_light'),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ));
                  }).toList(),
                ),
                //ตัวแปลกราฟดัชนีมวลกาย
                Row(
                  children: widget.item!.map<Widget>((i) {
                    return Container(
                        alignment: Alignment.center,
                        width: fullScreenWidth > 600 ? 250 : 180,
                        height: fullScreenWidth > 600 ? 120 : 110,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                right: BorderSide(
                              color: ColorDivider,
                              width: 2,
                            ))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                textAlign: TextAlign.center,
                                '${i.bmiValue} ${switchCaseTabDataUnit(5)}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    color: double.parse('${i.bmiValue}') >
                                                24.9 ||
                                            double.parse('${i.bmiValue}') < 18.6
                                        ? ColorOreng
                                        : ColorDefaultApp0,
                                    fontSize: font24),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                textAlign: TextAlign.center,
                                'ค่าปกติ ${switchCaseTabSubName(5)}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    color: ColorDefaultApp0,
                                    fontSize: font14,
                                    fontFamily: 'RSU_light'),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ));
                  }).toList(),
                ),
                //ตัวแปลกราฟอัตราการหายใจ
                Row(
                  children: widget.item!.map<Widget>((i) {
                    return Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              right: BorderSide(
                            color: ColorDivider,
                            width: 2,
                          )),
                        ),
                        width: fullScreenWidth > 600 ? 250 : 180,
                        height: fullScreenWidth > 600 ? 120 : 110,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              '${i.respirationRate}',
                              style: TextStyle(
                                  color: double.parse('${i.respirationRate}') >
                                              20 ||
                                          double.parse('${i.respirationRate}') <
                                              16
                                      ? ColorOreng
                                      : ColorDefaultApp0,
                                  fontSize: font24),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                textAlign: TextAlign.center,
                                'ค่าปกติ ${switchCaseTabSubName(6)}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    color: ColorDefaultApp0,
                                    fontSize: font14,
                                    fontFamily: 'RSU_light'),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ));
                  }).toList(),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Container graph() {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color(0xff29989b),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ค่าปกติ',
                    style: TextStyle(color: Colors.white, fontSize: font14),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: const Color(0xffc6f243),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${switchCaseTabName(tabGraphSelect)[0]}  ',
                        style: TextStyle(color: Colors.white, fontSize: font14),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    switchCaseTabSubName(tabGraphSelect),
                    style: TextStyle(color: Colors.white, fontSize: font14),
                  ),
                  tabGraphSelect == 3
                      ? Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: const Color(0xff4ef7f4),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              switchCaseTabName(tabGraphSelect)[1],
                              style: TextStyle(
                                  color: Colors.white, fontSize: font14),
                            ),
                          ],
                        )
                      : Container()
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage(
                          'assets/images/backgroundListNoti2@3x.png'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${widget.item?[0].visitdate.day} ${CheckDate.mounth(widget.item?[0].visitdate.month)} ${CheckDate.year(widget.item?[0].visitdate.year)} : ',
                      style:
                          TextStyle(color: ColorDefaultApp0, fontSize: font24),
                    ),
                    Text(
                      '${switchCaseTabDataLatest(tabGraphSelect)} ${tabGraphSelect == 3 ? '/ ${chartData3_2[0].datay.toInt()}' : ''}',
                      style:
                          TextStyle(color: ColorDefaultApp1, fontSize: font24),
                    ),
                    Text(
                      '${switchCaseTabDataUnit(tabGraphSelect)}',
                      style:
                          TextStyle(color: ColorDefaultApp0, fontSize: font24),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: SfCartesianChart(
                  plotAreaBorderWidth: 0,
                  primaryXAxis: CategoryAxis(
                      majorGridLines: const MajorGridLines(width: 0),
                      majorTickLines: const MajorTickLines(size: 0),
                      axisLine: const AxisLine(width: 0.0),
                      plotOffset: 20,
                      isInversed: true,
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: font14,
                      )),
                  primaryYAxis: NumericAxis(
                      majorTickLines: const MajorTickLines(size: 0),
                      // minimum: 0,
                      // maximum: 100,
                      majorGridLines: const MajorGridLines(width: 1),
                      // interval: 10,
                      axisLine: const AxisLine(width: 0),
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: font14,
                      )),
                  palette: const <Color>[Color(0xffc6f243), Color(0xff4ef7f4)],
                  series: tabGraphSelect == 3
                      ? [
                          FastLineSeries<SalesData, String>(
                            width: 5,
                            dataLabelSettings: DataLabelSettings(
                              textStyle: TextStyle(
                                  color: ColorDefaultApp1, fontSize: font16),
                              color: Colors.white,
                              isVisible: true,
                            ),
                            markerSettings: const MarkerSettings(
                                isVisible: true, width: 10, height: 10),
                            dataSource: chartData3_1,
                            xValueMapper: (SalesData data, _) => data.month,
                            yValueMapper: (SalesData data, _) => data.datay,
                          ),
                          FastLineSeries<SalesData, String>(
                            width: 5,
                            dataLabelSettings: DataLabelSettings(
                              textStyle: TextStyle(
                                  color: ColorDefaultApp1, fontSize: font16),
                              color: Colors.white,
                              isVisible: true,
                            ),
                            markerSettings: const MarkerSettings(
                                isVisible: true, width: 10, height: 10),
                            dataSource: chartData3_2,
                            xValueMapper: (SalesData data, _) => data.month,
                            yValueMapper: (SalesData data, _) => data.datay,
                          )
                        ]
                      : [
                          FastLineSeries<SalesData, String>(
                            width: 5,
                            dataLabelSettings: DataLabelSettings(
                              textStyle: TextStyle(
                                  color: ColorDefaultApp1, fontSize: font16),
                              color: Colors.white,
                              isVisible: true,
                            ),
                            markerSettings: const MarkerSettings(
                                isVisible: true, width: 10, height: 10),
                            dataSource: switchCaseTab(tabGraphSelect),
                            xValueMapper: (SalesData data, _) => data.month,
                            yValueMapper: (SalesData data, _) => data.datay,
                          ),
                        ]),
            )
          ],
        ));
  }

  //render tab ล่าง
  Widget _getRow(int id, String titel) {
    void nextCounter() {
      _nextCounter(counter = id);
      setState(() {
        tabGraphSelect = id;
      });
    }

    return TabMenuScroll(
        controller: controller,
        id: id,
        titel: titel,
        tabSelect: tabGraphSelect,
        nextCounter: nextCounter,
        counter: counter);
  }
}

//model graph
class SalesData {
  SalesData(this.month, this.datay);

  final String month;
  final double datay;
}
