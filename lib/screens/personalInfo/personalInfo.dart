import 'dart:convert';
import 'dart:io';

import 'package:app_tnh2/controller/api.dart';
import 'package:app_tnh2/model/profile/modelProfile.dart';
import 'package:app_tnh2/screens/personalInfo/editScreen/editPersonlInfo.dart';
import 'package:app_tnh2/screens/personalInfo/widget/latestResults.dart';
import 'package:app_tnh2/screens/personalInfo/widget/listDataPerson.dart';
import 'package:app_tnh2/screens/personalInfo/widget/listPaackage.dart';
import 'package:app_tnh2/screens/personalInfo/widget/personHeader.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:app_tnh2/widgets/stateScreenHome.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app_tnh2/plugin/buddhist_datetime_dateformat.dart';
import 'package:intl/date_symbol_data_local.dart';

class PersonalInfoScreen extends StatefulWidget {
  dynamic data;
  dynamic detail;
  PersonalInfoScreen({
    super.key,
    required this.data,
    required this.detail,
  });

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  File? imageFile;
  late Service postService;
  dynamic funGetPackage = '';
  dynamic funGetPackage2 = '';
  String fake = '';
  dynamic funGetProfile = '';
  static TextEditingController loadProfile =
      TextEditingController(text: 'false');
  void saveImgeProfille(File imagePath) async {
    final bytes = File(imagePath.path).readAsBytesSync();
    String base64Image = "data:image/png;base64,${base64Encode(bytes)}";
    postService
        .funSaveProfileImage(base64Image)
        .then((value) => {print(value?.resCode)});
  }

  void getFromGallery() async {
    final image = await ImagePicker()
        .pickImage(maxHeight: 500, maxWidth: 500, source: ImageSource.gallery);
    if (image == null) return;
    final imageTenory = File(image.path);
    saveImgeProfille(imageTenory);
    setState(() {
      imageFile = imageTenory;
    });
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    postService = Service(context: context);
    funGetProfile = postService.funGetProfile();
    funGetPackage = postService.funGetPackage();
    otherFunction(funGetPackage);
  }

