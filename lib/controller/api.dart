import 'package:app_tnh2/config/constants.dart';
import 'package:app_tnh2/controller/http.dart';
import 'package:app_tnh2/model/contact/modelContact.dart';
import 'package:app_tnh2/model/healthResult/modelHealthReport.dart';
import 'package:app_tnh2/model/healthResult/modelHealthReportDetail.dart';
import 'package:app_tnh2/model/modelSuccess.dart';
import 'package:app_tnh2/model/noti/modelNoti.dart';
import 'package:app_tnh2/model/noti/modelNotiCount.dart';
import 'package:app_tnh2/model/profile/modelProfile.dart';
import 'package:app_tnh2/model/profile/modelProfileName.dart';
import 'package:app_tnh2/model/signIn/modelForceUpdate.dart';
import 'package:app_tnh2/model/signIn/modelSignIn.dart';
import 'package:app_tnh2/model/signUp/modelAgreement.dart';
import 'package:app_tnh2/model/signUp/modelAgreementCheck.dart';
import 'package:app_tnh2/model/signUp/modelSignupStep1.dart';
import 'package:app_tnh2/model/signUp/modelSignupStep2.dart';
import 'package:app_tnh2/model/signUp/modelSignupStep3.dart';
import 'package:flutter/cupertino.dart';
import 'package:app_tnh2/helper/base_service.dart';
import 'package:app_tnh2/model/appointment/modelAppointment.dart';
import 'package:app_tnh2/model/appointment/modelAppointmentPackage.dart';
import 'package:app_tnh2/model/appointment/modelDuedate.dart' as dd;
import 'package:app_tnh2/model/appointment/modelCalendar.dart' as cl;
import 'package:app_tnh2/model/appointment/modelUpdateAppoint.dart';
import 'package:app_tnh2/model/appointment/modelUpdateAppointStep2.dart';
import 'package:app_tnh2/model/appointment/modelCancleAppoint.dart';
import 'package:app_tnh2/model/appointment/modelPostponeAppoint.dart';
import 'package:app_tnh2/model/article/modelSubcate.dart' as sc;
import 'package:app_tnh2/model/article/modelArticle.dart' as ar;
import 'package:app_tnh2/model/banner/modelBanner.dart';

class API {
  static final _request =
      HttpRequest(ApiConstants.HOST_URL + ApiConstants.API_VERSION);

  //signIn
  static var signIn = '/login';
  static var deleteAcc = '/account/delete';
  static var logOut = '/logout';
  static var forceUpdate = '/appversion';
  static var forgotPass = '/forgot/password';
  static var refreshToken = '/refresh_token';

  //signUp
  static var agreement = '/agreement';
  static var agreementSave = '/agreement/save';
  static var agreementCheck = '/agreement/status';
  static var signUp = '/register/step1';
  static var resendPhone = '/register/phone/resend';
  static var sendOtp = '/register/step2';
  static var resendEmail = '/register/email/resend';
  static var sendEmail = '/register/step3';

  //verify member
  static var verifyMember = '/verify/step1';
  static var verifyStep2 = '/verify/step2';
  static var resendVerifyStep2 = '/verify/phone/resend';
  static var verifyStep3 = '/verify/step3';
  static var resendVerifyStep3 = '/verify/email/resend';

  //noti
  static var onOffNoti = '/notification/setting';
  static var notiCount = '/notification/count';
  static var listNoti = '/notification';
  static var updateNoti = '/notification/update';

  ///banner
  static var banner = '/banner';

  //article
  static var article = '/newsarticle';
  static var subcate = '/newsarticle/subcategory';

  //profile
  static var profileNname = '/profile/name';
  static var profile = '/profile/detail';
  static var saveProfileImge = '/profile/image/update';
  static var profileImage = '/profile/image';
  static var updateProfille = '/profile/update';
  static var contact = '/contact';

  //healthreport
  static var healthreport = '/healthreport';
  static var healthReportDetail = '/healthreportdetail';

  ///refresh_token
  static var refreshtoken = '/refresh_token';

  //logout
  static var logout = '/logout';

