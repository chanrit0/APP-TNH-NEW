import 'package:app_tnh2/screens/home/home.dart';
import 'package:app_tnh2/screens/signIn/signIn.dart';
import 'package:app_tnh2/screens/stores/authStore.dart';
import 'package:flutter/material.dart';
import 'package:app_tnh2/config/keyStorages.dart';

class CheckAuth extends StatelessWidget {
  const CheckAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: accessTokenStore(key: KeyStorages.signInStatus),
        builder: (context, snapshot) {
          // print('signInStatus: ${snapshot.data}');
          if (snapshot.data != 'true') {
            return const SignInScreen(
              statusSignIn: false,
              statusForgot: false,
            );
          } else {
            return const HomeScreen(
              statusSignUp: false,
            );
          }
        });
  }
}
