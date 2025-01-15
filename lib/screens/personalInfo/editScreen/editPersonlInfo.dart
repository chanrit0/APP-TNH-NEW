import 'package:app_tnh2/controller/api.dart';
import 'package:app_tnh2/model/profile/modelProfile.dart';
import 'package:app_tnh2/styles/textStyle.dart'; 
import 'package:app_tnh2/widgets/Alert/alertEditPersonSuccess.dart';
import 'package:app_tnh2/widgets/stateScreenDetails.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_tnh2/plugin/buddhist_datetime_dateformat.dart';
import 'package:app_tnh2/widgets/app_loading.dart';
import 'package:app_tnh2/widgets/w_keyboard_dismiss.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:email_validator/email_validator.dart';

class EditPersonScreen extends StatefulWidget {
  final ModelProfile item;
  const EditPersonScreen({super.key, required this.item});

  @override
  State<EditPersonScreen> createState() => _EditPersonScreenState();
}

class _EditPersonScreenState extends State<EditPersonScreen> {
  final _formKeyEditThai = GlobalKey<FormState>();
  int typePerson = 1; // 1 บริษัท 2 ไทย 3 อังกฤษ
  final numberPhone = TextEditingController(); //เบอร์โทรศัพท์มือถือ
  final email = TextEditingController(); //email
  late Service postService;

  void updateProfile(String phone, String email) async {
    AppLoading.show(context);
    postService.funUpdateProfile(phone, email).then((value) => {
          if (value?.resCode == '00')
            {
              AppLoading.hide(context),
              alertEditPersonSuccess(context),
            }
        });
  }

  @override
  void dispose() {
    numberPhone.dispose();
    email.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    postService = Service(context: context);
    numberPhone.text = widget.item.resData!.profile!.phone.toString();
    email.text = widget.item.resData!.profile!.email.toString();
    if (widget.item.memberStatus == 'member') {
      setState(() {
        typePerson = 2;
      });
    } else {
      setState(() {
        typePerson = 1;
      });
    }
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    iconSize: 33,
                    icon: const Icon(Icons.chevron_left),
                    color: ColorDefaultApp0,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    'แก้ไขข้อมูลส่วนตัว',
                    style: TextStyle(fontSize: font20, color: ColorDefaultApp0),
                  ),
                  Container(
                    width: 30,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Flexible(
                flex: 5,
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: SingleChildScrollView(
                        child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Container(
                            child: FromPerson(widget.item.resData?.profile),
                          ),
                        ],
                      ),
                    )),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                        ),
                        child: SizedBox(
                          child: Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKeyEditThai.currentState!
                                      .validate()) {
                                    updateProfile(numberPhone.text, email.text);
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
                                  'ยืนยันการแก้ไข',
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
          ),
        ),
      ),
    );
  }

  Column FromPerson(Profile? item) {
    return Column(
      children: [
        Form(
          key: _formKeyEditThai,
          child: Column(
            children: <Widget>[
              typePerson == 1
                  ? Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            'สังกัด',
                            style: TextStyle(
                                color: ColorDefaultApp1, fontSize: font20),
                          ),
                        ),
                        TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            hintText: item?.comName,
                            hintStyle: TextStyle(
                                color: ColorFrontEditPerson, fontSize: font18),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            'รหัสพนักงาน',
                            style: TextStyle(
                                color: ColorDefaultApp1, fontSize: font20),
                          ),
                        ),
                        TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            hintText: item?.mbCode,
                            hintStyle: TextStyle(
                                color: ColorFrontEditPerson, fontSize: font18),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )
                  : Column(),
              SizedBox(
                width: double.infinity,
                child: Text(
                  typePerson != 3 ? 'เลขบัตรประจำตัวประชาชน' : 'Passport ID',
                  style: TextStyle(color: ColorDefaultApp1, fontSize: font20),
                ),
              ),
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  hintText: item?.card,
                  hintStyle:
                      TextStyle(color: ColorFrontEditPerson, fontSize: font18),
                ),
                // autofocus: true,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  typePerson != 3 ? 'ชื่อ' : 'Name',
                  style: TextStyle(color: ColorDefaultApp1, fontSize: font20),
                ),
              ),
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  hintText: item?.fname,
                  hintStyle:
                      TextStyle(color: ColorFrontEditPerson, fontSize: font18),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  typePerson != 3 ? 'นามสกุล' : 'Lastname',
                  style: TextStyle(color: ColorDefaultApp1, fontSize: font20),
                ),
              ),
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  hintText: item?.lname,
                  hintStyle:
                      TextStyle(color: ColorFrontEditPerson, fontSize: font18),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        typePerson != 3 ? 'วัน เดือน ปี เกิด' : 'Date of Birth',
                        style: TextStyle(
                            color: ColorDefaultApp1, fontSize: font20),
                      ),
                    ],
                  ),
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.only(top: 25),
                      hintText: DateFormat('dd/MM/yyyy', 'th')
                          .formatInBuddhistCalendarThai(item!.birthday!),
                      hintStyle: TextStyle(
                          color: ColorFrontEditPerson, fontSize: font18),
                    ),
                    textInputAction: TextInputAction.done,
                    style: TextStyle(color: ColorDefaultApp0, fontSize: font20),
                  ),
                  const Positioned(
                    right: 0.0,
                    top: 29.0,
                    child: Image(
                      image: AssetImage('assets/images/icon-calendar@3x.png'),
                      height: 20,
                      width: 20,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  typePerson != 3 ? 'เบอร์โทรศัพท์มือถือ' : 'Telephone Number',
                  style: TextStyle(color: ColorDefaultApp1, fontSize: font20),
                ),
              ),
              TextFormField(
                // maxLength: 10,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length != 10) {
                    return '*เบอร์โทรศัพท์มือถือไม่ถูกต้อง';
                  }
                  return null;
                },
                controller: numberPhone,
                style: TextStyle(color: ColorDefaultApp0, fontSize: font20),
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  '*กรอกโดยไม่ต้องเว้นวรรค เช่น 0900010099',
                  style: TextStyle(
                      color: const Color.fromARGB(110, 91, 90, 93),
                      fontSize: font12),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  typePerson != 3 ? 'อีเมล' : 'E-mail',
                  style: TextStyle(color: ColorDefaultApp1, fontSize: font20),
                ),
              ),
              TextFormField(
                controller: email,
                // validator: validateEmail,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !EmailValidator.validate(value)) {
                    return typePerson != 3
                        ? 'รูปแบบอีเมลไม่ถูกต้อง'
                        : 'Enter a valid email address';
                  }
                  return null;
                },
                style: TextStyle(color: ColorDefaultApp0, fontSize: font20),
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }
}
