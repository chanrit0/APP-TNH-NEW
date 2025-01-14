import 'package:app_tnh2/styles/colors.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:flutter/material.dart';

modelLab(
  BuildContext context,
  String? labNameEn,
  String? labNameTh,
  String? resultValue,
  String? unit,
  String? normalResultValue,
  String? labCommentEn,
  String? labCommentTh,
  String? labResultClassifiedName,
  String? summary,
  String? checkUpCommentNameEN,
  String? checkUpCommentNameTH,
) {
  AlertDialog alert = AlertDialog(
    content: MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: SizedBox(
          height: labResultClassifiedName == 'High' ||
                  labResultClassifiedName == 'Low'
              ? 550
              : 340,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Flexible(
                              child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            child: Text(
                              labNameEn ?? '',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  color: ColorDefaultApp0, fontSize: font20),
                            ),
                          )),
                          Flexible(
                              child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Flexible(
                                  child: Text(
                                    '$resultValue',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: labResultClassifiedName ==
                                                    'High' ||
                                                labResultClassifiedName == 'Low'
                                            ? ColorOreng
                                            : ColorDefaultApp1,
                                        fontSize: font20),
                                  ),
                                ),
                                if (unit == '')
                                  const SizedBox()
                                else
                                  Flexible(
                                    child: Text(
                                      ' $unit',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: ColorDefaultApp0,
                                          fontSize: font20),
                                    ),
                                  )
                              ],
                            ),
                          )),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                              child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            child: Text(
                              labNameTh ?? '',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  color: ColorDefaultApp0,
                                  fontFamily: 'RSU_light',
                                  fontSize: font16),
                            ),
                          )),
                          Flexible(
                              child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Flexible(
                                  child: Text(
                                    'ค่าปกติ ',
                                    style: TextStyle(
                                        color: ColorDefaultApp0,
                                        fontFamily: 'RSU_light',
                                        fontSize: font16),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    normalResultValue ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: ColorDefaultApp0,
                                        fontFamily: 'RSU_light',
                                        fontSize: font16),
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ],
                      ),
                      const Divider(
                        color: ColorDivider,
                        thickness: 1,
                        endIndent: 0,
                      ),
                    ],
                  )),
              Flexible(
                  flex: labResultClassifiedName == 'High' ||
                          labResultClassifiedName == 'Low'
                      ? 4
                      : 2,
                  fit: FlexFit.tight,
                  child: SingleChildScrollView(
                    child: labResultClassifiedName == 'High' ||
                            labResultClassifiedName == 'Low'
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'คำแนะนำจากแพทย์',
                                    style: TextStyle(
                                        color: ColorDefaultApp1,
                                        fontSize: font20),
                                  ),
                                ],
                              ),
                              if (labCommentTh == '')
                                const SizedBox()
                              else
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '$labCommentTh',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: ColorDefaultApp0,
                                            fontSize: font16),
                                      ),
                                    )
                                  ],
                                ),
                              if (labCommentEn == '')
                                const SizedBox()
                              else
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '$labCommentEn',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: ColorDefaultApp0,
                                            fontSize: font16),
                                      ),
                                    )
                                  ],
                                ),
                            ],
                          )
                        : Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'คำแนะนำจากแพทย์',
                                    style: TextStyle(
                                        color: ColorDefaultApp1,
                                        fontSize: font20),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'ไม่มีคำแนะนำจากแพทย์',
                                    style: TextStyle(
                                        color: ColorDefaultApp0,
                                        fontSize: font16),
                                  )
                                ],
                              ),
                            ],
                          ),
                  )),
              Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: SingleChildScrollView(
                    child: labResultClassifiedName == 'High' ||
                            labResultClassifiedName == 'Low'
                        ? Column(
                            children: [
                              const Divider(
                                color: ColorDivider,
                                thickness: 1,
                                endIndent: 0,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'แพทย์สรุปผล',
                                    style: TextStyle(
                                        color: ColorDefaultApp1,
                                        fontSize: font20),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      checkUpCommentNameTH ?? '',
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 10,
                                      style: TextStyle(
                                          color: ColorDefaultApp0,
                                          fontSize: font16),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      checkUpCommentNameEN ?? '',
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 10,
                                      style: TextStyle(
                                          color: ColorDefaultApp0,
                                          fontSize: font16),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              const Divider(
                                color: ColorDivider,
                                thickness: 1,
                                endIndent: 0,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'แพทย์สรุปผล',
                                    style: TextStyle(
                                        color: ColorDefaultApp1,
                                        fontSize: font20),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'ไม่มีผลสรุปจากแพทย์',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 10,
                                    style: TextStyle(
                                        color: ColorDefaultApp0,
                                        fontSize: font16),
                                  )
                                ],
                              ),
                            ],
                          ),
                  )),
            ],
          )),
    ),
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
