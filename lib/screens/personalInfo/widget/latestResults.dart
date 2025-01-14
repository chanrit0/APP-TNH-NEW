import 'package:app_tnh2/model/healthResult/modelHealthReportDetail.dart';
import 'package:app_tnh2/screens/home/healthResult/tabHealthLatest/tabHealthResult0.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LatestResulte extends StatelessWidget {
  dynamic data;
  dynamic detail;
  LatestResulte({
    super.key,
    required this.data,
    required this.detail,
  });
  @override
  Widget build(BuildContext context) {
    final fullScreenWidth = MediaQuery.of(context).size.width;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: ClipRRect(
            child: Material(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  settings:
                      const RouteSettings(name: 'TNH_TabHealthResult_Screen'),
                  builder: (context) => TabHealthResult0(
                    item: detail,
                    img: 'assets/images/backgroundAppointItem@3x.png',
                    tab: 0,
                  ),
                ),
              );
            },
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: const DecorationImage(
                    image: AssetImage(
                        'assets/images/backgroundAppointItem@3x.png'),
                    fit: BoxFit.cover),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              width: MediaQuery.of(context).size.width,
              height: fullScreenWidth > 600
                  ? fullScreenWidth > 750 || fullScreenWidth < 800
                      ? 140.h
                      : 130.h
                  : 130,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 10, top: 10),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: Text(
                            'ผลตรวจล่าสุด',
                            style: TextStyle(
                                color: Colors.white, fontSize: font18),
                          ),
                        ),
                        Flexible(
                          flex: 0,
                          fit: FlexFit.tight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'ดูเพิ่มเติม ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: font18,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              const Image(
                                image: AssetImage(
                                    'assets/icons/arrow-left-anticon@3x.png'),
                                height: 20,
                                width: 21,
                              ),
                              const SizedBox(
                                width: 5,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  FutureBuilder(
                    future: data,
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        ModelHealthReportDetail? item = snapshot.data;
                        if (item?.resData == null) {
                          return const SizedBox();
                        } else {
                          return Expanded(
                              child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                //น้ำหนัก
                                item?.resData.vitalsign[0].bodyWeight != null
                                    ? boxContanItem(
                                        'น้ำหนัก',
                                        '${item?.resData.vitalsign[0].bodyWeight}',
                                        ColorBtRegister,
                                        fullScreenWidth > 600 ? 90.h : 90.0,
                                      )
                                    : boxContanItem('', '', ColorBtRegister, 0),
                                //ส่วนสูง
                                item?.resData.vitalsign[0].height != null
                                    ? boxContanItem(
                                        'ส่วนสูง',
                                        '${item?.resData.vitalsign[0].height}',
                                        ColorBtRegister,
                                        fullScreenWidth > 600 ? 90.h : 90.0,
                                      )
                                    : boxContanItem('', '', ColorBtRegister, 0),

                                //อัตราชีพจร
                                item?.resData.vitalsign[0].pulseRate != null
                                    ? boxContanItem(
                                        'อัตราชีพจร',
                                        '${item?.resData.vitalsign[0].pulseRate.toInt()}',
                                        double.parse('${item?.resData.vitalsign[0].pulseRate}') >
                                                    120 ||
                                                double.parse(
                                                        '${item?.resData.vitalsign[0].pulseRate}') <
                                                    60
                                            ? ColorOreng
                                            : ColorBtRegister,
                                        fullScreenWidth > 600 ? 90.h : 90.0,
                                      )
                                    : boxContanItem('', '', ColorBtRegister, 0),
                                //ความดันโลหิต
                                item?.resData.vitalsign[0].highpulserate !=
                                            null ||
                                        item?.resData.vitalsign[0]
                                                .lowpulserate !=
                                            null
                                    ? boxContanItem(
                                        'ความดันโลหิต',
                                        '${item?.resData.vitalsign[0].highpulserate.toInt()} / ${item?.resData.vitalsign[0].lowpulserate.toInt()}'
                                            .toString(),
                                        double.parse(
                                                        '${item?.resData.vitalsign[0].highpulserate}') >
                                                    130 ||
                                                double.parse(
                                                        '${item?.resData.vitalsign[0].highpulserate}') <
                                                    110 ||
                                                double.parse(
                                                        '${item?.resData.vitalsign[0].lowpulserate}') >
                                                    90 ||
                                                double.parse(
                                                        '${item?.resData.vitalsign[0].lowpulserate}') <
                                                    60
                                            ? ColorOreng
                                            : ColorBtRegister,
                                        fullScreenWidth > 600 ? 120.h : 120.0,
                                      )
                                    : boxContanItem('', '', ColorBtRegister, 0),
                                //อุณหภูมิ
                                item?.resData.vitalsign[0].temperature != null
                                    ? boxContanItem(
                                        'อุณหภูมิ',
                                        '${item?.resData.vitalsign[0].temperature}',
                                        double.parse('${item?.resData.vitalsign[0].temperature}') >
                                                    37.5 ||
                                                double.parse(
                                                        '${item?.resData.vitalsign[0].temperature}') <
                                                    36.0
                                            ? ColorOreng
                                            : ColorBtRegister,
                                        fullScreenWidth > 600 ? 90.h : 90.0,
                                      )
                                    : boxContanItem('', '', ColorBtRegister, 0),
                                //ดัชนีมวลกาย
                                item?.resData.vitalsign[0].bmiValue != null
                                    ? boxContanItem(
                                        'ดัชนีมวลกาย',
                                        '${item?.resData.vitalsign[0].bmiValue}',
                                        double.parse('${item?.resData.vitalsign[0].bmiValue}') >
                                                    24.9 ||
                                                double.parse(
                                                        '${item?.resData.vitalsign[0].bmiValue}') <
                                                    18.6
                                            ? ColorOreng
                                            : ColorBtRegister,
                                        fullScreenWidth > 600 ? 90.h : 90.0,
                                      )
                                    : boxContanItem('', '', ColorBtRegister, 0),
                                //อัตราการหายใจ
                                item?.resData.vitalsign[0].respirationRate !=
                                        null
                                    ? boxContanItem(
                                        'อัตราการหายใจ',
                                        '${item?.resData.vitalsign[0].respirationRate}',
                                        double.parse('${item?.resData.vitalsign[0].respirationRate}') >
                                                    24.9 ||
                                                double.parse(
                                                        '${item?.resData.vitalsign[0].respirationRate}') <
                                                    18.6
                                            ? ColorOreng
                                            : ColorBtRegister,
                                        fullScreenWidth > 600 ? 90.h : 90.0,
                                      )
                                    : boxContanItem('', '', ColorBtRegister, 0),
                              ]));
                        }
                      }
                      return const Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Center(
                            child: CircularProgressIndicator(
                          color: ColorBtRegister,
                        )),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }

  SizedBox boxContanItem(
    String tetel,
    String value,
    Color color,
    double widthBox,
  ) {
    return SizedBox(
      width: widthBox,
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(color: color, fontSize: font34),
          ),
          Text(
            tetel,
            style: TextStyle(color: Colors.white, fontSize: font14),
          )
        ],
      ),
    );
  }
}
