import 'package:app_tnh2/model/healthResult/modelHealthReportDetail.dart';
import 'package:app_tnh2/screens/home/healthResult/tabCompareResult/compareVistal.dart';
import 'package:app_tnh2/screens/home/healthResult/tabCompareResult/compareLab.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompareResults extends StatelessWidget {
  final ModelHealthReportDetail item;
  const CompareResults({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final fullScreenWidth = MediaQuery.of(context).size.width;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                child: Material(
                    child: InkWell(
                        splashColor: ColorDefaultApp0.withOpacity(0.5),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              settings: const RouteSettings(
                                  name: 'TNH_CompareTableVistal_Screen'),
                              builder: (context) => CompareTableScreen(
                                  item: item.resData.vitalsign),
                            ),
                          );
                        },
                        child: Ink(
                            width: MediaQuery.of(context).size.width,
                            height: fullScreenWidth > 600 ? 100.h : 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: const DecorationImage(
                                image: AssetImage(
                                    'assets/images/backgroundListNoti2@3x.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Image(
                                    image: const AssetImage(
                                        'assets/images/cardiologyIcon@3x.png'),
                                    height: fullScreenWidth > 600 ? 35.h : 50,
                                    width: fullScreenWidth > 600 ? 30.w : 47,
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Vital Sign',
                                        style: TextStyle(
                                            color: ColorDefaultApp1,
                                            fontSize: font20),
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Text(
                                    '',
                                    style: TextStyle(
                                        color: ColorDefaultApp1,
                                        fontSize: font20),
                                  ),
                                )
                              ],
                            ))))),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                child: Material(
                    child: InkWell(
                        splashColor: ColorDefaultApp0.withOpacity(0.5),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              settings: const RouteSettings(
                                  name: 'TNH_CompareTableLab_Screen'),
                              builder: (context) => CompareTableLabScreen(
                                  data: item.resData.lab,
                                  dataVitalsign: item.resData.vitalsign),
                            ),
                          );
                        },
                        child: Ink(
                            width: MediaQuery.of(context).size.width,
                            height: fullScreenWidth > 600 ? 100.h : 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: const DecorationImage(
                                image: AssetImage(
                                    'assets/images/backgroundListNoti2@3x.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Image(
                                    image: const AssetImage(
                                        'assets/images/labIcon@3x.png'),
                                    height: fullScreenWidth > 600 ? 35.h : 50,
                                    width: fullScreenWidth > 600 ? 30.w : 47,
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'ผลตรวจ Lab',
                                        style: TextStyle(
                                            color: ColorDefaultApp1,
                                            fontSize: font20),
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Text(
                                    '',
                                    style: TextStyle(
                                        color: ColorDefaultApp1,
                                        fontSize: font20),
                                  ),
                                )
                              ],
                            ))))),
          ),
        ],
      ),
    );
  }
}
