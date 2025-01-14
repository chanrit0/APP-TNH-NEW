import 'package:app_tnh2/helper/checkDate.dart';
import 'package:app_tnh2/model/healthResult/modelHealthReport.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:flutter/material.dart';

class ItemHealthResult0 extends StatelessWidget {
  final ResHealthReport item;
  final String img;
  final int tab;
  const ItemHealthResult0(
      {super.key, required this.item, required this.img, required this.tab});

  @override
  Widget build(BuildContext context) {
    final fullScreenWidth = MediaQuery.of(context).size.width;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(img), fit: BoxFit.cover),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 140,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 10),
                                child: Row(
                                  children: [
                                    Flexible(
                                        flex: 1,
                                        fit: FlexFit.tight,
                                        child: Text(
                                          '${item.name}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: font20,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        )),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                    top: fullScreenWidth < 330 ? 0 : 10),
                                child: fullScreenWidth < 330
                                    ? Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'วันที่ ',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: font18),
                                              ),
                                              Text(
                                                '${item.visitDate.day} ${CheckDate.mounth(item.visitDate.month)} ${CheckDate.year(item.visitDate.year)}',
                                                style: TextStyle(
                                                    color: tab == 0
                                                        ? ColorGreyishTeal
                                                        : ColorDefaultApp0,
                                                    fontSize: font18),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'เวลา ',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: font18),
                                              ),
                                              Text(
                                                '${item.time!.split(':')[0]}:${item.time!.split(':')[1]}',
                                                style: TextStyle(
                                                    color: tab == 0
                                                        ? ColorGreyishTeal
                                                        : ColorDefaultApp0,
                                                    fontSize: font18),
                                              ),
                                              Text(
                                                ' น.',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: font18),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          Flexible(
                                            flex: 2,
                                            fit: FlexFit.tight,
                                            child: Row(
                                              children: [
                                                Text(
                                                  'วันที่ ',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: font18),
                                                ),
                                                Text(
                                                  '${item.visitDate.day} ${CheckDate.mounth(item.visitDate.month)} ${CheckDate.year(item.visitDate.year)}',
                                                  style: TextStyle(
                                                      color: tab == 0
                                                          ? ColorGreyishTeal
                                                          : ColorDefaultApp0,
                                                      fontSize: font18),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                              flex: 1,
                                              fit: FlexFit.tight,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    'เวลา ',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: font18),
                                                  ),
                                                  Text(
                                                    '${item.time!.split(':')[0]}:${item.time!.split(':')[1]}',
                                                    style: TextStyle(
                                                        color: tab == 0
                                                            ? ColorGreyishTeal
                                                            : ColorDefaultApp0,
                                                        fontSize: font18),
                                                  ),
                                                  Text(
                                                    ' น.',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: font18),
                                                  ),
                                                ],
                                              ))
                                        ],
                                      ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                    top: fullScreenWidth < 330 ? 0 : 10),
                                child: Row(
                                  children: [
                                    Text(
                                      '${item.docterName}',
                                      style: TextStyle(
                                          color: tab == 0
                                              ? ColorGreyishTeal
                                              : ColorDefaultApp0,
                                          fontSize: font18),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ))),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 130, left: 20, right: 20),
            child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                  color: Colors.white,
                ),
                width: double.infinity,
                height: fullScreenWidth < 330 ? 70 : 50,
                child: Column(
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: Container(
                            child: fullScreenWidth < 330
                                ? Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Check up No. : ${item.requestNo}',
                                            style: TextStyle(
                                                color: ColorDefaultApp1,
                                                fontSize: font18),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'VN : ${item.vn}',
                                            style: TextStyle(
                                                color: ColorDefaultApp1,
                                                fontSize: font18),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        fit: FlexFit.tight,
                                        flex: 2,
                                        child: Text(
                                          'Check up No. : ${item.requestNo}',
                                          style: TextStyle(
                                              color: ColorDefaultApp1,
                                              fontSize: font18),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Flexible(
                                        fit: FlexFit.tight,
                                        flex: 1,
                                        child: Text(
                                          'VN : ${item.vn}',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: ColorDefaultApp1,
                                              fontSize: font18),
                                        ),
                                      ),
                                    ],
                                  )),
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
