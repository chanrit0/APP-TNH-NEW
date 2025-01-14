import 'package:app_tnh2/styles/colors.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListDataPerson extends StatelessWidget {
  final String image;
  final String titel;
  final String detail;
  const ListDataPerson({
    super.key,
    required this.image,
    required this.titel,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    final fullScreenWidth = MediaQuery.of(context).size.width;
    
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Image(
                    image: AssetImage(image),
                    height: fullScreenWidth > 600 ? 21.h : 21,
                    width: fullScreenWidth > 600 ? 21.w : 21,
                  ),
                ),
              ),
              Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Text(
                              titel,
                              style: TextStyle(
                                  color: ColorDefaultApp0, fontSize: font18),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text(detail,
                              style: TextStyle(
                                  color: ColorDefaultApp1, fontSize: font20)),
                        ],
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
