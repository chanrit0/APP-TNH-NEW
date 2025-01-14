import 'package:app_tnh2/styles/colors.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_tnh2/plugin/buddhist_datetime_dateformat.dart';

class WidgetAppointmentCard extends StatelessWidget {
  final String name;
  final DateTime day;
  final String time;
  final String detail;
  final String physician;
  final String building;
  final String img;
  final String workplace;
  const WidgetAppointmentCard(this.name, this.day, this.time, this.detail,
      this.physician, this.building, this.img, this.workplace,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final fullScreenWidth = MediaQuery.of(context).size.width;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                  child: Image(
                    image: const AssetImage('assets/images/imageDrawer@3x.png'),
                    height: 60,
                    width: fullScreenWidth < 330 ? 220 : 280,
                  ),
                )
              ],
            ),
          ),
          const Divider(
            color: ColorDivider,
            thickness: 1,
            endIndent: 0,
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Row(
              children: [
                Text(
                  'คุณ $name',
                  style: TextStyle(color: ColorDefaultApp1, fontSize: font20),
                ),
              ],
            ),
          ),
          const Divider(
            color: ColorDivider,
            thickness: 1,
            endIndent: 0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Row(
              children: [
                Text(
                  'วันที่นัดหมาย',
                  style: TextStyle(color: ColorDefaultApp1, fontSize: font18),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Image(
                  image:
                      AssetImage('assets/icons/calendar-simple-green@3x.png'),
                  height: 20,
                  width: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  DateFormat('EEEE, d MMMM y', 'th')
                      .formatInBuddhistCalendarThai(day),
                  style: TextStyle(color: ColorDefaultApp0, fontSize: font18),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Row(
              children: [
                Text(
                  'เวลาที่นัดหมาย',
                  style: TextStyle(color: ColorDefaultApp1, fontSize: font18),
                )
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Image(
                  image:
                      AssetImage('assets/icons/clock-simple-line-icons@3x.png'),
                  height: 20,
                  width: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '${time.split(':')[0]} : ${time.split(':')[1]} น.',
                  style: TextStyle(color: ColorDefaultApp0, fontSize: font18),
                )
              ],
            ),
          ),
          const Divider(
            color: ColorDivider,
            thickness: 1,
            endIndent: 0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Row(
              children: [
                Text(
                  'รายละเอียดเพิ่มเติม',
                  style: TextStyle(color: ColorDefaultApp1, fontSize: font18),
                )
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Image(
                  image: AssetImage(
                      'assets/icons/speech-simple-line-icons@3x.png'),
                  height: 20,
                  width: 20,
                ),
                const SizedBox(width: 10),
                Flexible(
                    child: Text(
                  detail != '' ? detail : '-',
                  style: TextStyle(color: ColorDefaultApp0, fontSize: font18),
                ))
              ],
            ),
          ),
          const Divider(
            color: ColorDivider,
            thickness: 1,
            endIndent: 0,
          ),
          physician != ''
              ? Padding(
                  padding: EdgeInsets.only(
                      left: fullScreenWidth < 330 ? 15 : 0, right: 0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 70,
                    child: Row(
                      children: [
                        Flexible(
                            flex: 1,
                            fit: FlexFit.tight, //article@3x.png
                            child: img != ''
                                ? Container(
                                    height: 60.0,
                                    width: 60.0,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: NetworkImage(img),
                                            onError: (error, stackTrace) =>
                                                print(error),
                                            fit: BoxFit.cover)),
                                  )
                                : Container(
                                    height: 60.0,
                                    width: 60.0,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/icons/user-anticon2@3x.png'),
                                            fit: BoxFit.contain)),
                                  )),
                        Flexible(
                            flex: 3,
                            fit: FlexFit.tight,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                physician == 'ไม่ระบุ'
                                    ? const SizedBox()
                                    : Row(
                                        children: [
                                          Text(
                                            physician,
                                            style: TextStyle(
                                                color: ColorDefaultApp1,
                                                fontSize: font18),
                                          ),
                                        ],
                                      ),
                                Row(
                                  children: [
                                    Text(
                                      workplace,
                                      style: TextStyle(
                                          color: const Color(0xffababab),
                                          fontSize: font18),
                                    ),
                                  ],
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                )
              : const SizedBox(
                  height: 0,
                ),
          physician != ''
              ? const Divider(
                  color: ColorDivider,
                  thickness: 1,
                  endIndent: 0,
                )
              : const SizedBox(
                  height: 0,
                ),
          building != ''
              ? Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Row(
                    children: [
                      Text(
                        'สถานที่นัดหมาย',
                        style: TextStyle(
                            color: ColorDefaultApp1, fontSize: font18),
                      ),
                    ],
                  ),
                )
              : const SizedBox(
                  height: 0,
                ),
          building != ''
              ? Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 17),
                  child: Row(
                    children: [
                      const Image(
                        image: AssetImage(
                            'assets/icons/environment-anticon@3x.png'),
                        height: 20,
                        width: 20,
                      ),
                      Text(
                        '  $building',
                        style: TextStyle(
                            color: ColorDefaultApp0, fontSize: font18),
                      )
                    ],
                  ),
                )
              : const SizedBox(
                  height: 0,
                ),
        ],
      ),
    );
  }
}
