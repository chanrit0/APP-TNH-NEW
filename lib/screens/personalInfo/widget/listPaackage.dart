import 'package:app_tnh2/styles/colors.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:app_tnh2/screens/home/appointment/startAppoint/appointmentStep1.dart';

class ListPackaage extends StatelessWidget {
  final String companyName;
  final dynamic funGetPackage;
  final bool packageAllow;
  ListPackaage(this.companyName, this.funGetPackage, this.packageAllow,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/backgroundListNoti2@3x.png'),
                        fit: BoxFit.cover),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 130,
                  child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, top: 10, bottom: 10, right: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                settings: const RouteSettings(
                                    name: 'TNH_AppointmentStep1_Screen'),
                                builder: (context) =>
                                    AppointmentStep1Screen(funGetPackage)),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Package ตรวจสุขภาพประจำปีบริษัทคู่สัญญา',
                                          style: TextStyle(
                                              color: ColorDefaultApp0,
                                              fontSize: font20),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          companyName,
                                          style: TextStyle(
                                              color: ColorBtRegister,
                                              fontSize: font16,
                                              fontFamily: 'RSU_light'),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton(
                                onPressed: packageAllow
                                    ? () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              settings: const RouteSettings(
                                                  name:
                                                      'TNH_AppointmentStep1_Screen'),
                                              builder: (context) =>
                                                  AppointmentStep1Screen(
                                                      funGetPackage)),
                                        );
                                      }
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
                                      textAlign: TextAlign.center,
                                      'นัดหมายทันที',
                                      style: TextStyle(
                                          fontSize: font18,
                                          color: Colors.white),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    )
                                  ],
                                )),
                          ],
                        ),
                      )))),
        ),
      ),
    );
  }
}
