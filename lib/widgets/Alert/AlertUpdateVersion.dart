import 'package:app_tnh2/styles/colors.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

alertUpdateVersion(
    BuildContext context, Function onPressed, String device, String uri) {
  AlertDialog alert = AlertDialog(
    content: MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: SizedBox(
          height: 330,
          width: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Image(
                        image: AssetImage('assets/images/updateVersion@3x.png'),
                        height: 100,
                        width: 120,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        'Version ใหม่พร้อมใช้งานแล้ว',
                        style: TextStyle(
                            color: ColorBtRegister,
                            fontFamily: 'RSU_BOLD',
                            fontSize: font30),
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        'กรุณาอัปเดตแอปพลิเคชันของทางโรงพยาบาล',
                        style: TextStyle(
                            color: ColorDefaultApp0,
                            fontFamily: 'RSU_BOLD',
                            fontSize: font18),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 0,
                fit: FlexFit.tight,
                child: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 0.0,
                          right: 0.0,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  var urllaunchable = await canLaunch(uri);
                                  if (urllaunchable) {
                                    await launch(uri);
                                  } else {
                                    print("URL can't be launched. $uri");
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorDefaultApp1,
                                  shadowColor: ColorDefaultApp1,
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                  minimumSize: const Size(double.infinity, 44),
                                ),
                                child: Text(
                                  'อัปเดตทันที',
                                  style: TextStyle(
                                      fontSize: font18, color: Colors.white),
                                ),
                              ),
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
    ),
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  ).then((value) => onPressed());
}