  //appointment
  static var appointmentList = '/appointment/list';
  static var package = '/appointment/package';
  static var duedate = '/appointment/duedate/list';
  static var calendar = '/appointment/calendar';
  static var duedatesave1 = '/appointment/duedate';
  static var duedatesave2 = '/appointment/duedate/save';
  static var cancleAppoint = '/appointment/duedate/cancel';
  static var postponeAppoint = '/appointment/duedate/postpone';

  static var count = 0;
}

class Service {
  late BuildContext context;
  Service({required this.context});

  Future<SingIn?> funSignIn(
      {required String? username,
      required String? password,
      required String? token}) async {
    BaseService baseService = BaseService(context);
    final body = {
      'username': username,
      'password': password,
      'token_noti': token
    };
    final res = await API._request
        .postDio(API.signIn, body)
        .catchError(baseService.handleError);
    return res != null ? singInFromJson(res) : null;
  }

  Future<ModelSuccess?> funLogOut() async {
    BaseService baseService = BaseService(context);
    final res = await API._request
        .postDio(API.logOut, {}).catchError(baseService.handleError);
    return res != null ? modelSuccessFromJson(res) : null;
  }

  Future<ModelForceUpdate?> funForceUpdate(
      String version, String devicePlatform, String updateVeriosn) async {
    BaseService baseService = BaseService(context);
    final body = {
      'version': version,
      'device_platform': devicePlatform,
      'device_up_dateversion': updateVeriosn,
    };
    final res = await API._request
        .postDio(API.forceUpdate, body)
        .catchError(baseService.handleError);
    return res != null ? modelForceUpdateFromJson(res) : null;
  }

  Future<ModelSuccess?> funForgotPass(String card) async {
    BaseService baseService = BaseService(context);
    // final headers = {'Accept': 'application/json'};
    final body = {
      'card': card,
    };
    final res = await API._request
        .postDio(API.forgotPass, body)
        .catchError(baseService.handleError);
    return res != null ? modelSuccessFromJson(res) : null;
  }

  Future<ModelAgreement?> funGetAgreement() async {
    BaseService baseService = BaseService(context);
    final res = await API._request
        .getDio(API.agreement)
        .catchError(baseService.handleError);
    return res != null ? modelAgreementFromJson(res) : null;
  }

  Future<ModelAgreementCheck?> funGetAgreementCheck() async {
    BaseService baseService = BaseService(context);
    final res = await API._request
        .getDio(API.agreementCheck)
        .catchError(baseService.handleError);
    return res != null ? modelAgreementCheckFromJson(res) : null;
  }

  Future<dynamic> funGetAgreementSave(String type, bool agreementAccept) async {
    BaseService baseService = BaseService(context);
    final body = {"type": type, "agreement_accept": agreementAccept};
    final res = await API._request
        .postDio(API.agreementSave, body)
        .catchError(baseService.handleError);
    return res != null ? modelSuccessFromJson(res).resCode : '01';
  }

  Future<ModelSignupStep1> funSignUp(
      String card_ID,
      String firstName,
      String lastName,
      String birthday,
      String numberPhone,
      String email,
      String password,
      String confirmPassword) async {
    // final headers = {'Accept': 'application/json'};
    final body = {
      'email': email,
      'card': card_ID,
      'fname': firstName,
      'lname': lastName,
      'birthday': birthday,
      'phone': numberPhone,
      'password': password,
      'confirm_password': confirmPassword,
    };
    final res =
        await API._request.postDio(API.signUp, body).catchError((error) {
      BaseService.showSnackBar(context, error);
    });
    return modelSignupStep1FromJson(res);
  }

  Future<ModelSignupStep1?> funResendPhone(
    String numberPhone,
  ) async {
    BaseService baseService = BaseService(context);
    // final headers = {'Accept': 'application/json'};
    final body = {
      'phone': numberPhone,
    };
    final res = await API._request
        .postDio(API.resendPhone, body)
        .catchError(baseService.handleError);
    return res != null ? modelSignupStep1FromJson(res) : null;
  }

  Future<ModelSignupStep2> funSendOTP(
    String ref_no,
    String otp,
    String email,
    String card_ID,
    String firstName,
    String lastName,
    String birthday,
    String numberPhone,
  ) async {
    BaseService baseService = BaseService(context);
    // final headers = {'Accept': 'application/json'};
    final body = {
      'ref_no': ref_no,
      'otp': otp,
      'email': email,
      'card': card_ID,
      'fname': firstName,
      'lname': lastName,
      'birthday': birthday,
      'phone': numberPhone,
    };
    final res = await API._request
        .postDio(API.sendOtp, body)
        .catchError(baseService.handleError);
    return modelSignupStep2FromJson(res);
  }

