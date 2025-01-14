import 'package:app_tnh2/styles/colors.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:app_tnh2/screens/home/appointment/startAppoint/AppointmentCard.dart/appointmentCard.dart';
import 'package:app_tnh2/plugin/buddhist_datetime_dateformat.dart';

class LatestAppointment extends StatelessWidget {
  dynamic item;
  LatestAppointment(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    final fullScreenWidth = MediaQuery.of(context).size.width;
    
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          'assets/images/backgroundAppointItem@3x.png'),
                      fit: BoxFit.cover),
                ),
                width: MediaQuery.of(context).size.width,
                height: fullScreenWidth > 600 ? 100.h : 120,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            settings: const RouteSettings(
                                name: 'TNH_AppointmentCard_Screen'),
                            builder: (context) =>
                                AppointmentCardScreen(item, '0')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                    top: fullScreenWidth > 600 ? 20 : 10),
                                child: Row(
                                  children: [
                                    Flexible(
                                        flex: 3,
                                        fit: FlexFit.tight,
                                        child: Text(
                                          'คุณมีนัดตรวจสุขภาพใหม่',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: font20,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        )),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 10),
                                child: Row(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: Row(
                                        children: [
                                          Text(
                                            'วันที่  ',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: font18),
                                          ),
                                          Text(
                                            DateFormat('d MMM y', 'th')
                                                .formatInBuddhistCalendarThai(
                                                    item.date)
                                                .toString(),
                                            style: TextStyle(
                                                color: ColorGreyishTeal,
                                                fontSize: font18),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                        flex: 1,
                                        fit: FlexFit.tight,
                                        child: Row(
                                          children: [
                                            Text(
                                              'เวลา  ',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: font18),
                                            ),
                                            Text(
                                              item.time.split(':')[0] +
                                                  ':' +
                                                  item.time.split(':')[1] +
                                                  ' น.',
                                              style: TextStyle(
                                                  color: ColorGreyishTeal,
                                                  fontSize: font18),
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 20, top: 10),
                                child: Row(
                                  children: [
                                    const Image(
                                      image: AssetImage(
                                          'assets/icons/environment-anticon@3x.png'),
                                      height: 13,
                                      width: 12,
                                    ),
                                    Flexible(
                                        flex: 1,
                                        fit: FlexFit.tight,
                                        child: Row(
                                          children: [
                                            Text(
                                              ' ${item.workplace}',
                                              style: TextStyle(
                                                  color: ColorGreyishTeal,
                                                  fontSize: font18),
                                            )
                                          ],
                                        ))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ))),
          )),
    );
  }
}
