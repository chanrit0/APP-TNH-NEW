import 'package:app_tnh2/helper/checkDate.dart';
import 'package:app_tnh2/model/healthResult/modelHealthReportDetail.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:app_tnh2/widgets/stateScreenDetails.dart';
import 'package:app_tnh2/widgets/tabMenuScroll.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import "package:collection/collection.dart";
import 'package:syncfusion_flutter_charts/charts.dart';

class CompareTableLabScreen extends StatefulWidget {
  final List<Lab>? data;
  final List<Vitalsign>? dataVitalsign;
  const CompareTableLabScreen(
      {super.key, required this.data, required this.dataVitalsign});

  @override
  State<CompareTableLabScreen> createState() => _CompareTableLabScreenState();
}

class _CompareTableLabScreenState extends State<CompareTableLabScreen> {
  static int tabGraphSelectUpstairs = 0; //ค่าเวลาเลือกแต่ละ tab บน
  static int tabGraphSelect = 0; //ค่าเวลาเลือกแต่ละ tab ล่าง
  static int selectTableOrGraph = 0; //เลือกตารางหรือกราฟ
  int dataIndex = 0;
  final List tempName = []; //หัวข้อตาราง
  final List tempNameSub = []; //รายละเอียดหัวข่อตาราง
  final List requestNumber = []; // check up no
  final List dataTitel = []; //วันที่ข้อมูล

  List<SalesData> chartData0 = [SalesData('', 0)];
  List<NomalValueUnit> nomalValueData = [NomalValueUnit('', '', '')];
  List<TabGrapModel> tabGraph = [];
  List<TempGpraph> tempGraaph1 = [];

  final List<TempCol> tempCol1 = []; //ข้อมุลข้อคอลัมพ์1

  List<List<TempCol>> dataTable = [[]];
  List<List<TempGpraph>> dataGraph = [[]];

  //fucn scroll auto บน
  final scrollDirection = Axis.horizontal; //scroll แนวนอน
  int counter = 0; //ค่านับจำนวน scroll

  late AutoScrollController controllerUpstairs;
  Future _nextCounterUpstairs(counter) {
    setState(() => counter = counter);
    return _scrollToCounterUpstairs();
  }

  Future _scrollToCounterUpstairs() async {
    await controllerUpstairs.scrollToIndex(counter,
        preferPosition: AutoScrollPosition.middle);
    controllerUpstairs.highlight(counter);
  }
  /////////////////////////////////////

  //fucn scroll auto ล่าง
  late AutoScrollController controller;
  Future _nextCounter(counter) {
    setState(() => counter = counter);
    return _scrollToCounter();
  }

  Future _scrollToCounter() async {
    await controller.scrollToIndex(counter,
        preferPosition: AutoScrollPosition.middle);
    controller.highlight(counter);
  }
  /////////////////////////////////////

  void setDataTable(bt) {
    setState(() {
      dataIndex = widget.data![bt].body.length;
    });
    tabGraph.clear();
    tempName.clear();
    tempNameSub.clear();
    requestNumber.clear();
    dataTitel.clear();

    tempGraaph1.clear();

    tempCol1.clear();

    dataTable.clear();
    dataGraph.clear();
    //หัวคอลัมพ์1
    for (var i = 0; i < widget.data![bt].body.length; i++) {
      for (var element in widget.data![bt].body[i]) {
        var bar =
            tempName.firstWhereOrNull((item) => item == element.labNameEn);
        if (bar == null) {
          tempName.add(element.labNameEn);
          tempNameSub.add(element.labNameTh);
          tabGraph.add(TabGrapModel(
              id: tempName.length,
              titel: element.labNameEn,
              value: element.resultValue));
        }
      }
    }

    //////////////body///////////////
    for (var y = 0; y < widget.data![bt].body.length; y++) {
      tempCol1.clear();
      tempGraaph1.clear();

      for (var o = 0; o < tempName.length; o++) {
        var mock = false;
        for (var i = 0; i < widget.data![bt].body[y].length; i++) {
          if (tempName[o] == widget.data![bt].body[y][i].labNameEn) {
            var bar = tempCol1
                .firstWhereOrNull((item) => item.labName == tempName[o]);
            if (bar == null) {
              tempCol1.add(TempCol(
                  '${widget.data![bt].body[y][i].labNameEn}',
                  '${widget.data![bt].body[y][i].resultValue}',
                  '${widget.data![bt].body[y][i].labResultClassifiedName}',
                  '${widget.data![bt].body[y][i].normalResultValue}'));
              tempGraaph1.add(TempGpraph(
                  '${widget.data![bt].body[y][i].resultValue}',
                  '${widget.data![bt].body[y][i].normalResultValue}',
                  '${widget.data![bt].body[y][i].labNameEn}',
                  '${widget.data![bt].body[y][i].labNameTh}'));
            }

            if (i == 0) {
              for (var ii = 0; ii < widget.dataVitalsign!.length; ii++) {
                if (widget.dataVitalsign![ii].requestNo ==
                    widget.data![bt].body[y][i].requestNo) {
                  dataTitel.add(widget.dataVitalsign![ii].visitdate);
                  requestNumber.add(widget.dataVitalsign![ii].requestNo);
                }
              }
            }

            mock = true;
          }

          if (!mock && i == widget.data![bt].body[y].length - 1) {
            tempCol1.add(TempCol('', '-', 'Normal', ''));
            tempGraaph1.add(TempGpraph('-', '', '', ''));
          }
        }
      }
      List<TempCol> dataTable2 = [];

      for (var ii = 0; ii < tempCol1.length; ii++) {
        dataTable2.add(tempCol1[ii]);
      }
      List<TempGpraph> dataGraph2 = [];
      for (var iii = 0; iii < tempGraaph1.length; iii++) {
        dataGraph2.add(tempGraaph1[iii]);
      }
      dataTable.add(dataTable2);
      dataGraph.add(dataGraph2);
    }
    setDataGraph(1, bt, '');
  }

