import 'dart:async';

import 'package:app_tnh2/controller/api.dart';
import 'package:app_tnh2/model/contact/modelContact.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:app_tnh2/widgets/stateScreenDetails.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  static Color nameColorCompany = ColorDefaultApp1;
  static Color nameColorAddress = ColorDefaultApp0;
  late WebViewController controller;
  double height = 490;
  double width = 970;
  late Service postService;
  dynamic funGetContact = '';

  void _launchUrl(uri) async {
    // final Uri url = Uri.parse(uri);
    // if (!await launchUrl(url)) {
    //   throw 'Could not launch $url';
    // }
    var urllaunchable = await canLaunch(uri);
    if (urllaunchable) {
      await launch(uri);
    } else {
      print("URL can't be launched. $uri");
    }
  }

  @override
  void initState() {
    super.initState();
    postService = Service(context: context);
    funGetContact = postService.funGetContact();
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
                          'ติดต่อเรา',
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
              flex: 1,
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: FutureBuilder(
                  future: funGetContact,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      var item = snapshot.data;
                      if (item == null) {
                        return const SizedBox();
                      }
                      return conatct(item.resData);
                    }
                    return const Center(
                        child: SpinKitRing(color: ColorDefaultApp1));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox conatct(
    Contct item,
  ) {
    final fullScreenWidth = MediaQuery.of(context).size.width;
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.dataFromString('<html><body>${item.googlemap}</body></html>',
            mimeType: 'text/html'),
      );
    return SizedBox(
      child: SingleChildScrollView(
          child: Column(
        children: [
          Stack(
            children: [
              Padding(
                  padding:
                      EdgeInsets.only(top: fullScreenWidth > 600 ? 150.h : 150),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 400,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/backgroundHome@3x.png'),
                            fit: BoxFit.cover),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: const [
                              SizedBox(
                                height: 50,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                '${item.hospital}',
                                style: TextStyle(
                                    color: nameColorCompany, fontSize: font20),
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                '${item.address}',
                                style: TextStyle(
                                    color: nameColorAddress, fontSize: font20),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Image(
                                      image: const AssetImage(
                                          'assets/icons/phone-anticon@3x.png'),
                                      height: fullScreenWidth > 600 ? 21.h : 21,
                                      width: fullScreenWidth > 600 ? 21.w : 21,
                                    ),
                                  ),
                                  Text(
                                    textAlign: TextAlign.center,
                                    '  ${item.phone?[0]},${item.phone?[1]}',
                                    style: TextStyle(
                                        color: nameColorAddress,
                                        fontSize: font20),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image: const AssetImage(
                                        'assets/icons/printer-anticon@3x.png'),
                                    height: fullScreenWidth > 600 ? 21.h : 21,
                                    width: fullScreenWidth > 600 ? 21.w : 21,
                                  ),
                                  Text(
                                    textAlign: TextAlign.center,
                                    '  ${item.fax}',
                                    style: TextStyle(
                                        color: nameColorAddress,
                                        fontSize: font20),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image: const AssetImage(
                                        'assets/icons/mail-anticon@3x.png'),
                                    height: fullScreenWidth > 600 ? 21.h : 21,
                                    width: fullScreenWidth > 600 ? 21.w : 21,
                                  ),
                                  Text(
                                    textAlign: TextAlign.center,
                                    '  ${item.email}',
                                    style: TextStyle(
                                        color: nameColorAddress,
                                        fontSize: font20),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  _launchUrl(item.facebook);
                                },
                                child: Image(
                                  image: const AssetImage(
                                      'assets/icons/facebook@3x.png'),
                                  height: fullScreenWidth > 600 ? 30.h : 30,
                                  width: fullScreenWidth > 600 ? 30.w : 30,
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              InkWell(
                                onTap: () {
                                  _launchUrl(item.ig);
                                },
                                child: Image(
                                  image: const AssetImage(
                                      'assets/icons/ig@3x.png'),
                                  height: fullScreenWidth > 600 ? 30.h : 30,
                                  width: fullScreenWidth > 600 ? 30.w : 30,
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              InkWell(
                                onTap: () {
                                  _launchUrl(item.twitter);
                                },
                                child: Image(
                                  image: const AssetImage(
                                      'assets/icons/twitter@3x.png'),
                                  height: fullScreenWidth > 600 ? 30.h : 30,
                                  width: fullScreenWidth > 600 ? 30.w : 30,
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              InkWell(
                                onTap: () {
                                  _launchUrl(item.line);
                                },
                                child: Image(
                                  image: const AssetImage(
                                      'assets/icons/line@3x.png'),
                                  height: fullScreenWidth > 600 ? 30.h : 30,
                                  width: fullScreenWidth > 600 ? 30.w : 30,
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              InkWell(
                                onTap: () {
                                  _launchUrl(item.youtube);
                                },
                                child: Image(
                                  image: const AssetImage(
                                      'assets/icons/youtube@3x.png'),
                                  height: fullScreenWidth > 600 ? 30.h : 30,
                                  width: fullScreenWidth > 600 ? 30.w : 30,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )),
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Image(
                      image: const AssetImage('assets/images/contact@3x.png'),
                      width: fullScreenWidth > 600 ? 230.w : 257,
                      height: fullScreenWidth > 600 ? 220.h : 250,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: fullScreenWidth > 600 ? 250.h : 180,
            child: WebViewWidget(
              controller: controller,
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      )),
    );
  }
}