  Future<ModelSignupStep1?> funResendEmail(
    String email,
  ) async {
    BaseService baseService = BaseService(context);
    // final headers = {'Accept': 'application/json'};
    final body = {
      'email': email,
    };
    final res = await API._request
        .postDio(API.resendEmail, body)
        .catchError(baseService.handleError);
    return res != null ? modelSignupStep1FromJson(res) : null;
  }

  Future<ModelSignupStep3?> funSendEmail(
    String? ref_no,
    String? securityCode,
    String? email,
    String? card_ID,
    String? firstName,
    String? lastName,
    String? birthday,
    String? numberPhone,
    String? password,
    String? confirmPassword,
    bool agreementAccept,
  ) async {
    BaseService baseService = BaseService(context);
    // final headers = {'Accept': 'application/json'};
    final body = {
      'ref_no': ref_no,
      'security_code': securityCode,
      'email': email,
      'card': card_ID,
      'fname': firstName,
      'lname': lastName,
      'birthday': birthday,
      'phone': numberPhone,
      'password': password,
      'confirm_password': confirmPassword,
      'agreement_accept': '$agreementAccept',
    };

    final res = await API._request
        .postDio(API.sendEmail, body)
        .catchError(baseService.handleError);
    return res != null ? modelSignupStep3FromJson(res) : null;
  }

  Future<ModelSuccess?> funOnNoti(
    String setting,
  ) async {
    BaseService baseService = BaseService(context);
    final body = {
      'setting': setting,
    };
    final res = await API._request
        .postDio(API.onOffNoti, body)
        .catchError(baseService.handleError);
    return res != null ? modelSuccessFromJson(res) : null;
  }

  Future<ModelSignupStep1> funVerifyMemberStep1() async {
    BaseService baseService = BaseService(context);
    // final headers = {'Accept': 'application/json'};
    final res = await API._request
        .postDio(API.verifyMember, {}).catchError(baseService.handleError);
    return modelSignupStep1FromJson(res);
  }

  Future<ModelSignupStep2> funSendVerifyStep2(
    String ref_no,
    String otp,
  ) async {
    BaseService baseService = BaseService(context);
    // final headers = {'Accept': 'application/json'};
    final body = {
      'ref_no': ref_no,
      'otp': otp,
    };
    final res = await API._request
        .postDio(API.verifyStep2, body)
        .catchError(baseService.handleError);
    return modelSignupStep2FromJson(res);
  }

  Future<ModelSignupStep1?> funResendVerifyStep2() async {
    BaseService baseService = BaseService(context);
    // final headers = {'Accept': 'application/json'};
    final res = await API._request
        .postDio(API.resendVerifyStep2, {}).catchError(baseService.handleError);
    return res != null ? modelSignupStep1FromJson(res) : null;
  }

  Future<ModelSignupStep3?> funSendVerifyStep3(
    String? ref_no,
    String? securityCode,
  ) async {
    // print(ref_no);
    // print(securityCode);
    BaseService baseService = BaseService(context);
    // final headers = {'Accept': 'application/json'};
    final body = {
      'ref_no': ref_no,
      'security_code': securityCode,
    };
    final res = await API._request
        .postDio(API.verifyStep3, body)
        .catchError(baseService.handleError);
    return res != null ? modelSignupStep3FromJson(res) : null;
  }

  Future<ModelSignupStep1?> funResendVerifyStep3() async {
    BaseService baseService = BaseService(context);
    // final headers = {'Accept': 'application/json'};
    final res = await API._request
        .postDio(API.resendVerifyStep3, {}).catchError(baseService.handleError);
    return res != null ? modelSignupStep1FromJson(res) : null;
  }

  Future<ModelNotiCount?> funGetNotiCount() async {
    BaseService baseService = BaseService(context);
    final res = await API._request
        .getDio(API.notiCount)
        .catchError(baseService.handleError);
    return res != null ? modelNotiCountFromJson(res) : null;
  }