  void setDataGraph(int id, int bt, String titel) {
    chartData0.clear();
    nomalValueData.clear();
    if (widget.data![bt].body.isNotEmpty) {
      for (var i = 0; i < dataGraph.length; i++) {
        if ((double.tryParse(
                    dataGraph[i][id - 1].resultValue.replaceAll(',', '')) ??
                0) <=
            0.0) {
          chartData0.add(SalesData('', 0));
          nomalValueData.add(NomalValueUnit('', '', ''));
        } else {
          chartData0.add(SalesData(
              '${widget.dataVitalsign![i].entryDateTime.day}\n${CheckDate.mounth(widget.dataVitalsign![i].entryDateTime.month)}\n${CheckDate.year(widget.dataVitalsign![i].entryDateTime.year)}',
              double.parse(
                  dataGraph[i][id - 1].resultValue.replaceAll(',', ''))));
          nomalValueData.add(NomalValueUnit(
              dataGraph[i][id - 1].nomalValue,
              dataGraph[i][id - 1].labNameEn,
              '( ${dataGraph[i][id - 1].labNameEn} )'));
        }
      }
    }
  }

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
    controllerUpstairs = AutoScrollController(axis: scrollDirection);
    controller = AutoScrollController(axis: scrollDirection);
    setDataTable(tabGraphSelectUpstairs);
  }

  List<Widget> _buildCells(
    int count,
  ) {
    final fullScreenWidth = MediaQuery.of(context).size.width;
    return List.generate(
      count,
      (index) => Container(
        width: fullScreenWidth > 600 ? 250 : 150,
        height: 110,
        color: ColorBtRegister,
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  textAlign: TextAlign.left,
                  "${tempName[index] ?? ''}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(color: Colors.white, fontSize: font24),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  textAlign: TextAlign.left,
                  "${tempNameSub[index] ?? ''}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: font14,
                      fontFamily: 'RSU_light'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildRows(
    int count,
  ) {
    return List.generate(
      count,
      (index) => Row(
        children: _buildCells2(dataIndex, index),
      ),
    );
  }

  List<Widget> _buildCells2(
    int count,
    int index2,
  ) {
    return List.generate(count, (index) => tableData(index, index2));
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
                        'เปรียบเทียบผลตรวจ Lab',
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
              controller: controllerUpstairs,
              children: widget.data!.map<Widget>((item) {
                return _getRowUpstairs(item.id, item.labGroup);
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SizedBox(
              height: 50,
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
                                '${dataTitel[0].day} ${CheckDate.mounth(dataTitel[0].month)} ${CheckDate.year(dataTitel[0].year)}',
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
                      children: tabGraph.map<Widget>((item) {
                        return _getRow(item.id, item.titel ?? '', item.value,
                            tabGraphSelectUpstairs);
                      }).toList()))
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
            ),
          ),
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
                          style:
                              TextStyle(color: Colors.white, fontSize: font24),
                        ),
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 160),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildCells(tempName.length),
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
                      BoxShadow(color: Colors.white, offset: Offset(-10, 0)),
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
                            image: AssetImage('assets/icons/tableIcon@3x.png'),
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
        Flexible(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Row(
                    children: requestNumber.map<Widget>((i) {
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
                          height: 110,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                '$i',
                                style: TextStyle(
                                    color: ColorDefaultApp0, fontSize: font24),
                              ),
                            ],
                          ));
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 160),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildRows(tempName.length),
                  ),
                ),
                Row(
                  children: dataTitel.map<Widget>((i) {
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
                                color: Colors.white, offset: Offset(-10, 0)),
                          ],
                        ),
                        width: fullScreenWidth > 600 ? 250 : 180,
                        height: 50,
                        child: Text(
                          '${i.day} ${CheckDate.mounth(i.month)} ${CheckDate.year(i.year)}',
                          style: TextStyle(
                              color: ColorDefaultApp1, fontSize: font20),
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
          color: ColorBtRegister,
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
                        '${nomalValueData[0].labNameEn} ${nomalValueData[0].labNameTh}',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'RSU_light',
                            fontSize: font14),
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
                    nomalValueData[0].nomalValue,
                    style: TextStyle(
                        color: const Color(0xffc6f243), fontSize: font14),
                  ),
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
                      '${dataTitel[0].day} ${CheckDate.mounth(dataTitel[0].month)} ${CheckDate.year(dataTitel[0].year)} : ',
                      style:
                          TextStyle(color: ColorDefaultApp0, fontSize: font24),
                    ),
                    Text(
                      NumberFormat.currency()
                          .format(chartData0[0].value)
                          .replaceAll('USD', ''),
                      style:
                          TextStyle(color: ColorDefaultApp1, fontSize: font24),
                    ),
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
                      decimalPlaces: 1,
                      majorTickLines: const MajorTickLines(size: 0),
                      majorGridLines: const MajorGridLines(width: 1),
                      // interval: 20,
                      axisLine: const AxisLine(width: 0),
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: font14,
                      )),
                  palette: const <Color>[
                    Color(0xffc6f243),
                    Color(0xff4ef7f4)
                  ],
                  series: [
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
                      dataSource: chartData0,
                      xValueMapper: (SalesData data, _) => data.month,
                      yValueMapper: (SalesData data, _) =>
                          data.value == 0 ? null : data.value,
                    ),
                  ]),
            )
          ],
        ));
  }

  Container tableData(
    index,
    index2,
  ) {
    final fullScreenWidth = MediaQuery.of(context).size.width;
    return Container(
        alignment: Alignment.center,
        width: fullScreenWidth > 600 ? 250 : 180,
        height: 110,
        decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
                right: BorderSide(
              color: ColorDivider,
              width: 2,
            ))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                textAlign: TextAlign.center,
                dataTable[index][index2].resultValue,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                    color: dataTable[index][index2].labResultClassifiedName ==
                                'High' ||
                            dataTable[index][index2].labResultClassifiedName ==
                                'Low'
                        ? ColorOreng
                        : ColorBtRegister,
                    fontSize: font24),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                textAlign: TextAlign.center,
                dataTable[index][index2].normalResultValue != ''
                    ? 'ค่าปกติ ${dataTable[index][index2].normalResultValue}'
                    : '',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                    color: ColorDefaultApp0,
                    fontSize: font14,
                    fontFamily: 'RSU_light'),
              ),
            ),
          ],
        ));
  }

  //render buttom tab
  Widget _getRowUpstairs(int id, String? titel) {
    void nextCounterUpstairs() {
      _nextCounterUpstairs(counter = id);
      setState(() {
        tabGraphSelectUpstairs = id;
        setDataTable(tabGraphSelectUpstairs);
      });
    }

    return TabMenuScroll(
        controller: controllerUpstairs,
        id: id,
        titel: titel,
        tabSelect: tabGraphSelectUpstairs,
        nextCounter: nextCounterUpstairs,
        counter: counter);
  }

  //render buttom tab
  Widget _getRow(id, titel, value, bt) {
    void nextCounter() {
      _nextCounter(counter = id);
      setState(() {
        tabGraphSelect = id;
      });
      setDataGraph(id, bt, titel);
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

class TempCol {
  TempCol(this.labName, this.resultValue, this.labResultClassifiedName,
      this.normalResultValue);
  final String labName;
  final String resultValue;
  final String labResultClassifiedName;
  final String normalResultValue;
}

class TabGrapModel {
  final int id;
  final String? titel;
  final String? value;

  const TabGrapModel(
      {required this.id, required this.titel, required this.value});
}

class SalesData {
  SalesData(this.month, this.value);

  final String month;
  final double value;
}

class NomalValueUnit {
  NomalValueUnit(this.nomalValue, this.labNameEn, this.labNameTh);

  final String nomalValue;
  final String labNameEn;
  final String labNameTh;
}

class TempGpraph {
  TempGpraph(this.resultValue, this.nomalValue, this.labNameEn, this.labNameTh);

  final String resultValue;
  final String nomalValue;
  final String labNameEn;
  final String labNameTh;
}