  makingPhoneCall(phone) async {
    var url = Uri.parse("tel:$phone");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print('Could not launch $url');
    }
  }

  String replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) +
        newChar +
        oldString.substring(index + 1);
  }

  otherFunction(loadPack) async {
    funGetPackage2 = await loadPack;

    if (funGetPackage2 != null) {
      if (funGetPackage2.resCode == "00") {
      } else {
        funGetPackage2 = '';
      }
    } else {
      funGetPackage2 = '';
    }

    // setState(() {
    //   fake = '123';
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: StateScreenHome(
        child: FutureBuilder(
          future: funGetProfile!,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var item = snapshot.data;
              if (item == null) {
                return const SizedBox();
              } else {
                loadProfile.text = 'true';
                return body(item);
              }
            } else {
              loadProfile.text = 'false';
              return body(
                ModelProfile(
                    memberStatus: 'member',
                    resData: ResData(
                        profile: Profile(
                            userId: 0,
                            fname: '',
                            lname: '',
                            card: '',
                            email: '',
                            phone: '',
                            img: '',
                            comName: '',
                            mbCode: ''))),
              );
            }
          },
        ),
      ),
    );
  }

  Column body(
    ModelProfile item,
  ) {
    final fullScreenWidth = MediaQuery.of(context).size.width;
    // print('asasas: ${item.resData?.profile?.comName}');
    return Column(
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
                      'ข้อมูลส่วนตัว',
                      style:
                          TextStyle(fontSize: font20, color: ColorDefaultApp0),
                    ),
                    const SizedBox(
                      width: 50,
                    )
                  ],
                )),
          ],
        ),
        Flexible(
          flex: 5,
          fit: FlexFit.tight,
          child: ListView(
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: PersonHeader(
                      imageFun: imageFile != null
                          ? CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: fullScreenWidth > 600 ? 45.h : 50,
                              backgroundImage: FileImage(File(imageFile!.path)),
                            )
                          : item.resData?.profile?.img != ""
                              ? CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: fullScreenWidth > 600 ? 45.h : 50,
                                  backgroundImage: MemoryImage(base64Decode(
                                      '${item.resData?.profile?.img}')))
                              : CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: fullScreenWidth > 600 ? 45.h : 50,
                                  backgroundImage: const AssetImage(
                                      'assets/images/bitmap@3x.png'),
                                ),
                      name:
                          'คุณ ${item.resData?.profile?.fname} ${item.resData?.profile?.lname}',
                      subName: 'HN : ${item.resData?.profile?.hn ?? '-'}',
                      getImage: getFromGallery)
                      ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  widget.data != '' && widget.data != null
                      ? LatestResulte(data: widget.data, detail: widget.detail)
                      : const SizedBox(),
                  item.memberStatus == 'member'
                      ? Container()
                      : ListDataPerson(
                          image:
                              'assets/icons/briefcase-simple-line-icons@3x.png',
                          titel: 'สังกัด',
                          detail:
                              item.resData?.profile?.comName ?? 'ไม่มีสังกัด'),
                  item.memberStatus == 'member'
                      ? Container()
                      : ListDataPerson(
                          image: 'assets/icons/solution-anticon@3x.png',
                          titel: 'รหัสพนักงาน',
                          detail: item.resData?.profile?.mbCode ??
                              'ไม่มีรหัสพนักงาน'),
                  funGetPackage2 == '' ||
                          funGetPackage2 == null ||
                          item.memberStatus == 'member'
                      ? Container()
                      : ListPackaage(
                          funGetPackage2 != ''
                              ? funGetPackage2.companyName
                              : '-',
                          funGetPackage2,
                          funGetPackage2.packageAllow),
                  ListDataPerson(
                      image: 'assets/icons/idcard-anticon@3x.png',
                      titel: 'เลขบัตรประจำตัวประชาชน',
                      detail: item.resData?.profile?.card != ''
                          ? 'XXXXXXXXXX${item.resData?.profile?.card?.substring(10, 13)}'
                          : ''),
                  ListDataPerson(
                      image: 'assets/icons/calendar-simple-green@3x.png',
                      titel: 'วัน เดือน ปี เกิด',
                      detail: item.resData!.profile!.birthday != null
                          ? DateFormat('dd MMMM yyyy', 'th')
                              .formatInBuddhistCalendarThai(
                                  item.resData!.profile!.birthday!)
                          : ''),
                  GestureDetector(
                    onTap: () {
                      makingPhoneCall(item.resData?.profile?.phone);
                    },
                    child: ListDataPerson(
                        image:
                            'assets/icons/smartphone-simple-line-icons@3x.png',
                        titel: 'เบอร์โทรศัพท์มือถือ',
                        detail: item.resData?.profile?.phone != ''
                            ? 'XXX-XXX-${item.resData?.profile?.phone?.substring(6, 10)}'
                            : ''),
                  ),
                  ListDataPerson(
                      image: 'assets/icons/mail-anticon-copy@3x.png',
                      titel: 'อีเมล',
                      detail:
                          '${item.resData?.profile?.email?.replaceAll(RegExp('(?<=.)[^@](?=[^@]*?[^@]@)'), 'x')}')
                ],
              )
            ],
          ),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                        ),
                        child: ElevatedButton(
                          onPressed: loadProfile.text == 'true'
                              ? () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        settings: const RouteSettings(
                                            name: 'TNH_EditPerson_Screen'),
                                        builder: (context) => EditPersonScreen(
                                              item: item,
                                            )),
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
                              const Image(
                                image: AssetImage(
                                    'assets/icons/edit-anticon@3x.png'),
                                height: 21,
                                width: 20,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'แก้ไขข้อมูลส่วนตัว',
                                style: TextStyle(
                                    fontSize: font18, color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
