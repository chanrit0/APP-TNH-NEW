import 'package:app_tnh2/model/appointment/modelAppointmentPackage.dart';
import 'package:app_tnh2/screens/home/appointment/startAppoint/appointmentStep2.dart';
import 'package:app_tnh2/screens/home/appointment/widget/text/textDetail.dart';
import 'package:app_tnh2/screens/home/appointment/widget/text/textDetailBold.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:app_tnh2/widgets/stateScreenDetails.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:flutter/material.dart'; 
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:intl/intl.dart'; 
import 'package:app_tnh2/plugin/buddhist_datetime_dateformat.dart';

class AppointmentStep1Screen extends StatefulWidget {
  final ModelPackage result;
  const AppointmentStep1Screen(this.result, {super.key});

  @override
  State<AppointmentStep1Screen> createState() => _AppointmentStep1ScreenState();
}

class _AppointmentStep1ScreenState extends State<AppointmentStep1Screen> {
  String images1 = 'assets/images/appointmentImage@3x.png';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                        'นัดหมายแพทย์เพื่อตรวจสุขภาพ',
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
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 40, right: 40, top: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    widget.result.packageName!,
                                    style: TextStyle(
                                        color: ColorDefaultApp1,
                                        fontSize: font20),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 20, right: 20, top: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  child: textDetail('รหัส Package'),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  child:
                                      textDetailBold(widget.result.packageId!),
                                )
                              ],
                            ),
                          ),
                          const Divider(
                            color: ColorDivider,
                            thickness: 1,
                            endIndent: 0,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  child: textDetail('บริษัทคู่สัญญา'),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  child: textDetailBold(
                                      widget.result.companyName!),
                                )
                              ],
                            ),
                          ),
                          const Divider(
                            color: ColorDivider,
                            thickness: 1,
                            endIndent: 0,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  child: textDetail('ระยะเวลา'),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  //'ตั้งแต่ 1 มกราคม 2566 - 31 มีนาคม 2566'
                                  child: textDetailBold(
                                      'ตั้งแต่ ${DateFormat.yMMMd('th').formatInBuddhistCalendarThai(widget.result.startDate)} - ${DateFormat.yMMMd('th').formatInBuddhistCalendarThai(widget.result.endDate)}'),
                                )
                              ],
                            ),
                          ),
                          const Divider(
                            color: ColorDivider,
                            thickness: 1,
                            endIndent: 0,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  child: textDetail('รายการตรวจสุขภาพ'),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: HtmlWidget(
                              widget.result.list,
                              textStyle: const TextStyle(
                                fontFamily: 'RSU_BOLD',
                                fontSize: 18,
                                color: ColorDefaultApp0,
                              ),
                              customStylesBuilder: (element) {
                                return {
                                  'font-size': '18px',
                                };
                              },
                            ),
                            // Html(
                            //     data: widget.result.list,
                            //     shrinkWrap: true,
                            //     // customRenders: {
                            //     //   tableMatcher(): CustomRender.widget(
                            //     //       widget: (context, child) {
                            //     //     return tableRender
                            //     //         .call()
                            //     //         .widget!
                            //     //         .call(context, child);
                            //     //   }),
                            //     // },
                            //     style: {
                            //       "body": Style(
                            //         color: ColorDefaultApp1,
                            //         fontSize: FontSize(18.0.sp),
                            //       ),
                            //     }),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Divider(
                            color: ColorDivider,
                            thickness: 1,
                            endIndent: 0,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  child: textDetail('เงื่อนไข'),
                                )
                              ],
                            ),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 20),
                              child: HtmlWidget(
                                '${widget.result.condition}',
                                textStyle: const TextStyle(
                                  fontFamily: 'RSU_BOLD',
                                  fontSize: 18,
                                  color: ColorDefaultApp0,
                                ),
                                customStylesBuilder: (element) {
                                  return {
                                    'font-size': '18px',
                                  };
                                },
                              )
                              // Html(
                              //     data: widget.result.condition,
                              //     shrinkWrap: true,
                              //     // customRenders: {
                              //     //   tableMatcher(): CustomRender.widget(
                              //     //       widget: (context, child) {
                              //     //     return tableRender
                              //     //         .call()
                              //     //         .widget!
                              //     //         .call(context, child);
                              //     //   }),
                              //     // },
                              //     style: {
                              //       "body": Style(
                              //         color: ColorDefaultApp1,
                              //         fontSize: FontSize(18.0.sp),
                              //       ),
                              //     }),
                              ),
                        ],
                      ),
                    )),
              )),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: SizedBox(
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
                              onPressed: widget.result.packageAllow != null
                                  ? widget.result.packageAllow == true
                                      ? () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  settings: const RouteSettings(
                                                      name:
                                                          'TNH_AppointmentStep2_Screen'),
                                                  builder: (context) =>
                                                      AppointmentStep2Screen(
                                                          "",
                                                          widget.result
                                                              .packageId!)));
                                        }
                                      : null
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorDefaultApp1,
                                shadowColor: ColorDefaultApp1,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                                minimumSize: const Size(double.infinity, 44),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.calendar_month),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'เริ่มนัดหมาย',
                                    style: TextStyle(
                                        fontSize: font18, color: Colors.white),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
