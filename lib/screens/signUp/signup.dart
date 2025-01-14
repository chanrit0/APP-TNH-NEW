import 'package:app_tnh2/controller/api.dart';
import 'package:app_tnh2/screens/signUp/confirmOTP.dart';
import 'package:app_tnh2/styles/textStyle.dart';
import 'package:app_tnh2/widgets/stateScreenDetails.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:app_tnh2/screens/home/appointment/widget/alert/alertFailApi.dart';
import 'package:email_validator/email_validator.dart';
import 'package:app_tnh2/widgets/app_loading.dart';
import 'package:app_tnh2/widgets/w_keyboard_dismiss.dart';
import 'package:intl/date_symbol_data_local.dart';

class SignupScreen extends StatefulWidget {
  final bool agreementAccept;
  const SignupScreen({super.key, required this.agreementAccept});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKeyThai = GlobalKey<FormState>();
  final _formKeyEn = GlobalKey<FormState>();

  Color nameColorHitHaeder = ColorDefaultApp0;
  Color nameColorHaeder = ColorDefaultApp1;
  Color nameColorHit = Colors.grey;
  int tabSelect = 0; //ค่าเลือก tab

  TextEditingController card_ID = TextEditingController(); //ตัวแปลเลขบัตร
  String firstName = ''; //ตัวแปลชื่อ
  String lastName = ''; //นามสกุล
  TextEditingController birthday = TextEditingController(); //ตัวแปลวันเกิด
  TextEditingController birthdayShow = TextEditingController(); //ตัวแปลวันเกิด
  String numberPhone = ''; //ตัวแปลเบอร์
  String email = ''; //ตัวแปลอีเมล
  String password = ''; //ตัวแปลรหัส
  String confirmPassword = ''; //ตัวแปลยืนยันรกหัส
  late Service postService;

