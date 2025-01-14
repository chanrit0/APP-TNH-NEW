import 'package:app_tnh2/model/healthResult/modelHealthReportDetail.dart';
import 'package:app_tnh2/screens/home/healthResult/tabHealthLatest/tabData/modelLab.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:flutter/material.dart';

class LabResults extends StatelessWidget {
  final List<List<Body>> data;
  const LabResults({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Column(
          children: data[0]
              .map((item) => SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        const Divider(
                          color: ColorDivider,
                          thickness: 1,
                          endIndent: 0,
                        ),
                        InkWell(
                            onTap: () {
                              modelLab(
                                  context,
                                  item.labNameEn,
                                  item.labNameTh,
                                  item.resultValue,
                                  item.unit,
                                  item.normalResultValue,
                                  item.labCommentEn,
                                  item.labCommentTh,
                                  item.labResultClassifiedName,
                                  item.summary,
                                  item.labCommentTh,
                                  item.labCommentEn);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                      child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.white,
                                        ),
                                        child: Text(
                                          item.labNameEn ?? '',
                                          style: TextStyle(
                                              color: ColorDefaultApp0,
                                              fontSize: font20),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.white,
                                        ),
                                        child: Text(
                                          item.labNameTh ?? '',
                                          style: TextStyle(
                                              color: ColorDefaultApp0,
                                              fontSize: font16,
                                              fontFamily: 'RSU_light'),
                                        ),
                                      ),
                                    ],
                                  )),
                                  Flexible(
                                      child: Column(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.white,
                                        ),
                                        child: Row(
                                          children: [
                                            Flexible(
                                              flex: 1,
                                              fit: FlexFit.tight,
                                              child: Text(
                                                '${item.resultValue}',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    color: item.labResultClassifiedName ==
                                                                'High' ||
                                                            item.labResultClassifiedName ==
                                                                'Low'
                                                        ? ColorOreng
                                                        : ColorBtRegister,
                                                    fontSize: font20),
                                              ),
                                            ),
                                            Flexible(
                                                flex: 0,
                                                fit: FlexFit.tight,
                                                child: Text(
                                                  item.unit != ''
                                                      ? ' ${item.unit}'
                                                      : '',
                                                  style: TextStyle(
                                                      color: ColorDefaultApp0,
                                                      fontSize: font20),
                                                ))
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.white,
                                        ),
                                        child: Text(
                                          item.normalResultValue != ''
                                              ? 'ค่าปกติิิ ${item.normalResultValue}'
                                              : '',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              color: ColorDefaultApp0,
                                              fontSize: font16,
                                              fontFamily: 'RSU_light'),
                                        ),
                                      )
                                    ],
                                  )),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ))
              .toList()),
    );
  }
}
