import 'dart:convert';

import 'package:app_tnh2/controller/api.dart';
import 'package:app_tnh2/helper/checkDate.dart';
import 'package:app_tnh2/model/noti/modelNoti.dart';
import 'package:app_tnh2/provider/providerHome.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:app_tnh2/widgets/stateScreenDetails.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

class NotiScreen extends StatefulWidget {
  const NotiScreen({super.key});

  @override
  State<NotiScreen> createState() => _NotiScreenState();
}

class _NotiScreenState extends State<NotiScreen> {
  int notiSelect = 0; //เลือก tab
  late Service postService;
  Future<List<NotiData>?>? calApi;
  String fake = '';

  //อ่าน
  void updateNoti(id, type) {
    postService.funUpDateNoti(id, type).then((value) => {
          if (value?.resCode == '00')
            {
              calApi = postService.funGetNoti(),
              setState(() {
                fake = '123';
              })
            }
        });
    postService.funGetNotiCount().then((value) => {
          if (value?.resCode == '00')
            {
              Provider.of<ProviderHome>(context, listen: false).setNotiCount =
                  value?.resData?.count
            }
          else
            {print('Noti Count Error!')}
        });
  }

  //ลบรายการ noti
  void onDismissed(id, type) {
    postService.funUpDateNoti(id, type).then((value) => {
          if (value?.resCode == '00')
            {
              calApi = postService.funGetNoti(),
              setState(() {
                fake = '456';
              })
            }
        });
  }

  @override
  void initState() {
    super.initState();
    postService = Service(context: context);
    initializeDateFormatting();
    calApi = postService.funGetNoti();
  }

