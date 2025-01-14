import 'package:app_tnh2/styles/colors.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonHeader extends StatelessWidget {
  final String name;
  final String subName;
  final Function getImage;
  final Widget imageFun;
  const PersonHeader({
    super.key,
    required this.name,
    required this.subName,
    required this.getImage,
    required this.imageFun,
  });

  @override
  Widget build(BuildContext context) {
    final fullScreenWidth = MediaQuery.of(context).size.width;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Row(
        children: [
          Flexible(
              flex: 0,
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: SizedBox(
                  child: Stack(
                    children: [
                      imageFun,
                      Positioned(
                          bottom: 0,
                          right: fullScreenWidth > 600 ? -10.w : -5,
                          child: InkWell(
                            onTap: () {
                              getImage();
                            },
                            child: Image(
                              image: const AssetImage(
                                  'assets/icons/camera@3x.png'),
                              height: fullScreenWidth > 600 ? 40.h : 40,
                              width: fullScreenWidth > 600 ? 40.w : 40,
                            ),
                          ))
                    ],
                  ),
                ),
              )),
          Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              color: ColorDefaultApp1, fontSize: font24),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          subName,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              color: ColorDefaultApp1, fontSize: font20),
                        ),
                      ),
                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }
}
