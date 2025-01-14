import 'dart:convert';

import 'package:app_tnh2/controller/api.dart';
import 'package:app_tnh2/model/healthResult/modelHealthReport.dart';
import 'package:app_tnh2/model/healthResult/modelHealthReportDetail.dart';
import 'package:app_tnh2/model/tabBarModel.dart';
import 'package:app_tnh2/screens/home/healthResult/tabHealthLatest/tabData/diagnostician.dart';
import 'package:app_tnh2/screens/home/healthResult/tabHealthLatest/tabData/lab_Results.dart';
import 'package:app_tnh2/screens/home/healthResult/tabHealthLatest/tabData/vital_Sign.dart';
import 'package:app_tnh2/screens/home/healthResult/tabHealthLatest/tabData/x_ray.dart';
import 'package:app_tnh2/screens/home/healthResult/widget/itemHealthResult0.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:app_tnh2/widgets/stateScreenDetails.dart';
import 'package:app_tnh2/widgets/tabMenuScroll.dart';
import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class TabHealthResult0 extends StatefulWidget {
  final ResHealthReport item;
  final String img;
  final int tab;
  const TabHealthResult0({
    super.key,
    required this.item,
    required this.img,
    required this.tab,
  });

  @override
  State<TabHealthResult0> createState() => _TabHealthResult1State();
}

class _TabHealthResult1State extends State<TabHealthResult0> {
  int tabSelect = 0; //ค่าเวลาเลือกแต่ละ tab
  bool isLoading = false; //โหลดหน้า
  dynamic calApi = '';

  /////////////////////////////////fun tab sroll
  /////tab
  List<TabBarModel> tab0TitelList = getTab();
  late AutoScrollController controller;
  final scrollDirection = Axis.horizontal;
  int counter = 0;
  late Service postService;
  static List<TabBarModel> getTab() {
    const data = [
      {"id": 0, "titel": "Vital Sign"},
      {"id": 1, "titel": "ผลตรวจ Lab"},
      {"id": 2, "titel": "ผลตรวจ X-ray"},
      {"id": 3, "titel": "แพทย์วินิจฉัย"},
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
  ///////////////////////////////

  //กรณีเลือก tab
  switchCaseTab(
    selectTab,
    ResReportDetail? item,
  ) {
    switch (selectTab) {
      case 0:
        return tab0(item!.vitalsign);
      case 1:
        return buildItemTab(item!.lab);
      case 2:
        return tab2(item!.xray);
      case 3:
        return tab3(item!.summary);
    }
  }

  @override
  initState() {
    super.initState();
    controller = AutoScrollController(axis: scrollDirection);
    postService = Service(context: context);
    calApi = postService.funHealthReportDetail('${widget.item.requestNo}',
        '${widget.item.visitDate}', '${widget.item.vn}');
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
          const SizedBox(
            height: 10,
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: SizedBox(
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  ItemHealthResult0(
                    item: widget.item,
                    img: widget.img,
                    tab: widget.tab,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      scrollDirection: scrollDirection,
                      controller: controller,
                      children: tab0TitelList.map<Widget>((item) {
                        return _getRow(item.id, item.titel);
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildFutureBuilder(),
                ],
              )),
            ),
          ),
        ],
      )),
    );
  }

  //tab vital sign
  Center tab0(List<Vitalsign> item) {
    return Center(
        child: item.isEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 150),
                child: Text(
                  'ไม่มีรายการ',
                  style: TextStyle(color: Colors.grey, fontSize: font20),
                ),
              )
            : Vital_Sign(
                vitalsign: item,
                item: widget.item,
              ));
  }

  //tab ผลตรวจ lab
  Widget buildItemTab(
    List<Lab> item,
  ) {
    return item.isEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Text(
              'ไม่มีรายการ',
              style: TextStyle(color: Colors.grey, fontSize: font20),
            ),
          )
        : Column(
            children: item
                .map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      right: 20,
                      left: 20,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: ExpansionPanelList(
                          expansionCallback: (int index, bool isExpanded) {
                            setState(() {
                              if (isExpanded) {
                                item.isExpanded = true;
                              } else {
                                item.isExpanded = false;
                              }
                            });
                          },
                          children: [
                            ExpansionPanel(
                              canTapOnHeader: true,
                              headerBuilder:
                                  (BuildContext context, bool isExpanded) {
                                return ListTile(
                                  title: Text(
                                    item.labGroup ?? '',
                                    style: TextStyle(
                                        color: ColorDefaultApp1,
                                        fontSize: font20),
                                  ),
                                );
                              },
                              body: LabResults(
                                data: item.body,
                              ),
                              isExpanded: item.isExpanded,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList());
  }

  //reder ผลตรวจ x-ray
  Center tab2(
    List<Xray> item,
  ) {
    return item.isEmpty
        ? Center(
            child: Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Text(
              'ไม่มีรายการ',
              style: TextStyle(color: Colors.grey, fontSize: font20),
            ),
          ))
        : Center(child: X_Rat(data: item));
  }

  //reder แพทย์วินิจฉัย
  Center tab3(
    List<Summary> item,
  ) {
    return Center(
        child: item.isEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 150),
                child: Text(
                  'ไม่มีรายการ',
                  style: TextStyle(color: Colors.grey, fontSize: font20),
                ),
              )
            : Diagnostician(data: item));
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

  FutureBuilder<ModelHealthReportDetail?> buildFutureBuilder() {
    return FutureBuilder<ModelHealthReportDetail?>(
      future: calApi,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var item = snapshot.data;
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(child: switchCaseTab(tabSelect, item?.resData)),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const Center(
            child: Padding(
          padding: EdgeInsets.only(top: 150),
          child: CircularProgressIndicator(
            color: ColorDefaultApp1,
          ),
        ));
      },
    );
  }
}
