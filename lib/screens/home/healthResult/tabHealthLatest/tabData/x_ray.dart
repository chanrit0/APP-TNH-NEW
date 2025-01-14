import 'package:app_tnh2/helper/checkDate.dart';
import 'package:app_tnh2/model/healthResult/modelHealthReportDetail.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:flutter/material.dart';

class X_Rat extends StatelessWidget {
  final List<Xray> data;
  const X_Rat({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Chest (AP or PA Upright)',
                          style: TextStyle(
                              color: ColorDefaultApp1, fontSize: font20),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Request No. :',
                          style: TextStyle(
                              color: ColorDefaultApp0,
                              fontFamily: 'RSU_light',
                              fontSize: font16),
                        ),
                        Text(
                          ' ${data[0].requestNo}',
                          style: TextStyle(
                              color: ColorDefaultApp1,
                              fontFamily: 'RSU_light',
                              fontSize: font16),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Result date : ',
                          style: TextStyle(
                              color: ColorDefaultApp0,
                              fontFamily: 'RSU_light',
                              fontSize: font16),
                        ),
                        Text(
                          '${data[0].resultDateTime!.day} ${CheckDate.mounth(data[0].resultDateTime!.month)} ${CheckDate.year(data[0].resultDateTime!.year)}',
                          style: TextStyle(
                              color: ColorDefaultApp1,
                              fontFamily: 'RSU_light',
                              fontSize: font16),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'X-ray name :',
                          style: TextStyle(
                              color: ColorDefaultApp0,
                              fontFamily: 'RSU_light',
                              fontSize: font16),
                        ),
                        Text(
                          ' ${data[0].xrayNameTh}',
                          style: TextStyle(
                              color: ColorDefaultApp1,
                              fontFamily: 'RSU_light',
                              fontSize: font16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'ผลตรวจ X-ray',
                          style: TextStyle(
                              color: ColorDefaultApp1, fontSize: font20),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        '${data[0].summary}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: ColorDefaultApp0,
                            fontFamily: 'RSU_light',
                            fontSize: font16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'แพทย์สรุปผล',
                          style: TextStyle(
                              color: ColorDefaultApp1, fontSize: font20),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${data[0].result == '' ? 'ไม่มีข้อมูล' : data[0].result}',
                            textAlign: TextAlign.left,
                            maxLines: 10,
                            style: TextStyle(
                                color: ColorDefaultApp0,
                                fontFamily: 'RSU_light',
                                fontSize: font16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