  Future<List<NotiData>?> funGetNoti() async {
    BaseService baseService = BaseService(context);
    final res = await API._request
        .getDio(API.listNoti)
        .catchError(baseService.handleError);
    return res != null ? modelNotiFromJson(res).resData : null;
    // return ModelNoti.fromJson(jsonDecode(res));
  }

  Future<ModelSuccess?> funUpDateNoti(int id, int type) async {
    BaseService baseService = BaseService(context);
    final body = {"id": '$id', "type": '$type'};
    final res = await API._request
        .postDio(API.updateNoti, body)
        .catchError(baseService.handleError);
    return res != null ? modelSuccessFromJson(res) : null;
  }

  Future<ModelSuccess?> funDeletAcc() async {
    BaseService baseService = BaseService(context);
    final res = await API._request
        .getDio(API.deleteAcc)
        .catchError(baseService.handleError);
    return res != null ? modelSuccessFromJson(res) : null;
  }

  Future<ModelSuccess?> funSaveProfileImage(String image) async {
    BaseService baseService = BaseService(context);
    final body = {
      'img': image,
    };
    final res = await API._request
        .postDio(API.saveProfileImge, body)
        .catchError(baseService.handleError);
    return res != null ? modelSuccessFromJson(res) : null;
  }

  Future<ModelProfile?> funGetProfile() async {
    BaseService baseService = BaseService(context);
    final res = await API._request
        .getDio(API.profile)
        .catchError(baseService.handleError);
    return res != null ? modelProfileFromJson(res) : null;
  }

  Future<ModelSuccess?> funUpdateProfile(String phone, String email) async {
    BaseService baseService = BaseService(context);
    final body = {'phone': phone, 'email': email};
    final res = await API._request
        .postDio(API.updateProfille, body)
        .catchError(baseService.handleError);
    return res != null ? modelSuccessFromJson(res) : null;
  }

  Future<ModelContact?> funGetContact() async {
    BaseService baseService = BaseService(context);
    final res = await API._request
        .getDio(API.contact)
        .catchError(baseService.handleError);
    return res != null ? modelContactFromJson(res) : null;
  }

  Future<ModelHealthReport?> funHealthReport(String type, String hn) async {
    BaseService baseService = BaseService(context);
    final body = {'type': type, 'hn': hn};
    final res = await API._request
        .postDio(API.healthreport, body)
        .catchError(baseService.handleError);
    return res != null ? modelHealthReportFromJson(res) : null;
  }

  Future<ModelHealthReportDetail?> funHealthReportDetail(
      String requestNo, String visitdate, String vn) async {
    BaseService baseService = BaseService(context);
    final body = {'requestNo': requestNo, 'visitdate': visitdate, 'vn': vn};
    print('body $body');
    final res = await API._request
        .postDio(API.healthReportDetail, body)
        .catchError(baseService.handleError);
    return res != null ? modelHealthReportDetailFromJson(res) : null;
  }

  // Future<ModelHealthReportDetail2?> funHealthReportDetail2(
  //     String requestNo, String visitdate, String vn) async {
  //   BaseService baseService = BaseService(context);
  //   final body = {'requestNo': requestNo, 'visitdate': visitdate, 'vn': vn};
  //   final res = await API._request
  //       .postDio(API.healthReportDetail, body)
  //       .catchError(baseService.handleError);
  //   return res != null ? modelHealthReportDetail2FromJson(res) : null;
  // }

  ////////////////////////////
  ///API MINT///
  ////////////////////////////
  Future<dynamic> funGetProfileName() async {
    BaseService baseService = BaseService(context);
    final res = await API._request
        .getDio(API.profileNname)
        .catchError(baseService.handleError);
    return res != null ? modelProfileNameFromJson(res).resData : null;
  }

  Future<List<ResAppointment>?> funGetAppointment(type) async {
    BaseService baseService = BaseService(context);
    final body = {"type": type};
    final res = await API._request
        .postDio(API.appointmentList, body)
        .catchError(baseService.handleError);
    return res != null ? modelAppointmentFromJson(res).resData : null;
  }

