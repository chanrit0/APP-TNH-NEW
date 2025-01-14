import 'package:app_tnh2/model/healthResult/modelHealthReportDetail.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:flutter/material.dart';

class Diagnostician extends StatelessWidget {
  final List<Summary> data;
  const Diagnostician({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Column(
            children: data
                .map(
                  (item) => Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'คำวินิจฉัยแพทย์',
                                    style: TextStyle(
                                        color: ColorDefaultApp1,
                                        fontSize: font20),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  item.summary ?? 'ไม่มีข้อมูล',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: ColorDefaultApp0,
                                      fontSize: font16,
                                      fontFamily: 'RSU_light'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                )
                .toList()),
      ),
    );
  }
}
