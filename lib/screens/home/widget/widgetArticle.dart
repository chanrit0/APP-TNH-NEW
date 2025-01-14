import 'package:app_tnh2/screens/healthArticles/activityNew.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class Article extends StatelessWidget {
  String? urlImage = ''; //รูป
  String? category = ''; //ชื่อหัวข้อ
  String? cateId = ''; //ไอดี
  Color colorBox = ColorDefaultApp0; //สี

  Article({
    super.key,
    required this.urlImage,
    required this.category,
    required this.cateId,
  });

  @override
  Widget build(BuildContext context) {
    final fullScreenWidth = MediaQuery.of(context).size.width;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: SizedBox(
        width: fullScreenWidth > 600
            ? fullScreenWidth > 750 || fullScreenWidth < 800
                ? 80.w
                : 90.w
            : 100,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  settings: const RouteSettings(name: 'TNH_ActivityNew_Screen'),
                  builder: (context) => ActivityNewScreen(
                        cateId ?? '',
                        category ?? '',
                      )),
            );
          },
          child: Column(
            children: [
              urlImage != ''
                  ? Container(
                      height: fullScreenWidth > 600
                          ? fullScreenWidth > 750 || fullScreenWidth < 800
                              ? 80
                              : 70.h
                          : 80,
                      width: fullScreenWidth > 600
                          ? fullScreenWidth > 750 || fullScreenWidth < 800
                              ? 70
                              : 70.w
                          : 80,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                          image: DecorationImage(
                              image: NetworkImage('$urlImage'),
                              onError: (error, stackTrace) => print(error),
                              fit: BoxFit.cover)),
                    )
                  : Container(
                      height: fullScreenWidth > 600
                          ? fullScreenWidth > 750 || fullScreenWidth < 800
                              ? 80
                              : 80.h
                          : 80,
                      width: fullScreenWidth > 600
                          ? fullScreenWidth > 750 || fullScreenWidth < 800
                              ? 70
                              : 70.w
                          : 80,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(70),
                        child: const LinearProgressIndicator(),
                      ),
                    ),
              SizedBox(
                height: fullScreenWidth > 600 ? 10.h : 5,
              ),
              SizedBox(
                height: 33,
                child: category != ''
                    ? Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          textAlign: TextAlign.center,
                          '$category',
                          style: TextStyle(
                              color: ColorDefaultApp0,
                              fontSize: font16,
                              height: 1),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      )
                    : const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: LinearProgressIndicator(),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