  void signUpStep(
      String card_ID,
      String firstName,
      String lastName,
      String birthday,
      String numberPhone,
      String email,
      String password,
      String confirmPassword) {
    AppLoading.show(context);
    postService
        .funSignUp(card_ID, firstName, lastName, birthday, numberPhone, email,
            password, confirmPassword)
        .then((value) => {
              if (value.resCode == '00')
                {
                  Navigator.pop(context),
                  Future.delayed(const Duration(milliseconds: 1), () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          settings: const RouteSettings(
                              name: 'TNH_ConfirmOtp_Screen'),
                          builder: (context) => ConfirmOtpScreen(
                                card_ID: card_ID,
                                firstName: firstName,
                                lastName: lastName,
                                birthday: birthday,
                                numberPhone: numberPhone,
                                email: email,
                                password: password,
                                confirmPassword: confirmPassword,
                                agreementAccept: widget.agreementAccept,
                                data: value,
                              )),
                    );
                  }),
                }
              else
                {
                  Navigator.pop(context),
                  alertFailApi(context, value.resText!),
                }
            });
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    postService = Service(context: context);
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
                    color: nameColorHitHaeder,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    tabSelect == 0 ? 'สมัครสมาชิก' : 'Registration',
                    style:
                        TextStyle(fontSize: font20, color: nameColorHitHaeder),
                  ),
                  Container(
                    width: 30,
                  )
                ],
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
                    child: SingleChildScrollView(
                        child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() => {tabSelect = 0});
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: tabSelect == 0
                                          ? ColorBtRegister
                                          : Colors.white,
                                      shadowColor: Colors.greenAccent,
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      minimumSize: const Size(0, 44),
                                    ),
                                    child: Text(
                                      'Thai',
                                      style: TextStyle(
                                          fontSize: font18,
                                          color: tabSelect == 0
                                              ? Colors.white
                                              : ColorBtRegister),
                                    ),
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: tabSelect == 1
                                          ? ColorBtRegister
                                          : Colors.white,
                                      elevation: 3,
                                      shadowColor: Colors.greenAccent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      minimumSize: const Size(175, 44),
                                    ),
                                    onPressed: () {
                                      setState(() => {tabSelect = 1});
                                    },
                                    child: Text(
                                      'Foreigners',
                                      style: TextStyle(
                                          fontSize: font18,
                                          color: tabSelect == 0
                                              ? ColorBtRegister
                                              : Colors.white),
                                    ),
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            child:
                                (tabSelect == 0) ? tabSelect1() : tabSelect2(),
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
                          width: double.infinity,
                          child: Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (tabSelect == 0) {
                                    if (_formKeyThai.currentState!.validate()) {
                                      signUpStep(
                                          card_ID.text,
                                          firstName,
                                          lastName,
                                          birthday.text,
                                          numberPhone,
                                          email,
                                          password,
                                          confirmPassword);
                                    } else {
                                      print('TH ส่งไม่ไปนะ!!!');
                                    }
                                  } else {
                                    if (_formKeyEn.currentState!.validate()) {
                                      signUpStep(
                                          card_ID.text,
                                          firstName,
                                          lastName,
                                          birthday.text,
                                          numberPhone,
                                          email,
                                          password,
                                          confirmPassword);
                                    } else {
                                      print('EN ส่งไม่ไปนะ!!!');
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: nameColorHaeder,
                                  shadowColor: nameColorHaeder,
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                  minimumSize: const Size(double.infinity, 44),
                                ),
                                child: Text(
                                  tabSelect == 0 ? 'สมัครสมาชิก' : 'Register',
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

  void showDate() async {
    final DateTime? selectedDate = await showDatePicker(
        context: context,
        locale: tabSelect == 0
            ? const Locale("th", "TH")
            : const Locale("en", "EN"),
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 1, 1),
        lastDate: DateTime.now(),
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
                colorScheme: const ColorScheme.light(
                    onPrimary: Colors.white,
                    onSurface: Colors.black,
                    primary: Color(0xff005759)),
                dialogBackgroundColor: Colors.white,
                textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        textStyle: TextStyle(
                            color: const Color(0xff29989b),
                            fontWeight: FontWeight.normal,
                            fontSize: font14,
                            fontFamily: 'Quicksand'),
                        backgroundColor: const Color(0xff005759),
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Color(0xff29989b),
                                width: 1,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(5))))),
            child: child!,
          );
        });
    if (selectedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      String formattedDateShow =
          DateFormat('dd/MM/yyyy', 'th').format(selectedDate);
      // String formattedDateShow =
      //     DateFormat('dd/MM/yyyy', 'th').format(selectedDate);

      setState(() {
        if (tabSelect == 0) {
          birthdayShow.text = formattedDateShow;
          birthday.text = formattedDate;
        } else {
          birthdayShow.text = formattedDateShow;
          birthday.text = formattedDate;
        }
      });
    } else {
      print("Date is not selected");
    }
  }

  //ค่า top ระหว่าง label textInput สามารถครอบ top: 10 แล้วเปลี่ยนทั้งหมดได้เลย
  Column tabSelect1() {
    return Column(
      children: [
        Form(
          key: _formKeyThai,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                height: 25,
                child: Text(
                  'เลขบัตรประจำตัวประชาชน',
                  style: TextStyle(color: nameColorHaeder, fontSize: font20),
                ),
              ),
              TextFormField(
                maxLength: 13,
                controller: card_ID,
                validator: (card_ID) {
                  if (card_ID == null ||
                      card_ID.isEmpty ||
                      card_ID.length != 13) {
                    return '*กรอกโดยไม่ต้องเว้นวรรค เช่น 110000000001';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  hintText: 'กรุณาเลขบัตรประจำตัวประชาชน',
                  hintStyle: TextStyle(color: nameColorHit, fontSize: font18),
                ),
                style: TextStyle(color: ColorDefaultApp0, fontSize: font20),
                // autofocus: true,
              ),
              const SizedBox(
                height: 0,
              ),
              SizedBox(
                width: double.infinity,
                height: 25,
                child: Text(
                  'ชื่อ',
                  style: TextStyle(color: nameColorHaeder, fontSize: font20),
                ),
              ),
              TextFormField(
                onChanged: (value) => setState(() => firstName = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '*กรุณากรอกข้อมูล';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  hintText: 'กรุณากรอกชื่อ',
                  hintStyle: TextStyle(color: nameColorHit, fontSize: font18),
                ),
                textInputAction: TextInputAction.done,
                style: TextStyle(color: ColorDefaultApp0, fontSize: font20),
                // autofocus: true,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 25,
                child: Text(
                  'นามสกุล',
                  style: TextStyle(color: nameColorHaeder, fontSize: font20),
                ),
              ),
              TextFormField(
                onChanged: (value) => setState(() => lastName = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '*กรุณากรอกข้้อมูล';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  hintText: 'กรุณากรอกนามสกุล',
                  hintStyle: TextStyle(color: nameColorHit, fontSize: font18),
                ),
                textInputAction: TextInputAction.done,
                style: TextStyle(color: ColorDefaultApp0, fontSize: font20),
                // autofocus: true,
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
                        'วัน เดือน ปี เกิด',
                        style:
                            TextStyle(color: nameColorHaeder, fontSize: font20),
                      ),
                    ],
                  ),
                  TextFormField(
                    onTap: () {
                      showDate();
                    },
                    readOnly: true,
                    controller: birthdayShow,
                    validator: (birthdayTH) {
                      if (birthdayTH == null || birthdayTH.isEmpty) {
                        return '*กรุณากรอกข้อมูล';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.only(top: 25),
                      hintText: 'กรุณาเลือกวัน เดือน ปี เกิด',
                      hintStyle:
                          TextStyle(color: nameColorHit, fontSize: font18),
                    ),
                    textInputAction: TextInputAction.done,
                    style: TextStyle(color: ColorDefaultApp0, fontSize: font20),
                  ),
                  const Positioned(
                    right: 0,
                    top: 29,
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
                height: 25,
                child: Text(
                  'เบอร์โทรศัพท์มือถือ',
                  style: TextStyle(color: nameColorHaeder, fontSize: font20),
                ),
              ),
              TextFormField(
                maxLength: 10,
                onChanged: (value) => setState(() => numberPhone = value),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length != 10) {
                    return '*เบอร์โทรศัพท์มือถือไม่ถูกต้อง';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  hintText: 'กรุณากรอกเบอร์โทรศัพท์มือถือ',
                  hintStyle: TextStyle(color: nameColorHit, fontSize: font18),
                ),
                textInputAction: TextInputAction.done,
                style: TextStyle(color: ColorDefaultApp0, fontSize: font20),
              ),
              const SizedBox(
                height: 0,
              ),
              SizedBox(
                width: double.infinity,
                height: 25,
                child: Text(
                  'อีเมล',
                  style: TextStyle(color: nameColorHaeder, fontSize: font20),
                ),
              ),
              TextFormField(
                onChanged: (value) => setState(() => email = value),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !EmailValidator.validate(value)) {
                    return '*รูปแบบอีเมลไม่ถูกต้อง';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  hintText: 'กรุณากรอกอีเมล',
                  hintStyle: TextStyle(color: nameColorHit, fontSize: font18),
                ),
                textInputAction: TextInputAction.done,
                style: TextStyle(color: ColorDefaultApp0, fontSize: font20),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 25,
                child: Text(
                  'รหัสผ่าน',
                  style: TextStyle(color: nameColorHaeder, fontSize: font20),
                ),
              ),
              TextFormField(
                obscureText: true,
                onChanged: (value) => setState(() => password = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '*กรุณากรอกข้อมูล';
                  }
                  if (value.length < 8) {
                    return '*รหัสผ่านควรมีความยาว 8 ตัวอักษรขึ้นไป';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  hintText: 'กรุณากรอกรหัสผ่าน',
                  hintStyle: TextStyle(color: nameColorHit, fontSize: font18),
                ),
                textInputAction: TextInputAction.done,
                style: TextStyle(color: ColorDefaultApp0, fontSize: font20),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 25,
                child: Text(
                  'ยืนยันรหัสผ่าน',
                  style: TextStyle(color: nameColorHaeder, fontSize: font20),
                ),
              ),
              TextFormField(
                obscureText: true,
                onChanged: (value) => setState(() => confirmPassword = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '*กรุณากรอกข้อมูล';
                  }
                  if (password != value) {
                    return '*กรุณากรอกรหัสผ่านให้ตรงกัน';
                  }
                  if (value.length < 8) {
                    return '*รหัสผ่านควรมีความยาว 8 ตัวอักษรขึ้นไป';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  hintText: 'กรุณากรอกรหัสผ่านอีกครั้ง',
                  hintStyle: TextStyle(color: nameColorHit, fontSize: font18),
                ),
                textInputAction: TextInputAction.done,
                style: TextStyle(color: ColorDefaultApp0, fontSize: font20),
              ),
            ],
          ),
        )
      ],
    );
  }

  Column tabSelect2() {
    return Column(
      children: [
        Form(
          key: _formKeyEn,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                height: 25,
                child: Text(
                  'Passport ID',
                  style: TextStyle(color: nameColorHaeder, fontSize: font20),
                ),
              ),
              TextFormField(
                controller: card_ID,
                validator: (card_ID) {
                  if (card_ID == null || card_ID.isEmpty) {
                    return '*Example AA1100000';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  hintText: 'Enter Passport ID',
                  hintStyle: TextStyle(color: nameColorHit, fontSize: font18),
                ),
                textInputAction: TextInputAction.done,
                style: TextStyle(color: ColorDefaultApp0, fontSize: font20),
                // autofocus: true,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 25,
                child: Text(
                  'Name',
                  style: TextStyle(color: nameColorHaeder, fontSize: font20),
                ),
              ),
              TextFormField(
                onChanged: (value) => setState(() => firstName = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  hintText: 'Enter Name',
                  hintStyle: TextStyle(color: nameColorHit, fontSize: font18),
                ),
                textInputAction: TextInputAction.done,
                style: TextStyle(color: ColorDefaultApp0, fontSize: font20),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 25,
                child: Text(
                  'Lastname',
                  style: TextStyle(color: nameColorHaeder, fontSize: font20),
                ),
              ),
              TextFormField(
                onChanged: (value) => setState(() => lastName = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  hintText: 'Enter Lastname',
                  hintStyle: TextStyle(color: nameColorHit, fontSize: font18),
                ),
                textInputAction: TextInputAction.done,
                style: TextStyle(color: ColorDefaultApp0, fontSize: font20),
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
                        'Date of Birth',
                        style:
                            TextStyle(color: nameColorHaeder, fontSize: font20),
                      ),
                    ],
                  ),
                  TextFormField(
                    onTap: () {
                      showDate();
                    },
                    readOnly: true,
                    controller: birthdayShow,
                    validator: (birthdayEN) {
                      if (birthdayEN == null || birthdayEN.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.only(top: 25),
                      hintText: 'Enter Date of Birth',
                      hintStyle:
                          TextStyle(color: nameColorHit, fontSize: font18),
                    ),
                    textInputAction: TextInputAction.done,
                    style: TextStyle(color: ColorDefaultApp0, fontSize: font20),
                  ),
                  Positioned(
                    right: 0,
                    top: 29,
                    child: Image(
                      image: const AssetImage(
                          'assets/images/icon-calendar@3x.png'),
                      height: 20,
                      width: 20.w,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 25,
                child: Text(
                  'Telephone Number',
                  style: TextStyle(color: nameColorHaeder, fontSize: font20),
                ),
              ),
              TextFormField(
                maxLength: 10,
                onChanged: (value) => setState(() => numberPhone = value),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length != 10) {
                    return 'Enter a valid telephone Number';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  hintText: 'Enter Telephone Number',
                  hintStyle: TextStyle(color: nameColorHit, fontSize: font18),
                ),
                textInputAction: TextInputAction.done,
                style: TextStyle(color: ColorDefaultApp0, fontSize: font20),
              ),
              const SizedBox(
                height: 0,
              ),
              SizedBox(
                width: double.infinity,
                height: 25,
                child: Text(
                  'E-mail',
                  style: TextStyle(color: nameColorHaeder, fontSize: font20),
                ),
              ),
              TextFormField(
                onChanged: (value) => setState(() => email = value),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !EmailValidator.validate(value)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  hintText: 'Enter E-mail',
                  hintStyle: TextStyle(color: nameColorHit, fontSize: font18),
                ),
                textInputAction: TextInputAction.done,
                style: TextStyle(color: ColorDefaultApp0, fontSize: font20),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 25,
                child: Text(
                  'Password',
                  style: TextStyle(color: nameColorHaeder, fontSize: font20),
                ),
              ),
              TextFormField(
                obscureText: true,
                onChanged: (value) => setState(() => password = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  if (value.length < 8) {
                    return '*Passwords must be at least 8 characters long';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  hintText: 'Enter Password',
                  hintStyle: TextStyle(color: nameColorHit, fontSize: font18),
                ),
                textInputAction: TextInputAction.done,
                style: TextStyle(color: ColorDefaultApp0, fontSize: font20),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 25,
                child: Text(
                  'Confirm Password',
                  style: TextStyle(color: nameColorHaeder, fontSize: font20),
                ),
              ),
              TextFormField(
                obscureText: true,
                onChanged: (value) => setState(() => confirmPassword = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  if (value.length < 8) {
                    return '*Passwords must be at least 8 characters long';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  hintText: 'Enter Password Again',
                  hintStyle: TextStyle(color: nameColorHit, fontSize: font18),
                ),
                textInputAction: TextInputAction.done,
                style: TextStyle(color: ColorDefaultApp0, fontSize: font20),
              ),
            ],
          ),
        )
      ],
    );
  }
}
