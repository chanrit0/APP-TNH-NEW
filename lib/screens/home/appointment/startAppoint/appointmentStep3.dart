import 'package:app_tnh2/controller/api.dart';
import 'package:app_tnh2/screens/home/appointment/widget/alert/alertAppointmentSuccess.dart';
import 'package:app_tnh2/screens/home/appointment/widget/widgetAppointmentCard.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:app_tnh2/widgets/stateScreenDetails.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_tnh2/config/keyStorages.dart';
import 'package:app_tnh2/screens/stores/authStore.dart';
import 'package:app_tnh2/screens/home/appointment/widget/alert/alertFailApi.dart';

class AppointmentStep3Screen extends StatefulWidget {
  DateTime day;
  String time;
  String comment;
  String typeApooint;
  String packageId;
  dynamic apdoctorId;

  AppointmentStep3Screen(this.day, this.time, this.comment, this.typeApooint,
      this.packageId, this.apdoctorId,
      {super.key});

  @override
  State<AppointmentStep3Screen> createState() => _AppointmentStep3ScreenState();
}

class _AppointmentStep3ScreenState extends State<AppointmentStep3Screen> {
  bool statusConfiem = false;
  late Service postService;
  String nameTemp = '';
  String prifileName = '';

  @override
  initState() {
    super.initState();
    postService = Service(context: context);
    loadName();
  }

  Future loadName() async {
    nameTemp = await accessTokenStore(key: KeyStorages.profileName);
    setState(() {
      prifileName = nameTemp;
    });
  }

  Future updateAppointment() async {
    final res = await postService.funSaveAppointmentStep2(
        DateFormat('yyyy-MM-dd', 'th').format(widget.day).toString(),
        widget.time,
        widget.comment,
        widget.typeApooint,
        widget.packageId,
        widget.apdoctorId.resData.apdoctorId.toString());
    if (res != null) {
      if (res.resCode == '00') {
        AlertAppointmentSuccess(context);
      } else {
        alertFailApi(context, res.resMessage);
      }
    } else {
      alertFailApi(context, 'ไม่สามารถทำการนัดหมายได้');
    }
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
                      Expanded(
                        child: Text(
                          'สรุปนัดหมายแพทย์เพื่อตรวจสุขภาพ',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: font20, color: ColorDefaultApp0),
                        ),
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
                        prifileName,
                        widget.day,
                        widget.time,
                        widget.comment,
                        widget.apdoctorId.resData.doctorName,
                        widget.apdoctorId.resData.clinicNameth,
                        widget.apdoctorId.resData.img,
                        widget.apdoctorId.resData.clinicNameth,
                      )
                    ],
                  ))),
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
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
                              onPressed: () async {
                                await accessTokenStore(
                                    key: KeyStorages.tabAppointment,
                                    action: "set",
                                    value: "1".toString());
                                updateAppointment();
                              },
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
                                  Text(
                                    'ส่งคำขอการนัดหมาย',
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
