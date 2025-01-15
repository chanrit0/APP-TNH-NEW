import 'package:app_tnh2/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'app_dialog.dart';

class AppLoading extends AppDialog {
  static void show(BuildContext context,
      {String? text, Widget? textWidget, Widget? icon}) {
    try {
      context.read<AppLoading>().showLoading(
            context,
            text: text,
            textWidget: textWidget,
            icon: icon,
          );
    } catch (e) {
      debugPrint('Error showing loading dialog: $e');
    }
  }

  static void hide(BuildContext context) {
    try {
      context.read<AppLoading>().hideAppDialog();
    } catch (e) {
      debugPrint('Error hiding loading dialog: $e');
    }
  }

  Future<void> showLoading(BuildContext context,
      {String? text, Widget? textWidget, Widget? icon}) async {
    try {
      await showAppDialog(
        context,
        Material(
          type: MaterialType.transparency,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                icon ??
                    const SpinKitRing(
                      color: ColorDefaultApp1,
                      size: 50.0,
                    ),
                const SizedBox(height: 16.0),
                if (textWidget != null)
                  textWidget
                else if (text != null)
                  Text(
                    text,
                    style: const TextStyle(
                      fontFamily: 'RSU_BOLD',
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  )
                else
                  const Text(
                    'Loading...',
                    style: TextStyle(
                      fontFamily: 'RSU_BOLD',
                      color: Colors.transparent,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          ),
        ),
      );
    } catch (e) {
      debugPrint('Error displaying loading dialog: $e');
    }
  }

  void hideLoading({bool isClean = false}) {
    try {
      hideAppDialog(isClean: isClean);
    } catch (e) {
      debugPrint('Error hiding loading dialog: $e');
    }
  }
}
