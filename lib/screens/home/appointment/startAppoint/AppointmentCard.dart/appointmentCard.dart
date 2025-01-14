import 'package:app_tnh2/controller/api.dart';
import 'package:app_tnh2/model/appointment/modelAppointment.dart';
import 'package:app_tnh2/screens/home/appointment/startAppoint/AppointmentCard.dart/checklist.dart';
import 'package:app_tnh2/screens/home/appointment/widget/alert/alertCancelAppointment.dart';
import 'package:app_tnh2/screens/home/appointment/widget/widgetAppointmentCard.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:app_tnh2/widgets/stateScreenDetails.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:app_tnh2/screens/home/appointment/startAppoint/appointmentStep2.dart';
import 'package:intl/intl.dart';

class AppointmentCardScreen extends StatefulWidget {
  final ResAppointment item;
  final String page;
  const AppointmentCardScreen(this.item, this.page, {super.key});

  @override
  State<AppointmentCardScreen> createState() => _AppointmentCardScreenState();
}

class _AppointmentCardScreenState extends State<AppointmentCardScreen> {
  late Service postService;
  late DateTime date;
  @override
  initState() {
    super.initState();
    postService = Service(context: context);
    DateTime now = DateTime.now();
    date = DateTime(now.year, now.month, now.day);
  }

  Future cancleAppointment() async {
    alertCancelAppointment(context, false, postService, widget.item.apmbId);
  }

  Future postponeAppointment() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            settings: const RouteSettings(name: 'TNH_AppointmentStep2_Screen'),
            builder: (context) =>
                AppointmentStep2Screen(widget.item.apmbId.toString(), '')));
  }

  @override
  Widget build(BuildContext context) {
    final fullScreenWidth = MediaQuery.of(context).size.width;
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
                        'ใบนัด',
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
          Flexible(
            flex: 5,
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      WidgetAppointmentCard(
                        widget.item.name,
                        widget.item.date,
                        widget.item.time,
                        widget.item.detail,
                        widget.item.doctorName,
                        widget.item.clinicNameth,
                        widget.item.img,
                        widget.item.workplace,
                      ),
                      (widget.item.status == '0' ||
                              (widget.item.status == '1' &&
                                  DateFormat('yyyy-MM-dd')
                                          .format(date)
                                          .compareTo(DateFormat('yyyy-MM-dd')
                                              .format(widget.item.date)) <=
                                      0) ||
                              widget.item.status == '3')
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10, top: 10),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: fullScreenWidth < 330 ? 1 : 3,
                                    fit: FlexFit.tight,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          cancleAppointment();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: ColorBtRegister,
                                          shadowColor: ColorBtRegister,
                                          elevation: 3,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          minimumSize:
                                              const Size(double.infinity, 44),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                'ขอยกเลิกนัด',
                                                style: TextStyle(
                                                    fontSize: font18,
                                                    color: Colors.white),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    flex: fullScreenWidth < 330 ? 1 : 4,
                                    fit: FlexFit.tight,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          postponeAppointment();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: ColorDefaultApp1,
                                          shadowColor: ColorDefaultApp1,
                                          elevation: 3,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          minimumSize:
                                              const Size(double.infinity, 44),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                'ขอเลื่อนนัด',
                                                style: TextStyle(
                                                    fontSize: font18,
                                                    color: Colors.white),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            )
                                          ],
                                        )),
                                  )
                                ],
                              ),
                            )
                          : Container(),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ))),
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: (widget.item.status == '1')
                ? SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            right: 20.0,
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                ElevatedButton(
                                    onPressed: widget.item.packageCode == ''
                                        ? null
                                        : () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    settings: const RouteSettings(
                                                        name:
                                                            'TNH_CheckList_Screen'),
                                                    builder: (context) =>
                                                        CheckListScreen(
                                                            apmbId: widget
                                                                .item.apmbId)));
                                          },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: ColorDefaultApp1,
                                      shadowColor: ColorDefaultApp1,
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      minimumSize:
                                          const Size(double.infinity, 44),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'ดูรายการตรวจ',
                                          style: TextStyle(
                                              fontSize: font18,
                                              color: Colors.white),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
          )
        ],
      )),
    );
  }
}
