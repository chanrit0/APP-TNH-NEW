import 'package:app_tnh2/model/healthResult/modelHealthReport.dart';
import 'package:app_tnh2/model/healthResult/modelHealthReportDetail.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:flutter/material.dart';

class Vital_Sign extends StatelessWidget {
  final List<Vitalsign> vitalsign;
  final ResHealthReport item;
  const Vital_Sign({super.key, required this.vitalsign, required this.item});

  @override
  Widget build(BuildContext context) { 
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Column(
              children: vitalsign.map((itemVitalsign) {
            return Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 10),
                  child: Column(children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'ชื่อ - นามสกุล',
                              style: TextStyle(
                                  color: ColorDefaultApp0, fontSize: font18),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '${item.name}',
                              style: TextStyle(
                                  color: ColorDefaultApp1, fontSize: font20),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(
                      color: ColorDivider,
                      thickness: 1,
                      endIndent: 0,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Text('เพศ',
                                  style: TextStyle(
                                      color: ColorDefaultApp0,
                                      fontSize: font18)),
                            ),
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Text('อายุ',
                                  style: TextStyle(
                                      color: ColorDefaultApp0,
                                      fontSize: font18)),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Text('${item.genderTh}',
                                  style: TextStyle(
                                      color: ColorDefaultApp1,
                                      fontSize: font20)),
                            ),
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Text(
                                  item.age != null ? '${item.age} ปี' : '-',
                                  style: TextStyle(
                                      color: ColorDefaultApp1,
                                      fontSize: font20)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(
                      color: ColorDivider,
                      thickness: 1,
                      endIndent: 0,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Text('น้ำหนัก',
                                  style: TextStyle(
                                      color: ColorDefaultApp0,
                                      fontSize: font18)),
                            ),
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Text('ส่วนสูง',
                                  style: TextStyle(
                                      color: ColorDefaultApp0,
                                      fontSize: font18)),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Text('${itemVitalsign.bodyWeight} กก.',
                                  style: TextStyle(
                                      color: ColorDefaultApp1,
                                      fontSize: font20)),
                            ),
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Text('${itemVitalsign.height} ซม.',
                                  style: TextStyle(
                                      color: ColorDefaultApp1,
                                      fontSize: font20)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(
                      color: ColorDivider,
                      thickness: 1,
                      endIndent: 0,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'หมู่เลือด',
                              style: TextStyle(
                                  color: ColorDefaultApp0, fontSize: font18),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '${itemVitalsign.blood}',
                              style: TextStyle(
                                  color: ColorDefaultApp1, fontSize: font20),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(
                      color: ColorDivider,
                      thickness: 1,
                      endIndent: 0,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'อุณหภูมิ',
                              style: TextStyle(
                                  color: ColorDefaultApp0, fontSize: font18),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '${itemVitalsign.temperature}',
                              style: TextStyle(
                                  color: ColorDefaultApp1, fontSize: font20),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(
                      color: ColorDivider,
                      thickness: 1,
                      endIndent: 0,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'อัตราชีพจร',
                              style: TextStyle(
                                  color: ColorDefaultApp0, fontSize: font18),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '${itemVitalsign.pulseRate} / นาที',
                              style: TextStyle(
                                  color: ColorDefaultApp1, fontSize: font20),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(
                      color: ColorDivider,
                      thickness: 1,
                      endIndent: 0,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'ความดันโลหิต',
                              style: TextStyle(
                                  color: ColorDefaultApp0, fontSize: font18),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '${itemVitalsign.highpulserate} / ${itemVitalsign.lowpulserate}',
                              style: TextStyle(
                                  color: ColorDefaultApp1, fontSize: font20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ]),
                ));
          }).toList())),
    );
  }
}