  @override
  Widget build(BuildContext context) {
    final fullScreenWidth = MediaQuery.of(context).size.width;
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
                          'การแจ้งเตือน',
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
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 25, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() => {notiSelect = 0});
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          notiSelect == 0 ? ColorBtRegister : Colors.white,
                      shadowColor: ColorDefaultApp1,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      minimumSize: Size(fullScreenWidth < 330 ? 130 : 140, 44),
                    ),
                    child: Text(
                      'ทั้งหมด',
                      style: TextStyle(
                          fontSize: font18,
                          color:
                              notiSelect == 0 ? Colors.white : ColorBtRegister),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          notiSelect == 1 ? ColorBtRegister : Colors.white,
                      elevation: 3,
                      shadowColor: ColorDefaultApp1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      minimumSize: Size(fullScreenWidth < 330 ? 130 : 140, 44),
                    ),
                    onPressed: () {
                      setState(() => {notiSelect = 1});
                    },
                    child: Text(
                      'ยังไม่ได้อ่าน',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: font18,
                          color:
                              notiSelect == 0 ? ColorBtRegister : Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Center(
                child: FutureBuilder(
                  future: calApi,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      List<NotiData> data = snapshot.data;
                      if (data.isEmpty) {
                        return tabNotData();
                      } else {
                        return ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              NotiData item = data[index];
                              return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 10, bottom: 10),
                                  child: notiSelect == 0
                                      ? item.status == 1 || item.status == 0
                                          ? InkWell(
                                              onTap: () {
                                                updateNoti(item.id, 1);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.1),
                                                      spreadRadius: 0,
                                                      blurRadius: 7,
                                                      offset:
                                                          const Offset(0, 0),
                                                    ),
                                                  ],
                                                ),
                                                height: fullScreenWidth < 330
                                                    ? 130
                                                    : 120,
                                                child: Slidable(
                                                  key: ValueKey(index),
                                                  endActionPane: ActionPane(
                                                    motion:
                                                        const ScrollMotion(),
                                                    children: [
                                                      SlidableAction(
                                                        onPressed: (context) =>
                                                            onDismissed(
                                                                item.id, 2),
                                                        backgroundColor:
                                                            Colors.red,
                                                        foregroundColor:
                                                            Colors.white,
                                                        icon: Icons.delete,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10, top: 0),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    5)),
                                                        child: Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                              image:
                                                                  DecorationImage(
                                                                image: AssetImage(
                                                                    'assets/images/backgroundListNoti2@3x.png'),
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                            width:
                                                                double.infinity,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 20,
                                                                      right:
                                                                          20),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Flexible(
                                                                        flex: 1,
                                                                        fit: FlexFit
                                                                            .tight,
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Expanded(
                                                                              child: Text(
                                                                                '${item.title}',
                                                                                overflow: TextOverflow.ellipsis,
                                                                                maxLines: 1,
                                                                                style: TextStyle(color: ColorDefaultApp0, fontSize: font20),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Flexible(
                                                                          flex:
                                                                              0,
                                                                          fit: FlexFit
                                                                              .tight,
                                                                          child: item.status == 0
                                                                              ? const Icon(
                                                                                  Icons.circle,
                                                                                  color: Color(0xffff6742),
                                                                                  size: 10,
                                                                                )
                                                                              : const SizedBox()),
                                                                    ],
                                                                  ),
                                                                  Container(
                                                                    child: fullScreenWidth <
                                                                            330
                                                                        ? Column(
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  Text(
                                                                                    'วันที่ ',
                                                                                    style: TextStyle(color: ColorDefaultApp0, fontSize: font18),
                                                                                  ),
                                                                                  Text(
                                                                                    item.date != null ? '${item.date!.day} ${CheckDate.mounth(item.date!.month)} ${CheckDate.year(item.date!.year)}' : 'ไม่มีวันที่',
                                                                                    style: TextStyle(color: ColorBtRegister, fontSize: font18, fontFamily: 'RSU_light'),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Text(
                                                                                    'เวลา ',
                                                                                    style: TextStyle(color: ColorDefaultApp0, fontSize: font18),
                                                                                  ),
                                                                                  Text(
                                                                                    item.time != null ? '${item.time!.split(':')[0]}:${item.time!.split(':')[1]} น.' : 'ไม่มีเวลา',
                                                                                    style: TextStyle(color: ColorBtRegister, fontSize: font18, fontFamily: 'RSU_light'),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          )
                                                                        : Row(
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  Text(
                                                                                    'วันที่ ',
                                                                                    style: TextStyle(color: ColorDefaultApp0, fontSize: font18),
                                                                                  ),
                                                                                  Text(
                                                                                    item.date != null ? '${item.date!.day} ${CheckDate.mounth(item.date!.month)} ${CheckDate.year(item.date!.year)}' : 'ไม่มีวันที่',
                                                                                    style: TextStyle(color: ColorBtRegister, fontSize: font18, fontFamily: 'RSU_light'),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              const SizedBox(
                                                                                width: 30,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Text(
                                                                                    'เวลา ',
                                                                                    style: TextStyle(color: ColorDefaultApp0, fontSize: font18),
                                                                                  ),
                                                                                  Text(
                                                                                    item.time != null ? '${item.time!.split(':')[0]}:${item.time!.split(':')[1]} น.' : 'ไม่มีเวลา',
                                                                                    style: TextStyle(color: ColorBtRegister, fontSize: font18, fontFamily: 'RSU_light'),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      const Image(
                                                                        image: AssetImage(
                                                                            'assets/icons/environment-anticon@3x.png'),
                                                                        height:
                                                                            13,
                                                                        width:
                                                                            12,
                                                                      ),
                                                                      Text(
                                                                        ' ${item.department ?? 'ไม่มีข้อมูล'}',
                                                                        style: TextStyle(
                                                                            color:
                                                                                ColorBtRegister,
                                                                            fontSize:
                                                                                font18,
                                                                            fontFamily:
                                                                                'RSU_light'),
                                                                      ),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ))),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : const SizedBox()
                                      : item.status == 0
                                          ? InkWell(
                                              onTap: () {
                                                updateNoti(item.id, 1);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.1),
                                                      spreadRadius: 0,
                                                      blurRadius: 7,
                                                      offset:
                                                          const Offset(0, 0),
                                                    ),
                                                  ],
                                                ),
                                                height: fullScreenWidth < 330
                                                    ? 130
                                                    : 120,
                                                child: Slidable(
                                                  key: ValueKey(index),
                                                  endActionPane: ActionPane(
                                                    motion:
                                                        const ScrollMotion(),
                                                    children: [
                                                      SlidableAction(
                                                        onPressed: (context) =>
                                                            onDismissed(
                                                                item.id, 2),
                                                        backgroundColor:
                                                            Colors.red,
                                                        foregroundColor:
                                                            Colors.white,
                                                        icon: Icons.delete,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10, top: 0),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    5)),
                                                        child: Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: AssetImage(
                                                                      'assets/images/backgroundListNoti2@3x.png'),
                                                                  fit: BoxFit
                                                                      .cover),
                                                            ),
                                                            width:
                                                                double.infinity,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 20,
                                                                      right:
                                                                          20),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Flexible(
                                                                        flex: 1,
                                                                        fit: FlexFit
                                                                            .tight,
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Expanded(
                                                                              child: Text(
                                                                                '${item.title}',
                                                                                overflow: TextOverflow.ellipsis,
                                                                                maxLines: 1,
                                                                                style: TextStyle(color: ColorDefaultApp0, fontSize: font20),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Flexible(
                                                                          flex:
                                                                              0,
                                                                          fit: FlexFit
                                                                              .tight,
                                                                          child: item.status == 0
                                                                              ? const Icon(
                                                                                  Icons.circle,
                                                                                  color: Color(0xffff6742),
                                                                                  size: 10,
                                                                                )
                                                                              : const SizedBox()),
                                                                    ],
                                                                  ),
                                                                  Container(
                                                                    child: fullScreenWidth <
                                                                            330
                                                                        ? Column(
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  Text(
                                                                                    'วันที่ ',
                                                                                    style: TextStyle(color: ColorDefaultApp0, fontSize: font18),
                                                                                  ),
                                                                                  Text(
                                                                                    item.date != null ? '${item.date!.day} ${CheckDate.mounth(item.date!.month)} ${CheckDate.year(item.date!.year)}' : 'ไม่มีวันที่',
                                                                                    style: TextStyle(color: ColorBtRegister, fontSize: font18, fontFamily: 'RSU_light'),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Text(
                                                                                    'เวลา ',
                                                                                    style: TextStyle(color: ColorDefaultApp0, fontSize: font18),
                                                                                  ),
                                                                                  Text(
                                                                                    item.time != null ? '${item.time!.split(':')[0]}:${item.time!.split(':')[1]} น.' : 'ไม่มีเวลา',
                                                                                    style: TextStyle(color: ColorBtRegister, fontSize: font18, fontFamily: 'RSU_light'),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          )
                                                                        : Row(
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  Text(
                                                                                    'วันที่ ',
                                                                                    style: TextStyle(color: ColorDefaultApp0, fontSize: font18),
                                                                                  ),
                                                                                  Text(
                                                                                    item.date != null ? '${item.date!.day} ${CheckDate.mounth(item.date!.month)} ${CheckDate.year(item.date!.year)}' : 'ไม่มีวันที่',
                                                                                    style: TextStyle(color: ColorBtRegister, fontSize: font18, fontFamily: 'RSU_light'),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              const SizedBox(
                                                                                width: 30,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Text(
                                                                                    'เวลา ',
                                                                                    style: TextStyle(color: ColorDefaultApp0, fontSize: font18),
                                                                                  ),
                                                                                  Text(
                                                                                    item.time != null ? '${item.time!.split(':')[0]}:${item.time!.split(':')[1]} น.' : 'ไม่มีเวลา',
                                                                                    style: TextStyle(color: ColorBtRegister, fontSize: font18, fontFamily: 'RSU_light'),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      const Image(
                                                                        image: AssetImage(
                                                                            'assets/icons/environment-anticon@3x.png'),
                                                                        height:
                                                                            13,
                                                                        width:
                                                                            12,
                                                                      ),
                                                                      Text(
                                                                        ' ${item.department ?? 'ไม่มีข้อมูล'}',
                                                                        style: TextStyle(
                                                                            color:
                                                                                ColorBtRegister,
                                                                            fontSize:
                                                                                font18,
                                                                            fontFamily:
                                                                                'RSU_light'),
                                                                      ),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ))),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : const SizedBox());
                            });
                      }
                    } else {
                      return const Center(
                          child: SpinKitRing(color: ColorDefaultApp1));
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //tab ไม่มีข้อมูล
  Column tabNotData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'ไม่มีรายการ',
          style: TextStyle(color: Colors.grey, fontSize: font20),
        )
      ],
    );
  }
}
