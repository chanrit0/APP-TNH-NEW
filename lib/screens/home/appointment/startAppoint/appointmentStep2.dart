import 'package:app_tnh2/controller/api.dart';
import 'package:app_tnh2/helper/base_service.dart';
import 'package:app_tnh2/screens/home/appointment/startAppoint/appointmentStep3.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:app_tnh2/widgets/stateScreenDetails.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import 'package:app_tnh2/widgets/w_keyboard_dismiss.dart';

class AppointmentStep2Screen extends StatefulWidget {
  String typeApooint;
  String packageId;
  AppointmentStep2Screen(this.typeApooint, this.packageId, {super.key});

  @override
  State<AppointmentStep2Screen> createState() => AppointmentStep2ScreenState();
}

class AppointmentStep2ScreenState extends State<AppointmentStep2Screen> {
  String selectTime_Morning = ""; //เลือกเวลาเช้า
  String more_details = '';
  final _formKey_more_details = GlobalKey<FormState>();

  //data select
  DateTime selectedDate = DateTime.now();
  int currentDateSelectedIndex = 0;
  ScrollController scrollController = ScrollController();
  late AutoScrollController controller;
  final scrollDirection = Axis.horizontal;
  dynamic apiCal = '';
  int apiTime = 0;
  DateTime apiDay = DateTime.now().add(const Duration(days: 0));
  late Service postService;
  /////////////////////////////

  @override
  initState() {
    super.initState();
    controller = AutoScrollController(axis: scrollDirection);
    postService = Service(context: context);
    apiCal = postService.funGetCalendar();
    checkday(apiCal);
  }

  dynamic apiCalx = '';
  checkday(apiCalc) async {
    apiCalx = await apiCalc;
    String aa = "";
    String bb = "";
    List<String> kk = [];
    for (var i = 0; i < apiCalx.length; i++) {
      kk.add(DateFormat('MM-dd').format(apiCalx[i].date).toString());
    }

    for (var i = 0; i < kk.length; i++) {
      if (DateTime.now().add(Duration(days: i)).month.toInt() < 10) {
        aa =
            '0${DateTime.now().add(Duration(days: i)).month.toInt().toString()}';
      } else {
        aa = DateTime.now().add(Duration(days: i)).month.toInt().toString();
      }
      if (DateTime.now().add(Duration(days: i)).day.toInt() < 10) {
        bb = '0${DateTime.now().add(Duration(days: i)).day.toInt().toString()}';
      } else {
        bb = DateTime.now().add(Duration(days: i)).day.toInt().toString();
      }
      String cc = '$aa-$bb';
      String? bar = kk.firstWhereOrNull((item) => item == cc);
      if (bar != null) {
        setState(() => {apiDay = DateTime.now().add(Duration(days: i))});
        setState(
            () => {apiTime = kk.indexWhere((note) => note.startsWith(bar))});
        selectTime_Morning = ""; //เลือกเวลาเช้า
        _selectDate(i);
        break;
      }
    }
  }