  Future<dynamic> funGetPackage() async {
    BaseService baseService = BaseService(context);
    final res = await API._request
        .postDio(API.package, {}).catchError(baseService.handleError);
    return res != null ? modelPackageFromJson(res) : null;
  }

  Future<List<ar.ResDatum>?> funGetArticle(id, activityNewTab, search) async {
    BaseService baseService = BaseService(context);
    final body = {
      "limit": activityNewTab == 0 ? "4" : "50",
      "offset": "0",
      "cateID": id.toString(),
      "tagID": activityNewTab == 0 ? "" : activityNewTab.toString(),
      "search": search,
      "random": "1"
    };
    final res = await API._request
        .postDio(API.article, body)
        .catchError(baseService.handleError);
    return res != null ? ar.modelArticleFromJson(res).resData : null;
  }

  Future<List<sc.ResDatum>?> funGetSubcategory(id) async {
    BaseService baseService = BaseService(context);
    final res = await API._request
        .getDio("${API.subcate}/$id")
        .catchError(baseService.handleError);
    return res != null ? sc.modelSubcategoryFromJson(res).resData : null;
  }

  Future<List<dd.ResDatum>?> funGetDuedate(dynamic apmbId) async {
    BaseService baseService = BaseService(context);
    final body = {"apmb_id": apmbId};
    final res = await API._request
        .postDio(API.duedate, body)
        .catchError(baseService.handleError);
    return res != null ? dd.modelDuedateFromJson(res).resData : null;
  }

  Future<List<cl.ResDatum>?> funGetCalendar() async {
    BaseService baseService = BaseService(context);
    final res = await API._request
        .postDio(API.calendar, {}).catchError(baseService.handleError);
    return res != null ? cl.modelCalendarFromJson(res).resData : null;
  }

  Future<dynamic> funSaveAppointmentStep1(
      date, time, detail, apmbid, packagecode) async {
    BaseService baseService = BaseService(context);
    final body = {"date": date, "time": time, "detail": detail};
    final res = await API._request
        .postDio(API.duedatesave1, body)
        .catchError(baseService.handleError);
    final data = modelUpdateAppointFromJson(res);
    return data.resCode == '00' ? modelUpdateAppointFromJson(res) : '01';
  }

  Future<dynamic> funSaveAppointmentStep2(
      date, time, detail, apmbid, packagecode, apdoctorId) async {
    BaseService baseService = BaseService(context);
    // final body = {"date": date, "time": time, "detail": detail};
    // final res = await API._request
    //     .postDio(API.duedatesave1, body)
    //     .catchError(baseService.handleError);
    // final data = modelUpdateAppointFromJson(res);
    // final data = res != null ? modelUpdateAppointFromJson(res).resCode : '01';
    // if (data.resCode == '00') {
    final body2 = {
      "apdoctor_id": apdoctorId.toString(),
      "detail": detail,
      "apmb_id": apmbid,
      "status": apmbid != '' ? "postpone" : '',
      "package_code": packagecode
    };
    final res2 = await API._request
        .postDio(API.duedatesave2, body2)
        .catchError(baseService.handleError);
    return res2 != null ? modelUpdateAppointStep2FromJson(res2) : null;
    // } else {
    //   return '01';
    // }
  }

  Future<String> funCancleAppoint(id) async {
    BaseService baseService = BaseService(context);
    final body = {"apmb_id": id.toString()};
    final res = await API._request
        .postDio(API.cancleAppoint, body)
        .catchError(baseService.handleError);
    return res != null ? modelCancleAppointFromJson(res).resCode : '01';
  }

  Future<String> funPostponeAppoint(id) async {
    BaseService baseService = BaseService(context);
    final body = {"apmb_id": id.toString()};
    final res = await API._request
        .postDio(API.postponeAppoint, body)
        .catchError(baseService.handleError);
    return res != null ? modelPostponeAppointFromJson(res).resCode : '01';
  }

  Future<List<Object>?> funGetBanner(int type) async {
    BaseService baseService = BaseService(context);
    final res = await API._request
        .getDio(API.banner)
        .catchError(baseService.handleError);

    if (res != null) {
      final data = modelBannerFromJson(res);
      if (type == 1) {
        return data.resData?.articleCategory;
      } else {
        return data.resData?.banner;
      }
    } else {
      return null;
    }
  }
}
