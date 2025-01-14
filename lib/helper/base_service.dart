import 'package:app_tnh2/styles/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:app_tnh2/helper/app_exceptions.dart';
import 'package:app_tnh2/controller/api.dart';
import 'package:app_tnh2/config/keyStorages.dart';
import 'package:app_tnh2/screens/stores/authStore.dart';

class BaseService {
  BuildContext context;
  late Service postService = Service(context: context);

  BaseService(this.context);
  static void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 5),
      content: Text(
        message,
        style: TextStyle(
            color: Colors.white, fontSize: font18, fontFamily: 'RSU_BOLD'),
      ),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void handleError(error) async {
    // for (var i = 0; i <= 0; i++) {
    if (error is BadRequestException) {
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(
      //       settings: const RouteSettings(name: 'TNH_SignIn_Screen'),
      //       builder: (BuildContext context) => const SignInScreen(
      //             statusSignIn: false,
      //             statusForgot: false,
      //           )),
      //   ModalRoute.withName('/'),
      // );
      showSnackBar(context, 'เกิดความผิดพลาด กรุณาเข้าสู่ระบบใหม่อีกครั้ง.');
      await accessTokenStore(key: KeyStorages.accessToken, action: "remove");
      await accessTokenStore(
        key: KeyStorages.refreshToken,
        action: "remove",
      );
      await accessTokenStore(key: KeyStorages.signInStatus, action: "remove");
    } else if (error is FetchDataException) {
      // ignore: use_build_context_synchronously
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(
      //       settings: const RouteSettings(name: 'TNH_SignIn_Screen'),
      //       builder: (BuildContext context) => const SignInScreen(
      //             statusSignIn: false,
      //             statusForgot: false,
      //           )),
      //   ModalRoute.withName('/'),
      // );
      // ignore: use_build_context_synchronously
      showSnackBar(context, 'เกิดความผิดพลาด กรุณาเข้าสู่ระบบใหม่อีกครั้ง.');
      await accessTokenStore(key: KeyStorages.accessToken, action: "remove");
      await accessTokenStore(
        key: KeyStorages.refreshToken,
        action: "remove",
      );
      await accessTokenStore(key: KeyStorages.signInStatus, action: "remove");
    } else if (error is UniAuthorizedException) {
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(
      //       settings: const RouteSettings(name: 'TNH_SignIn_Screen'),
      //       builder: (BuildContext context) => const SignInScreen(
      //             statusSignIn: false,
      //             statusForgot: false,
      //           )),
      //   ModalRoute.withName('/'),
      // );
      showSnackBar(context, 'เกิดความผิดพลาด กรุณาเข้าสู่ระบบใหม่อีกครั้ง.');
      await accessTokenStore(key: KeyStorages.accessToken, action: "remove");
      await accessTokenStore(
        key: KeyStorages.refreshToken,
        action: "remove",
      );
      await accessTokenStore(key: KeyStorages.signInStatus, action: "remove");
    } else if (error is ApiNotRespondingException) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, error.message);
    } else if (error is NoInternerConnection) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, 'เกิดความผิดพลาดในการเชื่อมต่ออินเตอร์เน็ต.');
    } else {
      showSnackBar(context, 'แล้วคุณจะรู้ว่าใคร!');
    }
    // }
  }
}
