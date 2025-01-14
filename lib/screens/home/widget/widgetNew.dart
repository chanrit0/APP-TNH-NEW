import 'package:app_tnh2/helper/base_service.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class New extends StatelessWidget {
  String image = ''; //รูป
  String title = ''; //ชื่อหัวข้อ
  String detail = ''; //รายละเอียด
  String uri = '';

  New(this.image, this.title, this.detail, this.uri);

  @override
  Widget build(BuildContext context) {
    final fullScreenWidth = MediaQuery.of(context).size.width;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: ElevatedButton(
          onPressed: () async {
            var urllaunchable = await canLaunch(uri);
            if (urllaunchable) {
              await launch(uri);
            } else {
              // ignore: use_build_context_synchronously
              BaseService.showSnackBar(
                  context, 'ไม่มีลิ้งสำหรับดูข้อมูลเพิ่มเติม.');
              print("URL can't be launched. $uri");
            }
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) =>
            //           HeallthArticlesDetailScreen(image, title, detail)),
            // );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorBGNew,
            padding:
                const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
          ),
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: fullScreenWidth > 600
                  ? fullScreenWidth > 750 || fullScreenWidth < 800
                      ? 200.h
                      : 150.h
                  : 110,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                    bottomLeft: Radius.circular(6),
                    bottomRight: Radius.circular(6)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: image != ''
                  ? Row(
                      children: [
                        SizedBox(
                            height: fullScreenWidth > 600
                                ? fullScreenWidth > 750 || fullScreenWidth < 800
                                    ? 200.h
                                    : 150.h
                                : 110,
                            width: fullScreenWidth < 330
                                ? MediaQuery.of(context).size.width * 60 / 100
                                : MediaQuery.of(context).size.width * 55 / 100,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(6),
                                  bottomLeft: Radius.circular(6)),
                              child: Image(
                                image: NetworkImage(image),
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                fit: BoxFit.cover,
                              ),
                            )),
                        Expanded(
                            child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 0, bottom: 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(6),
                                      bottomRight: Radius.circular(6),
                                    ),
                                    color:
                                        image != '' ? ColorBGNew : Colors.grey,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      children: [
                                        Flexible(
                                            flex: 2,
                                            fit: FlexFit.tight,
                                            child: Text(
                                              title,
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: ColorDefaultApp0,
                                                fontSize: font14,
                                              ),
                                            )),
                                        Flexible(
                                            flex: 1,
                                            fit: FlexFit.tight,
                                            child: Row(
                                              children: [
                                                Text(
                                                  'อ่านต่อ ',
                                                  style: TextStyle(
                                                    color: ColorDefaultApp1,
                                                    fontSize: font12,
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.arrow_forward,
                                                  color: ColorDefaultApp1,
                                                  size: 17,
                                                )
                                              ],
                                            )),
                                      ],
                                    ),
                                  ),
                                ))),
                      ],
                    )
                  : const LinearProgressIndicator())),
    );
  }
}
