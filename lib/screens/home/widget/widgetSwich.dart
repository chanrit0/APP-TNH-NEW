import 'package:app_tnh2/controller/api.dart';
import 'package:app_tnh2/screens/stores/authStore.dart';
import 'package:app_tnh2/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:app_tnh2/config/keyStorages.dart';
import 'package:flutter_switch/flutter_switch.dart';

class SwitchExample extends StatefulWidget {
  const SwitchExample({super.key});

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  bool onOffNoti = false;
  late Service postService;

  void onNoit(bool status) {
    if (status) {
      postService.funOnNoti('off').then((value) async => {
            if (value?.resCode == '00')
              {
                await accessTokenStore(
                    key: KeyStorages.onOffNotiStore,
                    action: "set",
                    value: 'off')
              }
          });
    } else {
      postService.funOnNoti('on').then((value) async => {
            if (value?.resCode == '00')
              {
                await accessTokenStore(
                    key: KeyStorages.onOffNotiStore, action: "set", value: 'on')
              }
          });
    }
  }

  void setOn() async {
    var statusNoti = await accessTokenStore(key: KeyStorages.onOffNotiStore);
    if (statusNoti != null) {
      setState(() {
        onOffNoti = statusNoti == 'on' ? false : true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setOn();
    postService = Service(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: accessTokenStore(key: KeyStorages.onOffNotiStore),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return FlutterSwitch(
            showOnOff: true,
            width: 55,
            height: 25,
            toggleSize: 25,
            value: onOffNoti,
            borderRadius: 40,
            padding: 0,
            activeToggleColor: const Color(0xff29989b),
            inactiveToggleColor: const Color(0xff29989b),
            activeColor: ColorDivider,
            inactiveColor: ColorDivider,
            activeIcon: const Image(
              image: AssetImage('assets/icons/OFF.png'),
              height: 10,
              width: 10,
            ),
            inactiveIcon: const Image(
              image: AssetImage('assets/icons/NO.png'),
              height: 10,
              width: 10,
            ),
            onToggle: (value) {
              onNoit(value);
              setState(() {
                onOffNoti = value;
              });
            },
          );
        }
        return FlutterSwitch(
          showOnOff: true,
          width: 55,
          height: 25,
          toggleSize: 25,
          value: onOffNoti,
          borderRadius: 40,
          padding: 0,
          activeToggleColor: const Color(0xff29989b),
          inactiveToggleColor: const Color(0xff29989b),
          activeColor: ColorDivider,
          inactiveColor: ColorDivider,
          activeIcon: const Image(
            image: AssetImage('assets/icons/OFF.png'),
            height: 10,
            width: 10,
          ),
          inactiveIcon: const Image(
            image: AssetImage('assets/icons/NO.png'),
            height: 10,
            width: 10,
          ),
          onToggle: (value) {
            onNoit(value);
            setState(() {
              onOffNoti = value;
            });
          },
        );
      },
    );
  }
}