  Future updateAppointment(x1, x2, x3, x4, x5) async {
    await postService
        .funSaveAppointmentStep1(
            DateFormat('yyyy-MM-dd', 'th').format(x1).toString(),
            x2,
            x3,
            x4,
            x5)
        .then((res) => {
              if (res.resCode == '00')
                {
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          settings: const RouteSettings(
                              name: 'TNH_AppointmentStep3_Screen'),
                          builder: (context) =>
                              AppointmentStep3Screen(x1, x2, x3, x4, x5, res)))
                }
              else
                {BaseService.showSnackBar(context, '${res.res_text}')}
            });
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: StateScreenDetails(
          child: WKeyboardDismiss(
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
                          'นัดหมายแพทย์เพื่อตรวจสุขภาพ',
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
            const SizedBox(
              height: 20,
            ),
            Flexible(
                flex: 5,
                fit: FlexFit.tight,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 17),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 17),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'เลือกวัน',
                                    style: TextStyle(
                                        color: ColorDefaultApp0,
                                        fontSize: font20),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          _selectDate(3);
                                        },
                                        child: const Image(
                                          image: AssetImage(
                                              'assets/icons/dateleft@3x.png'),
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                      Text(
                                        ' ${selectedDate.day} ${listOfMonths[selectedDate.month - 1]} ${selectedDate.year + 543} ',
                                        style: TextStyle(
                                            color: ColorDefaultApp0,
                                            fontSize: font20),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          _selectDate(29);
                                        },
                                        child: const Image(
                                          image: AssetImage(
                                              'assets/icons/dateRight@3x.png'),
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 110,
                              child: calendarTimeDay(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 17, right: 17, top: 10),
                        child: SizedBox(
                          width: double.infinity,
                          height: 180,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'เลือกช่วงเวลา',
                                    style: TextStyle(
                                        color: ColorDefaultApp0,
                                        fontSize: font20),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'ช่วงเช้า',
                                    style: TextStyle(
                                        color: ColorDefaultApp0,
                                        fontSize: font16),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 120,
                                child: calendarTime('after'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: SizedBox(
                          width: double.infinity,
                          height: 180,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'ช่วงบ่าย',
                                    style: TextStyle(
                                        color: ColorDefaultApp0,
                                        fontSize: font16),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 120,
                                child: calendarTime('befor'),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: SizedBox(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          child: Form(
                              key: _formKey_more_details,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      'รายละเอียดเพิ่มเติม',
                                      style: TextStyle(
                                          color: ColorDefaultApp0,
                                          fontSize: font20),
                                    ),
                                  ),
                                  TextFormField(
                                    onChanged: (value) =>
                                        setState(() => more_details = value),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 0, vertical: 0),
                                      hintText:
                                          'ระบุรายละเอียดเพิ่มเติมเพื่อประโยชน์ในการวินิจฉัย',
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: font18),
                                    ),
                                    textInputAction: TextInputAction.done,
                                    style: TextStyle(
                                        color: ColorDefaultApp0,
                                        fontSize: font20),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      '*เช่นโรคประจำตัว, แพ้ยา, แพ้อาหาร ฯลฯ',
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              110, 91, 90, 93),
                                          fontSize: font12),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      )
                    ],
                  ),
                )),
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
                                onPressed: () {
                                  if (selectTime_Morning != '') {
                                    updateAppointment(
                                        apiDay,
                                        selectTime_Morning,
                                        more_details,
                                        widget.typeApooint,
                                        widget.packageId);
                                  } else {
                                    BaseService.showSnackBar(context,
                                        'กรุณาเลือกช่วงเวลาที่ต้องการนัดหมาย');
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'ดำเนินการต่อ',
                                      style: TextStyle(
                                          fontSize: font18,
                                          color: Colors.white),
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
        ),
      )),
    );
  }

  Container calendarTimeDay() {
    return Container(
        child: FutureBuilder(
      future: apiCal!,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var result = snapshot.data;
          if (result == null) {
            return const SizedBox();
          }
          List<String> k = [];
          for (var i = 0; i < result.length; i++) {
            k.add(DateFormat('MM-dd').format(result[i].date).toString());
          }
          return ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(width: 10);
            },
            itemCount: 30,
            controller: controller,
            scrollDirection: scrollDirection,
            itemBuilder: (BuildContext context, int indexX) {
              int index = indexX + 3;
              String aa = "";
              String bb = "";
              if (DateTime.now().add(Duration(days: index)).month.toInt() <
                  10) {
                aa =
                    "0${DateTime.now().add(Duration(days: index)).month.toInt().toString()}";
              } else {
                aa = DateTime.now()
                    .add(Duration(days: index))
                    .month
                    .toInt()
                    .toString();
              }
              if (DateTime.now().add(Duration(days: index)).day.toInt() < 10) {
                bb =
                    "0${DateTime.now().add(Duration(days: index)).day.toInt().toString()}";
              } else {
                bb = DateTime.now()
                    .add(Duration(days: index))
                    .day
                    .toInt()
                    .toString();
              }
              String cc = '$aa-$bb';

              return _wrapScrollTag(
                index: index,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 1,
                              offset: const Offset(1, 1),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            var bar = k.firstWhereOrNull((item) => item == cc);
                            if (bar != null) {
                              setState(() => {
                                    apiDay = DateTime.now()
                                        .add(Duration(days: index))
                                  });
                              setState(() => {
                                    apiTime = k.indexWhere(
                                        (note) => note.startsWith(bar))
                                  });
                              selectTime_Morning = ""; //เลือกเวลาเช้า
                              _selectDate(index);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: currentDateSelectedIndex == index
                                  ? const Color(0xff29989b)
                                  : k.firstWhereOrNull((item) => item == cc) ==
                                          null
                                      ? const Color(0xffcbcbcb)
                                      : Colors.white,
                              shadowColor: currentDateSelectedIndex == index
                                  ? const Color(0xff005759)
                                  : const Color(0xffcbcbcb),
                              elevation:
                                  currentDateSelectedIndex == index ? 1 : 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              minimumSize: const Size(0, 44),
                              padding: const EdgeInsets.all(0)),
                          child: SizedBox(
                            width: 60,
                            height: 90,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  listOfDays[DateTime.now()
                                              .add(Duration(days: index))
                                              .weekday -
                                          1]
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: font16,
                                      color: currentDateSelectedIndex == index
                                          ? Colors.white
                                          : k.firstWhereOrNull((item) =>
                                                      item.toString() == cc) ==
                                                  null
                                              ? const Color(0xFFababab)
                                              : const Color(0xff29989b)),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  DateTime.now()
                                      .add(Duration(days: index))
                                      .day
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: font44,
                                      height: 1,
                                      fontWeight: FontWeight.w700,
                                      color: currentDateSelectedIndex == index
                                          ? Colors.white
                                          : k.firstWhereOrNull(
                                                      (item) => item == cc) ==
                                                  null
                                              ? const Color(0xFFababab)
                                              : const Color(0xff29989b)),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
              );
            },
          );
        }
        return const LinearProgressIndicator();
      },
    ));
  }

  Widget calendarTime(
    time,
  ) =>
      FutureBuilder(
        future: apiCal!,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data.length == 0) {
              return const SizedBox();
            }
            var resultTem = snapshot.data[apiTime].times;

            var datesplit = DateFormat('yyyy-MM-dd')
                .format(snapshot.data[apiTime].date)
                .split('-');

            final DateTime date1 = DateTime(int.parse(datesplit[0]),
                int.parse(datesplit[1]), int.parse(datesplit[2]), 13, 00);
            final timestamp1 = date1.millisecondsSinceEpoch;
            var result = [];
            if (time == 'after') {
              result = resultTem
                  .where((i) =>
                      timestamp1 >
                      DateTime(
                              int.parse(datesplit[0]),
                              int.parse(datesplit[1]),
                              int.parse(datesplit[2]),
                              int.parse(i.time.split(':')[0]),
                              int.parse(i.time.split(':')[1]))
                          .millisecondsSinceEpoch)
                  .toList();
            } else {
              result = resultTem
                  .where((i) =>
                      timestamp1 <=
                      DateTime(
                              int.parse(datesplit[0]),
                              int.parse(datesplit[1]),
                              int.parse(datesplit[2]),
                              int.parse(i.time.split(':')[0]),
                              int.parse(i.time.split(':')[1]))
                          .millisecondsSinceEpoch)
                  .toList();
            }

            return GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 2,
              children: List.generate(result.length, (index) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 1,
                              offset: const Offset(1, 1),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if (result[index].status == "1") {
                              setState(() =>
                                  {selectTime_Morning = result[index].time});
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  selectTime_Morning == result[index].time
                                      ? ColorBtRegister
                                      : result[index].status == "2"
                                          ? const Color(0xFFcbcbcb)
                                          : Colors.white,
                              shadowColor:
                                  selectTime_Morning == result[index].time
                                      ? Colors.greenAccent
                                      : Colors.grey,
                              elevation:
                                  selectTime_Morning == result[index].time
                                      ? 1
                                      : 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              minimumSize: const Size(0, 44),
                              padding: const EdgeInsets.all(0)),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 28 / 100,
                            height: 50,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  result[index].time.split(':')[0] +
                                      ' : ' +
                                      result[index].time.split(':')[1] +
                                      ' น.',
                                  style: TextStyle(
                                      fontSize: font18,
                                      color: result[index].status == "2"
                                          ? const Color(0xFFababab)
                                          : selectTime_Morning ==
                                                  result[index].time
                                              ? Colors.white
                                              : ColorBtRegister),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                );
              }),
            );
          }
          return const LinearProgressIndicator();
        },
      );

  int counter = 0;
  Future _scrollToCounter() async {
    await controller.scrollToIndex(counter,
        preferPosition: AutoScrollPosition.middle);
    controller.highlight(counter);
  }

  Future _nextCounter(counter) {
    setState(() => counter = counter);
    return _scrollToCounter();
  }

  Widget _wrapScrollTag({required int index, required Widget child}) =>
      AutoScrollTag(
        key: ValueKey(index),
        controller: controller,
        index: index,
        child: child,
      );

  List<String> listOfMonths = [
    "มกราคม",
    "กุมภาพันธ์",
    "มีนาคม",
    "เมษายน",
    "พฤษภาคม",
    "มิถุนายน",
    "กรกฎาคม",
    "สิงหาคม",
    "กันยายน",
    "ตุลาคม",
    "พฤศจิกายน",
    "ธันวาคม"
  ];

  List<String> listOfDays = [
    "จันทร์",
    "อังคาร",
    "พุธ",
    "พฤหัสฯ",
    "ศุกร์",
    "เสาร์",
    "อาทิตย์"
  ];

  int addCount = 0;
  void _selectDate(index) {
    // print(index);
    setState(() {
      _nextCounter(counter = index + addCount);
      currentDateSelectedIndex = index;
      selectedDate = DateTime.now().add(Duration(days: index));
    });
  }
}
