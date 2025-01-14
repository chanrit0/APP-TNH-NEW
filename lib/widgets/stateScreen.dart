import 'package:app_tnh2/styles/colors.dart';
import 'package:flutter/material.dart';

class StateScreen extends StatelessWidget {
  final Widget? child;
  const StateScreen({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background@3x.png'),
                    fit: BoxFit.cover),
              ),
              child: SafeArea(
                  left: false,
                  right: false,
                  child: Container(
                    child: child,
                  ))),
        ),
      ],
    );
  }
}
